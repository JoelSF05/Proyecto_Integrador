package com.agricola.arroz.controller;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.repository.AsistenciaRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * ReporteController — endpoints para reportes de:
 *   - Riego por trabajador y por parcela
 *   - Tareas por tipo (transplante, saca, carga)
 *   - Resumen de planillas por período
 */
@RestController
@RequestMapping("/api/reportes")
public class ReporteController {

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    /**
     * Reporte de labores de riego en un rango de fechas.
     * GET /api/reportes/riego?desde=2026-05-01&hasta=2026-05-31
     */
    @GetMapping("/riego")
    public ResponseEntity<?> reporteRiego(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

        List<Asistencia> registros =
            asistenciaRepository.findByTipoTareaAndFecAsistBetween("RIEGO", desde, hasta);

        List<Map<String, Object>> resultado = registros.stream().map(a -> {
            Map<String, Object> fila = new LinkedHashMap<>();
            fila.put("fecha",      a.getFecAsist());
            fila.put("trabajador", a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
            fila.put("dni",        a.getTrabajador().getDniTrab());
            fila.put("tareas",     a.getTareasCompletadas());
            fila.put("horaEntrada", a.getHoraEntrada());
            fila.put("horaSalida",  a.getHoraSalida());
            fila.put("observacion", a.getObservacionSupervisor());
            fila.put("pagoTarea",   a.getTrabajador().getPagoPorTarea());
            return fila;
        }).collect(Collectors.toList());

        // Totales
        int totalTareas = registros.stream()
            .mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0).sum();

        Map<String, Object> respuesta = new LinkedHashMap<>();
        respuesta.put("periodo",     Map.of("desde", desde, "hasta", hasta));
        respuesta.put("totalRegistros", registros.size());
        respuesta.put("totalTareasRiego", totalTareas);
        respuesta.put("detalle",     resultado);

        return ResponseEntity.ok(respuesta);
    }

    /**
     * Reporte por tipo de tarea en un período.
     * GET /api/reportes/tareas?tipo=TRANSPLANTE&desde=...&hasta=...
     * Tipos: TRANSPLANTE, SACA, CARGA, RIEGO
     */
    @GetMapping("/tareas")
    public ResponseEntity<?> reporteTareas(
            @RequestParam String tipo,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

        List<Asistencia> registros =
            asistenciaRepository.findByTipoTareaAndFecAsistBetween(tipo.toUpperCase(), desde, hasta);

        Map<String, Object> respuesta = new LinkedHashMap<>();
        respuesta.put("tipoTarea",  tipo.toUpperCase());
        respuesta.put("periodo",    Map.of("desde", desde, "hasta", hasta));
        respuesta.put("totalRegistros", registros.size());
        respuesta.put("totalTareas",
            registros.stream().mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0).sum());

        List<Map<String, Object>> detalle = registros.stream().map(a -> {
            Map<String, Object> fila = new LinkedHashMap<>();
            fila.put("fecha",       a.getFecAsist());
            fila.put("trabajador",  a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
            fila.put("tareas",      a.getTareasCompletadas());
            fila.put("observacion", a.getObservacionSupervisor());
            return fila;
        }).collect(Collectors.toList());

        respuesta.put("detalle", detalle);
        return ResponseEntity.ok(respuesta);
    }

    /**
     * Resumen general de asistencias por tipo de pago en un período.
     * GET /api/reportes/resumen-labores?desde=...&hasta=...
     */
    @GetMapping("/resumen-labores")
    public ResponseEntity<?> resumenLabores(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

        List<Asistencia> todas =
            asistenciaRepository.findAll().stream()
                .filter(a -> !a.getFecAsist().isBefore(desde) && !a.getFecAsist().isAfter(hasta))
                .collect(Collectors.toList());

        // Agrupar por tipo de tarea
        Map<String, Long> porTarea = todas.stream()
            .filter(a -> a.getTipoTarea() != null)
            .collect(Collectors.groupingBy(Asistencia::getTipoTarea, Collectors.counting()));

        long sinTarea = todas.stream().filter(a -> a.getTipoTarea() == null).count();

        Map<String, Object> respuesta = new LinkedHashMap<>();
        respuesta.put("periodo",          Map.of("desde", desde, "hasta", hasta));
        respuesta.put("totalAsistencias", todas.size());
        respuesta.put("jornal",           sinTarea);
        respuesta.put("porTarea",         porTarea);
        respuesta.put("totalSacos",
            todas.stream().mapToInt(a -> a.getSacosCosechados() != null ? a.getSacosCosechados() : 0).sum());

        return ResponseEntity.ok(respuesta);
    }
}
