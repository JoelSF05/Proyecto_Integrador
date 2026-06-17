package com.agricola.arroz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.service.AsistenciaService;

@RestController
@RequestMapping("/api/asistencias")
public class AsistenciaController {

    private final AsistenciaService asistenciaService;

    public AsistenciaController(AsistenciaService asistenciaService) {
        this.asistenciaService = asistenciaService;
    }

    /**
     * GET /api/asistencias              → todas
     * GET /api/asistencias?tipoTarea=TRANSPLANTE → solo ese tipo
     */
    @GetMapping
    public ResponseEntity<List<Asistencia>> listarTodos(
            @RequestParam(required = false) String tipoTarea) {
        return ResponseEntity.ok(asistenciaService.listarTodos(tipoTarea));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Asistencia> buscarPorId(@PathVariable Integer id) {
        return ResponseEntity.ok(asistenciaService.buscarPorId(id));
        // Si no existe → GlobalExceptionHandler devuelve 400 con mensaje claro
    }

    @PostMapping
    public ResponseEntity<Asistencia> crear(@RequestBody Asistencia asistencia) {
        return ResponseEntity.ok(asistenciaService.crear(asistencia));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        asistenciaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/aprobar")
    public ResponseEntity<Asistencia> aprobar(@PathVariable Integer id) {
        return ResponseEntity.ok(asistenciaService.aprobar(id));
    }

    @PatchMapping("/{id}/observar")
    public ResponseEntity<Asistencia> observar(
            @PathVariable Integer id,
            @RequestBody(required = false) Map<String, String> body) {
        String motivo = body != null ? body.getOrDefault("motivo", "") : "";
        return ResponseEntity.ok(asistenciaService.observar(id, motivo));
    }
}
