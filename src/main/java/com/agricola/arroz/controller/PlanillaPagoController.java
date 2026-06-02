package com.agricola.arroz.controller;

import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.service.PlanillaPagoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/planillas")
public class PlanillaPagoController {

    @Autowired
    private PlanillaPagoService planillaService;

    /** Lista todas las planillas */
    @GetMapping
    public List<PlanillaPago> listarTodas() {
        return planillaService.listarTodas();
    }

    /** Lista planillas de un trabajador */
    @GetMapping("/trabajador/{idTrab}")
    public List<PlanillaPago> porTrabajador(@PathVariable Integer idTrab) {
        return planillaService.listarPorTrabajador(idTrab);
    }

    /** Lista planillas en un rango de fechas */
    @GetMapping("/periodo")
    public List<PlanillaPago> porPeriodo(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {
        return planillaService.listarPorPeriodo(desde, hasta);
    }

    /**
     * Genera una planilla para un trabajador en un período.
     * POST /api/planillas/generar
     * Body: { "idTrab": 5, "fechaInicio": "2026-05-01", "fechaFin": "2026-05-15" }
     */
    @PostMapping("/generar")
    public ResponseEntity<?> generar(@RequestBody Map<String, String> body) {
        try {
            Integer idTrab = Integer.parseInt(body.get("idTrab"));
            LocalDate inicio = LocalDate.parse(body.get("fechaInicio"));
            LocalDate fin    = LocalDate.parse(body.get("fechaFin"));
            PlanillaPago planilla = planillaService.generarPlanilla(idTrab, inicio, fin);
            return ResponseEntity.status(HttpStatus.CREATED).body(planilla);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /** Marca una planilla como pagada */
    @PatchMapping("/{id}/pagar")
    public ResponseEntity<?> pagar(@PathVariable Integer id) {
        try {
            return ResponseEntity.ok(planillaService.marcarPagado(id));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /** Anula una planilla */
    @PatchMapping("/{id}/anular")
    public ResponseEntity<?> anular(@PathVariable Integer id,
                                    @RequestBody(required = false) Map<String, String> body) {
        try {
            String motivo = body != null ? body.getOrDefault("motivo", "Sin motivo") : "Sin motivo";
            return ResponseEntity.ok(planillaService.anular(id, motivo));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}
