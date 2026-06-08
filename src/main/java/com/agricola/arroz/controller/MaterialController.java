package com.agricola.arroz.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Material;
import com.agricola.arroz.model.MovimientoMaterial;
import com.agricola.arroz.service.MaterialService;

import jakarta.validation.Valid;

/**
 * VERSIÓN MEJORADA de MaterialController
 * Cambios:
 * - Usa MaterialService
 * - Nuevo endpoint para actualizar stock con observación
 * - Nuevo endpoint para ver historial de movimientos
 * - Nuevo endpoint para ver stock bajo
 * - Soft delete
 */
@RestController
@RequestMapping("/api/materiales")
public class MaterialController {

    @Autowired
    private MaterialService materialService;

    @GetMapping
    public List<Material> listarTodos() {
        return materialService.listarActivos();
    }

    @GetMapping("/stock-bajo")
    public List<Material> listarStockBajo() {
        return materialService.listarStockBajo();
    }

    @PostMapping
    public ResponseEntity<?> crear(@Valid @RequestBody Material material) {
        try {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(materialService.crear(material));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(
            @PathVariable Integer id,
            @Valid @RequestBody Material material) {
        try {
            return ResponseEntity.ok(materialService.actualizar(id, material));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    /**
     * NUEVO: Actualizar solo el stock, con observación registrada
     * Ejemplo: PUT /api/materiales/3/stock
     * Body: { "nuevoStock": 150.5, "observacion": "Compra a proveedor XYZ" }
     */
    @PutMapping("/{id}/stock")
    public ResponseEntity<?> actualizarStock(
            @PathVariable Integer id,
            @RequestBody Map<String, Object> body) {
        try {
            BigDecimal nuevoStock = new BigDecimal(body.get("nuevoStock").toString());
            String observacion = (String) body.getOrDefault("observacion", "");
            Material mat = materialService.actualizarStock(id, nuevoStock, observacion);
            return ResponseEntity.ok(mat);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    /**
     * NUEVO: Ver historial de movimientos de un material
     * Ejemplo: GET /api/materiales/3/movimientos
     */
    @GetMapping("/{id}/movimientos")
    public ResponseEntity<?> verMovimientos(@PathVariable Integer id) {
        try {
            List<MovimientoMaterial> movs = materialService.verMovimientos(id);
            return ResponseEntity.ok(movs);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        try {
            materialService.eliminar(id);
            return ResponseEntity.ok(Map.of("mensaje", "Material desactivado correctamente"));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/uso")
    public ResponseEntity<?> registrarUso(@RequestBody Map<String, Object> payload) {
        try {
            Integer idMat = Integer.valueOf(payload.get("idMat").toString());
            Integer idHect = Integer.valueOf(payload.get("idHect").toString());
            BigDecimal cantidad = new BigDecimal(payload.get("cantidad").toString());
            String fecUso = payload.get("fecUso").toString();
            String horaUso = payload.get("horaUso").toString();
            String detalleUso = (String) payload.getOrDefault("detalleUso", "");

            materialService.registrarUso(idMat, idHect, fecUso, horaUso, cantidad, detalleUso);
            
            return ResponseEntity.ok(Map.of("mensaje", "Uso registrado y stock actualizado correctamente"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Fallo al registrar uso: " + e.getMessage()));
        }
    }
}
