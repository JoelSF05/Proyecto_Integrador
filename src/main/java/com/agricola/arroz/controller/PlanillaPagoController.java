package com.agricola.arroz.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.service.PlanillaPagoService;

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
    public ResponseEntity<?> generar(@RequestBody Map<String, Object> body) {
        try {
            if (body == null) {
                throw new RuntimeException("Solicitud inválida");
            }
            String inicioRaw = body.get("fechaInicio") != null ? body.get("fechaInicio").toString() : null;
            String finRaw = body.get("fechaFin") != null ? body.get("fechaFin").toString() : null;
            if (inicioRaw == null || finRaw == null) {
                throw new RuntimeException("Los campos fechaInicio y fechaFin son requeridos");
            }
            LocalDate inicio = LocalDate.parse(inicioRaw);
            LocalDate fin = LocalDate.parse(finRaw);

            Integer idTrab = body.containsKey("idTrab") && body.get("idTrab") != null
                    ? Integer.valueOf(body.get("idTrab").toString())
                    : null;

            if (idTrab == null) {
                planillaService.generarPlanillasPeriodo(inicio, fin);
                return ResponseEntity.ok(Map.of("mensaje", "Planillas procesadas para el periodo"));
            }

            PlanillaPago planilla = planillaService.generarPlanilla(idTrab, inicio, fin);
            return ResponseEntity.status(HttpStatus.CREATED).body(planilla);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    /** Obtiene una planilla por su id */
    @GetMapping("/{id}")
    public ResponseEntity<?> obtener(@PathVariable Integer id) {
        try {
            return ResponseEntity.ok(planillaService.listarPorId(id));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    /** Marca una planilla como pagada */
    @PatchMapping("/{id}/pagar")
    public ResponseEntity<?> pagar(@PathVariable Integer id) {
        try {
            PlanillaPago planillaPagada = planillaService.marcarPagado(id);
            return ResponseEntity.ok(planillaPagada);
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
