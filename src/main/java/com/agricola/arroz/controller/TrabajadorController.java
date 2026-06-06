package com.agricola.arroz.controller;

import com.agricola.arroz.model.Cargo;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.repository.CargoRepository;
import com.agricola.arroz.service.TrabajadorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * VERSIÓN MEJORADA de TrabajadorController
 * Cambios:
 *  - Usa TrabajadorService en vez de repository directamente
 *  - Retorna ResponseEntity con mensajes de error claros
 *  - Soft delete (no borra físicamente)
 *  - @Valid para validaciones automáticas del modelo
 */
@RestController
@RequestMapping("/api/trabajadores")
public class TrabajadorController {

    @Autowired
    private TrabajadorService trabajadorService;

    @Autowired
    private CargoRepository cargoRepository;

    @GetMapping
    public List<Trabajador> listarTodos() {
        return trabajadorService.listarActivos();
    }

    // Filtra trabajadores activos por tipo de pago: transplante, saca, carga, riego
    @GetMapping("/tipo/{tipo}")
    public ResponseEntity<?> listarPorTipo(@PathVariable String tipo) {
        try {
            TipoPago tipoPago = TipoPago.valueOf(tipo.toLowerCase());
            return ResponseEntity.ok(trabajadorService.listarPorTipoPago(tipoPago));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                .body(Map.of("error", "Tipo de pago no válido: " + tipo));
        }
    }

    @GetMapping("/cargos")
    public List<Cargo> listarCargos() {
        return cargoRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Integer id) {
        try {
            return ResponseEntity.ok(trabajadorService.buscarPorId(id));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping("/dni/{dni}")
    public ResponseEntity<?> buscarPorDni(@PathVariable String dni) {
        try {
            return ResponseEntity.ok(trabajadorService.buscarPorDni(dni));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping
    public ResponseEntity<?> crear(@Valid @RequestBody Trabajador trabajador) {
        try {
            return ResponseEntity.status(HttpStatus.CREATED)
                .body(trabajadorService.crear(trabajador));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(
            @PathVariable Integer id,
            @Valid @RequestBody Trabajador trabajador) {
        try {
            return ResponseEntity.ok(trabajadorService.actualizar(id, trabajador));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("error", e.getMessage()));
        }
    }

    // Soft delete: no borra, marca como inactivo
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        try {
            trabajadorService.eliminar(id);
            return ResponseEntity.ok(Map.of("mensaje", "Trabajador desactivado correctamente"));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(Map.of("error", e.getMessage()));
        }
    }
}
