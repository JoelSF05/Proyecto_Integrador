package com.agricola.arroz.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Area;
import com.agricola.arroz.model.Material;
import com.agricola.arroz.model.MovimientoMaterial;
import com.agricola.arroz.model.UsoMaterial;
import com.agricola.arroz.repository.AreaRepository;
import com.agricola.arroz.repository.MaterialRepository;
import com.agricola.arroz.repository.MovimientoMaterialRepository;
import com.agricola.arroz.repository.UsoMaterialRepository;

@Service
public class MaterialService {

    @Autowired
    private MaterialRepository materialRepository;

    @Autowired
    private MovimientoMaterialRepository movimientoRepository;

    @Autowired
    private UsoMaterialRepository usoMaterialRepository;

    @Autowired
    private AreaRepository areaRepository;

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

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

    // Actualizar stock y dejar que el trigger de la base de datos registre
    // un único movimiento por cambio real de stock.
    @Transactional
    public MovimientoMaterial actualizarStock(Integer id, BigDecimal nuevoStock, String observacion) {
        Material mat = materialRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Material no encontrado: " + id));

        BigDecimal stockAnterior = mat.getStockActual() != null ? mat.getStockActual() : BigDecimal.ZERO;
        BigDecimal cambio = nuevoStock.subtract(stockAnterior);

        if (nuevoStock.compareTo(BigDecimal.ZERO) < 0) {
            throw new RuntimeException("Error: Stock insuficiente. El stock no puede ser negativo.");
        }

        // Si hubo un cambio real, registramos el movimiento explícitamente
        if (cambio.compareTo(BigDecimal.ZERO) != 0) {
            MovimientoMaterial movimiento = new MovimientoMaterial();
            movimiento.setMaterial(mat);
            movimiento.setFechaMovimiento(LocalDateTime.now(PERU_ZONE)); // Usar hora de Perú
            movimiento.setCantidad(cambio.abs());
            movimiento.setTipoMovimiento(cambio.compareTo(BigDecimal.ZERO) > 0 ? "ENTRADA" : "SALIDA");
            movimiento.setStockAnterior(stockAnterior);
            movimiento.setStockNuevo(nuevoStock);
            movimiento.setObservacion(observacion);
            return movimientoRepository.save(movimiento);
        }

        mat.setStockActual(nuevoStock);
        materialRepository.save(mat);
        return null; // No hubo movimiento que devolver
    }

    /**
     * Registra el uso de un material en una parcela y disminuye el stock.
     */
    @Transactional
    public void registrarUso(Integer idMat, Integer idArea, String fecha, String hora, BigDecimal cantidad,
            String detalle) {
        Material mat = materialRepository.findById(idMat)
                .orElseThrow(() -> new RuntimeException("Material no encontrado"));

        Area area = areaRepository.findById(idArea)
                .orElseThrow(() -> new RuntimeException("Área no encontrada"));

        // Construir la observación
        String observacionFinal;
        if (detalle != null && !detalle.trim().isEmpty()) {
            observacionFinal = String.format("%s (Área: %s)", detalle, area.getNombreArea());
        } else {
            observacionFinal = String.format("Uso en campo (%s)", area.getNombreArea());
        }

        // 1. Actualizar stock y obtener el movimiento generado
        BigDecimal nuevoStock = mat.getStockActual().subtract(cantidad);
        if (nuevoStock.compareTo(BigDecimal.ZERO) < 0) {
            throw new RuntimeException("Error: Stock insuficiente. El stock no puede ser negativo.");
        }

        MovimientoMaterial movimiento = new MovimientoMaterial();
        movimiento.setMaterial(mat);
        movimiento.setFechaMovimiento(LocalDateTime.now(PERU_ZONE));
        movimiento.setCantidad(cantidad);
        movimiento.setTipoMovimiento("SALIDA");
        movimiento.setStockAnterior(mat.getStockActual());
        movimiento.setStockNuevo(nuevoStock);
        movimiento.setObservacion(observacionFinal);
        movimientoRepository.save(movimiento);

        // Actualizar el stock en la entidad Material
        mat.setStockActual(nuevoStock);
        materialRepository.save(mat);

        // 2. Crear y guardar el registro de uso, vinculándolo al movimiento
        UsoMaterial uso = new UsoMaterial();
        uso.setMaterial(mat);
        uso.setArea(area); // Asignamos la instancia de Area ya recuperada
        uso.setFechaUso(LocalDate.parse(fecha));
        uso.setHoraUso(LocalTime.parse(hora));
        uso.setCantidad(cantidad);
        uso.setDetalleUso(detalle);
        usoMaterialRepository.save(uso);
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
            actualizarStock(id, datoNuevo.getStockActual(), "Edición de material");
            return materialRepository.findById(id).get();
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
