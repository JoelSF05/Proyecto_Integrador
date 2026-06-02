package com.agricola.arroz.service;

import com.agricola.arroz.model.Material;
import com.agricola.arroz.model.MovimientoMaterial;
import com.agricola.arroz.repository.MaterialRepository;
import com.agricola.arroz.repository.MovimientoMaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

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
            throw new RuntimeException("El stock no puede ser negativo");
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
