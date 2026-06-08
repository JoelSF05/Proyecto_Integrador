package com.agricola.arroz.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Material;
import com.agricola.arroz.model.MovimientoMaterial;
import com.agricola.arroz.repository.MaterialRepository;
import com.agricola.arroz.repository.MovimientoMaterialRepository;

/**
 * NUEVO: MaterialService
 * Reemplaza la lógica directa en el Controller.
 * Maneja reglas de negocio y registra movimientos.
 */
@Service
public class MaterialService {

    @Autowired
    private MaterialRepository materialRepository;

    @Autowired
    private MovimientoMaterialRepository movimientoRepository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Listar solo materiales activos
    public List<Material> listarActivos() {
        return materialRepository.findByActivoTrue();
    }

    // Listar todos (incluso inactivos)
    public List<Material> listarTodos() {
        return materialRepository.findAll();
    }

    // Crear material nuevo
    @Transactional
    public Material crear(Material material) {
        // Validación de negocio
        if (material.getStockActual() == null) {
            material.setStockActual(BigDecimal.ZERO);
        }
        if (material.getStockMinimo() == null) {
            material.setStockMinimo(BigDecimal.ZERO);
        }
        return materialRepository.save(material);
    }

    // Actualizar stock - registra movimiento automáticamente en Java
    // (el trigger SQL también lo hace como respaldo)
    @Transactional
    public Material actualizarStock(Integer id, BigDecimal nuevoStock, String observacion) {
        Material mat = materialRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Material no encontrado: " + id));

        BigDecimal stockAnterior = mat.getStockActual();

        if (nuevoStock.compareTo(BigDecimal.ZERO) < 0) {
            throw new RuntimeException("Error: Stock insuficiente. El stock no puede ser negativo.");
        }

        // Registrar movimiento en Java (doble seguridad con el trigger SQL)
        MovimientoMaterial mov = new MovimientoMaterial();
        mov.setMaterial(mat);
        mov.setCantidad(nuevoStock.subtract(stockAnterior).abs());
        mov.setStockAnterior(stockAnterior);
        mov.setStockNuevo(nuevoStock);
        mov.setObservacion(observacion != null ? observacion : "Actualización manual");

        if (nuevoStock.compareTo(stockAnterior) > 0) {
            mov.setTipoMovimiento("ENTRADA");
        } else if (nuevoStock.compareTo(stockAnterior) < 0) {
            mov.setTipoMovimiento("SALIDA");
        } else {
            mov.setTipoMovimiento("AJUSTE");
        }

        mat.setStockActual(nuevoStock);
        materialRepository.save(mat);
        movimientoRepository.save(mov);

        return mat;
    }

    /**
     * Registra el uso de un material en una parcela y disminuye el stock.
     */
    @Transactional
    public void registrarUso(Integer idMat, Integer idHect, String fecha, String hora, BigDecimal cantidad, String detalle) {
        Material mat = materialRepository.findById(idMat)
            .orElseThrow(() -> new RuntimeException("Material no encontrado"));

        // 1. Disminuir el stock (esto también crea un registro en movimientos_material automáticamente)
        BigDecimal nuevoStock = mat.getStockActual().subtract(cantidad);
        actualizarStock(idMat, nuevoStock, "Uso en campo: " + detalle);

        // 2. Insertar en la tabla uso_materiales para seguimiento agronómico
        String sql = "INSERT INTO uso_materiales (id_mat, id_hect, fec_uso, hora_uso, cantidad, detalle_uso) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, idMat, idHect, java.sql.Date.valueOf(fecha), java.sql.Time.valueOf(hora), cantidad, detalle);
    }

    // Actualizar datos generales del material
    @Transactional
    public Material actualizar(Integer id, Material datoNuevo) {
        Material mat = materialRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Material no encontrado: " + id));

        mat.setNomMat(datoNuevo.getNomMat());
        mat.setTipoMat(datoNuevo.getTipoMat());
        mat.setUnidadMedida(datoNuevo.getUnidadMedida());
        mat.setStockMinimo(datoNuevo.getStockMinimo());

        // Si el stock cambió, registrar movimiento
        if (datoNuevo.getStockActual() != null &&
            !datoNuevo.getStockActual().equals(mat.getStockActual())) {
            return actualizarStock(id, datoNuevo.getStockActual(), "Edición de material");
        }

        return materialRepository.save(mat);
    }

    // Soft delete (no borra físicamente)
    @Transactional
    public void eliminar(Integer id) {
        Material mat = materialRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Material no encontrado: " + id));
        mat.setActivo(false);
        materialRepository.save(mat);
    }

    // Ver historial de movimientos de un material
    public List<MovimientoMaterial> verMovimientos(Integer idMaterial) {
        return movimientoRepository.findByMaterialIdMatOrderByFechaMovimientoDesc(idMaterial);
    }

    // Listar materiales con stock bajo
    public List<Material> listarStockBajo() {
        return materialRepository.findStockBajo();
    }
}
