package com.agricola.arroz.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.model.MovimientoCaja;
import com.agricola.arroz.model.MovimientoMaterial;
import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.repository.AsistenciaRepository;
import com.agricola.arroz.repository.MovimientoCajaRepository;
import com.agricola.arroz.repository.MovimientoMaterialRepository;
import com.agricola.arroz.repository.PlanillaPagoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import com.agricola.arroz.repository.UsuarioRepository;
import com.agricola.arroz.service.ReportePdfService;

/**
 * ReporteController — endpoints para reportes de:
 * - Riego por trabajador y por parcela
 * - Tareas por tipo (transplante, saca, carga)
 * - Resumen de planillas por período
 */
@RestController
@RequestMapping("/api/reportes")
public class ReporteController {

        @Autowired
        private AsistenciaRepository asistenciaRepository;

        @Autowired
        private TrabajadorRepository trabajadorRepository;

        @Autowired
        private PlanillaPagoRepository planillaRepository;

        @Autowired
        private MovimientoCajaRepository movimientoCajaRepository;

        @Autowired
        private MovimientoMaterialRepository movimientoMaterialRepository;

        @Autowired
        private UsuarioRepository usuarioRepository;

        @Autowired
        private ReportePdfService pdfService;

        private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

        /**
         * Reporte de labores de riego en un rango de fechas.
         * GET /api/reportes/riego?desde=2026-05-01&hasta=2026-05-31
         */
        @GetMapping("/riego")
        public ResponseEntity<?> reporteRiego(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<Asistencia> registros = asistenciaRepository
                                .findByTipoTareaAndFecAsistBetween("RIEGO", desde, hasta)
                                .stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                .collect(Collectors.toList());

                List<Map<String, Object>> resultado = registros.stream().map(a -> {
                        Map<String, Object> fila = new LinkedHashMap<>();
                        fila.put("fecha", a.getFecAsist());
                        fila.put("trabajador", a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
                        fila.put("dni", a.getTrabajador().getDniTrab());
                        fila.put("tareas", a.getTareasCompletadas());
                        fila.put("horaEntrada", a.getHoraEntrada());
                        fila.put("horaSalida", a.getHoraSalida());
                        fila.put("observacion", a.getObservacionSupervisor());
                        return fila;
                }).collect(Collectors.toList());

                // Totales
                int totalTareas = registros.stream()
                                .mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0).sum();

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("periodo", Map.of("desde", desde, "hasta", hasta));
                respuesta.put("totalRegistros", registros.size());
                respuesta.put("totalTareasRiego", totalTareas);
                respuesta.put("detalle", resultado);

                return ResponseEntity.ok(respuesta);
        }

        @GetMapping("/riego/pdf")
        public ResponseEntity<byte[]> reporteRiegoPdf(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<Asistencia> registros = asistenciaRepository
                                .findByTipoTareaAndFecAsistBetween("RIEGO", desde, hasta)
                                .stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                .collect(Collectors.toList());

                byte[] pdfBytes = pdfService.generarPdfRiego(registros, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Reporte_Riego.pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/asistencia-general/pdf")
        public ResponseEntity<byte[]> reporteAsistenciaGeneralPdf(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                // Los registros ahora se guardan directamente con la fecha de Perú
                // (America/Lima)
                List<Asistencia> registros = asistenciaRepository.findByFecAsistBetween(desde, hasta).stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                // Regla: Solo registros con entrada Y salida
                                .filter(a -> a.getHoraEntrada() != null && a.getHoraSalida() != null)
                                .collect(Collectors.toList());

                byte[] pdfBytes = pdfService.generarPdfAsistenciaGeneral(registros, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=Reporte_Asistencia_General.pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
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

                List<Asistencia> registros = asistenciaRepository
                                .findByTipoTareaAndFecAsistBetween(tipo.toUpperCase(), desde, hasta)
                                .stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                .collect(Collectors.toList());

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("tipoTarea", tipo.toUpperCase());
                respuesta.put("periodo", Map.of("desde", desde, "hasta", hasta));
                respuesta.put("totalRegistros", registros.size());
                respuesta.put("totalTareas",
                                registros.stream().mapToInt(
                                                a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0)
                                                .sum());

                List<Map<String, Object>> detalle = registros.stream().map(a -> {
                        Map<String, Object> fila = new LinkedHashMap<>();
                        fila.put("fecha", a.getFecAsist());
                        fila.put("trabajador", a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
                        fila.put("dni", a.getTrabajador().getDniTrab());
                        fila.put("tareas", a.getTareasCompletadas());
                        fila.put("observacion", a.getObservacionSupervisor());
                        return fila;
                }).collect(Collectors.toList());

                respuesta.put("detalle", detalle);
                return ResponseEntity.ok(respuesta);
        }

        @GetMapping("/tareas/pdf")
        public ResponseEntity<byte[]> reporteTareasPdf(
                        @RequestParam String tipo,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<Asistencia> registros = asistenciaRepository
                                .findByTipoTareaAndFecAsistBetween(tipo.toUpperCase(), desde, hasta)
                                .stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                .collect(Collectors.toList());

                byte[] pdfBytes = pdfService.generarPdfTareas(registros, tipo, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=Reporte_Tareas_" + tipo + ".pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        /**
         * Resumen general de asistencias por tipo de pago en un período.
         * GET /api/reportes/resumen-labores?desde=...&hasta=...
         */
        @GetMapping("/resumen-labores")
        public ResponseEntity<?> resumenLabores(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta,
                        @RequestParam(required = false) String tipo) {

                List<Asistencia> todas = asistenciaRepository.findByFecAsistBetween(desde, hasta).stream()
                                .filter(a -> {
                                        if (tipo == null || tipo.isEmpty())
                                                return true;
                                        if (a.getTrabajador() == null || a.getTrabajador().getTipoPago() == null)
                                                return false;
                                        com.agricola.arroz.model.TipoPago tp = a.getTrabajador().getTipoPago();
                                        return tp.name().equalsIgnoreCase(tipo);
                                })
                                .collect(Collectors.toList());

                // Agrupar por tipo de tarea
                Map<String, Long> porTarea = todas.stream()
                                .filter(a -> a.getTipoTarea() != null)
                                .collect(Collectors.groupingBy(Asistencia::getTipoTarea,
                                                Collectors.summingLong(a -> (a.getTareasCompletadas() != null
                                                                && a.getTareasCompletadas() > 0)
                                                                                ? a.getTareasCompletadas()
                                                                                : 1)));

                long jornal = todas.stream()
                                .filter(a -> a.getTipoTarea() == null
                                                && (a.getSacosCosechados() == null || a.getSacosCosechados() == 0))
                                .mapToLong(a -> (a.getTareasCompletadas() != null && a.getTareasCompletadas() > 0)
                                                ? a.getTareasCompletadas()
                                                : 1)
                                .sum();

                long actividadesSaco = todas.stream()
                                .filter(a -> a.getTipoTarea() == null && a.getSacosCosechados() != null
                                                && a.getSacosCosechados() > 0)
                                .count();

                int totalSacos = todas.stream()
                                .mapToInt(a -> a.getSacosCosechados() != null ? a.getSacosCosechados() : 0)
                                .sum();

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("periodo", Map.of("desde", desde, "hasta", hasta));
                respuesta.put("totalAsistencias", todas.size());
                respuesta.put("jornal", jornal);
                respuesta.put("porSaco", actividadesSaco);
                respuesta.put("porTarea", porTarea);
                respuesta.put("totalSacos", totalSacos);

                return ResponseEntity.ok(respuesta);
        }

        @GetMapping("/resumen-labores/pdf")
        public ResponseEntity<byte[]> resumenLaboresPdf(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta,
                        @RequestParam(required = false) String tipo) {

                // Solo incluimos en el PDF los trabajadores que tengan su planilla en estado
                // 'pagado' para este periodo
                Set<Integer> idsPagados = planillaRepository
                                .findByFechaInicioBetweenOrderByFechaInicioDesc(desde, hasta)
                                .stream()
                                .filter(p -> "pagado".equalsIgnoreCase(p.getEstado()))
                                .filter(p -> p.getTrabajador() != null && p.getTrabajador().getActivo())
                                .filter(p -> {
                                        if (tipo == null || tipo.isEmpty())
                                                return true;
                                        if (p.getTrabajador() == null || p.getTrabajador().getTipoPago() == null)
                                                return false;
                                        com.agricola.arroz.model.TipoPago tp = p.getTrabajador().getTipoPago();
                                        return tp.name().equalsIgnoreCase(tipo);
                                })
                                .map(p -> p.getTrabajador().getIdTrab())
                                .collect(Collectors.toSet());

                List<Asistencia> todas = asistenciaRepository.findByFecAsistBetween(desde, hasta).stream()
                                .filter(a -> a.getTrabajador() != null && a.getTrabajador().getActivo())
                                .filter(a -> {
                                        if (tipo == null || tipo.isEmpty())
                                                return true;
                                        if (a.getTrabajador() == null || a.getTrabajador().getTipoPago() == null)
                                                return false;
                                        com.agricola.arroz.model.TipoPago tp = a.getTrabajador().getTipoPago();
                                        return tp.name().equalsIgnoreCase(tipo);
                                })
                                .filter(a -> a.getTrabajador() != null
                                                && idsPagados.contains(a.getTrabajador().getIdTrab()))
                                .collect(Collectors.toList());

                byte[] pdfBytes = pdfService.generarPdfResumen(todas, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Resumen_Labores.pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/materiales")
        public ResponseEntity<?> reporteMateriales(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                LocalDateTime inicio = desde.atStartOfDay();
                LocalDateTime fin = hasta.atTime(LocalTime.MAX);

                List<MovimientoMaterial> movimientos = movimientoMaterialRepository
                                .findByFechaMovimientoBetweenOrderByFechaMovimientoDesc(inicio, fin);

                BigDecimal entradas = movimientos.stream()
                                .filter(m -> "ENTRADA".equalsIgnoreCase(m.getTipoMovimiento()))
                                .map(MovimientoMaterial::getCantidad)
                                .filter(m -> m != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                BigDecimal salidas = movimientos.stream()
                                .filter(m -> "SALIDA".equalsIgnoreCase(m.getTipoMovimiento()))
                                .map(MovimientoMaterial::getCantidad)
                                .filter(m -> m != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                List<Map<String, Object>> detalle = movimientos.stream().map(m -> {
                        Map<String, Object> fila = new LinkedHashMap<>();
                        fila.put("id", m.getIdMovimiento());
                        // CORRECTO: Formatear fecha y hora como texto simple para evitar errores de
                        // "Invalid Date" en el frontend.
                        LocalDateTime fechaHora = m.getFechaMovimiento();
                        fila.put("fecha",
                                        fechaHora != null
                                                        ? fechaHora.toLocalDate().format(
                                                                        DateTimeFormatter.ofPattern("dd/MM/yyyy"))
                                                        : "-");

                        fila.put("hora", fechaHora != null ? fechaHora.format(DateTimeFormatter.ofPattern("HH:mm:ss"))
                                        : "-");
                        fila.put("material", m.getMaterial() != null ? m.getMaterial().getNomMat() : "-");
                        fila.put("tipo", m.getTipoMovimiento());
                        fila.put("cantidad", m.getCantidad());
                        fila.put("unidad", m.getMaterial() != null ? m.getMaterial().getUnidadMedida() : "-");
                        fila.put("observacion", m.getObservacion());
                        return fila;
                }).collect(Collectors.toList());

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("periodo", Map.of("desde", desde, "hasta", hasta));
                respuesta.put("totalMovimientos", movimientos.size());
                respuesta.put("totalEntradas", entradas);
                respuesta.put("totalSalidas", salidas);
                respuesta.put("detalle", detalle);

                return ResponseEntity.ok(respuesta);
        }

        @GetMapping("/materiales/pdf")
        public ResponseEntity<byte[]> reporteMaterialesPdf(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                LocalDateTime inicio = desde.atStartOfDay();
                LocalDateTime fin = hasta.atTime(LocalTime.MAX);
                List<MovimientoMaterial> movimientos = movimientoMaterialRepository
                                .findByFechaMovimientoBetweenOrderByFechaMovimientoDesc(inicio, fin);
                byte[] pdfBytes = pdfService.generarPdfMateriales(movimientos, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=Reporte_Uso_Materiales.pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/caja")
        public ResponseEntity<?> reporteCaja(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<MovimientoCaja> movimientos = movimientoCajaRepository.findByFechaBetweenOrderByFechaDesc(desde,
                                hasta);

                BigDecimal ingresos = movimientos.stream()
                                .filter(m -> "Ingreso".equalsIgnoreCase(m.getTipo()))
                                .map(MovimientoCaja::getMonto)
                                .filter(m -> m != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                BigDecimal egresos = movimientos.stream()
                                .filter(m -> "Egreso".equalsIgnoreCase(m.getTipo()))
                                .map(MovimientoCaja::getMonto)
                                .filter(m -> m != null)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                // Calcular el saldo total histórico de la base de datos
                BigDecimal saldoTotal = movimientoCajaRepository.findAll().stream()
                                .map(m -> {
                                        BigDecimal monto = m.getMonto() != null ? m.getMonto() : BigDecimal.ZERO;
                                        return "Ingreso".equalsIgnoreCase(m.getTipo()) ? monto : monto.negate();
                                })
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                List<Map<String, Object>> detalle = movimientos.stream().map(m -> {
                        Map<String, Object> fila = new LinkedHashMap<>();
                        fila.put("id", m.getId());
                        fila.put("fecha", m.getFecha());
                        fila.put("tipo", m.getTipo());
                        fila.put("categoria", m.getCategoria());
                        fila.put("descripcion", m.getDesc());
                        fila.put("monto", m.getMonto());
                        return fila;
                }).collect(Collectors.toList());

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("periodo", Map.of("desde", desde, "hasta", hasta));
                respuesta.put("totalMovimientos", movimientos.size());
                respuesta.put("totalIngresos", ingresos);
                respuesta.put("totalEgresos", egresos);
                respuesta.put("saldo", saldoTotal); // Usar el saldo total histórico
                respuesta.put("detalle", detalle);

                return ResponseEntity.ok(respuesta);
        }

        @GetMapping("/caja/pdf")
        public ResponseEntity<byte[]> reporteCajaPdf(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<MovimientoCaja> movimientos = movimientoCajaRepository.findByFechaBetweenOrderByFechaDesc(desde,
                                hasta);
                List<MovimientoCaja> saldoBase = movimientoCajaRepository.findAllByOrderByFechaDesc();
                byte[] pdfBytes = pdfService.generarPdfCaja(movimientos, saldoBase, desde, hasta);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=Reporte_Caja.pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/planilla/{id}/pdf")
        public ResponseEntity<byte[]> planillaIndividualPdf(@PathVariable Integer id) {
                PlanillaPago planilla = planillaRepository.findById(id)
                                .orElseThrow(() -> new RuntimeException("Planilla no encontrada"));

                if (planilla.getTrabajador() != null && !planilla.getTrabajador().getActivo()) {
                        throw new RuntimeException("No se puede generar PDF para un trabajador inactivo");
                }

                List<Asistencia> detalles = asistenciaRepository.findByTrabajadorIdTrabAndFecAsistBetween(
                                planilla.getTrabajador().getIdTrab(), planilla.getFechaInicio(),
                                planilla.getFechaFin());

                byte[] pdfBytes = pdfService.generarPdfBoletaPago(planilla, detalles);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=Boleta_Pago_" + id + ".pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/asistencia/{id}/pdf")
        public ResponseEntity<byte[]> boletaActividadPdf(@PathVariable Integer id) {
                Asistencia a = asistenciaRepository.findById(id)
                                .orElseThrow(() -> new RuntimeException("Asistencia no encontrada"));

                byte[] pdfBytes = pdfService.generarPdfBoletaActividad(a);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=Boleta_Labor_" + id + ".pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        @GetMapping("/detalles-trabajador")
        public ResponseEntity<?> detallesTrabajador(
                        @RequestParam Integer idTrab,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                List<Asistencia> asistencias = asistenciaRepository.findByTrabajadorIdTrabAndFecAsistBetween(idTrab,
                                desde,
                                hasta);

                List<Map<String, Object>> detalle = asistencias.stream().map(a -> {
                        Map<String, Object> fila = new LinkedHashMap<>();
                        fila.put("id", a.getIdAsist());
                        fila.put("fecha", a.getFecAsist());
                        fila.put("trabajador", a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab());
                        fila.put("actividad", a.getTipoTarea() != null ? a.getTipoTarea() : "JORNAL");
                        int cant = (a.getTareasCompletadas() != null && a.getTareasCompletadas() > 0)
                                        ? a.getTareasCompletadas()
                                        : (a.getSacosCosechados() != null ? a.getSacosCosechados() : 1);

                        com.agricola.arroz.model.TipoPago tp = a.getTrabajador().getTipoPago();
                        BigDecimal tarifa = BigDecimal.ZERO;
                        if (tp != null) {
                                if (tp.esPorJornal())
                                        tarifa = a.getTrabajador().getSueldoBaseDia();
                                else if (tp.esPorSaco())
                                        tarifa = a.getTrabajador().getPagoPorSaco();
                                else if (tp.esPorTarea())
                                        tarifa = a.getTrabajador().getPagoPorTarea();
                        }
                        if (tarifa == null)
                                tarifa = BigDecimal.ZERO;

                        fila.put("cantidad", cant);
                        fila.put("tarifa", tarifa);
                        fila.put("subtotal", tarifa.multiply(BigDecimal.valueOf(cant)));
                        return fila;
                }).collect(Collectors.toList());

                return ResponseEntity.ok(detalle);
        }

        /**
         * Genera un PDF con el código QR del trabajador para su impresión.
         */
        @GetMapping("/trabajador/{id}/qr/pdf")
        public ResponseEntity<byte[]> trabajadorQrPdf(@PathVariable Integer id) {
                Trabajador t = trabajadorRepository.findById(id)
                                .orElseThrow(() -> new RuntimeException("Trabajador no encontrado"));

                byte[] pdfBytes = pdfService.generarPdfQrTrabajador(t);

                return ResponseEntity.ok()
                                .header(HttpHeaders.CONTENT_DISPOSITION,
                                                "attachment; filename=QR_" + t.getDniTrab() + ".pdf")
                                .contentType(MediaType.APPLICATION_PDF)
                                .body(pdfBytes);
        }

        /**
         * Retorna la asistencia del usuario actual y, si es administrador o supervisor,
         * la de todos los usuarios.
         * Permite al frontend mostrar ambas listas en paralelo o en tablas adyacentes.
         */
        @GetMapping("/asistencia-mixta")
        public ResponseEntity<?> asistenciaMixta(
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {

                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                Usuario usuario = usuarioRepository.findByNombreUsuario(auth.getName()).orElse(null);

                // Verificación de roles más robusta basada en las autoridades cargadas en el
                // contexto
                boolean esAdmin = auth.getAuthorities().stream()
                                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")
                                                || a.getAuthority().equals("ROLE_SUPERVISOR"));

                Map<String, Object> respuesta = new LinkedHashMap<>();
                respuesta.put("esAdmin", esAdmin);

                // 1. Asistencia propia del trabajador vinculado al usuario logueado
                List<Map<String, Object>> misAsistencias = new ArrayList<>();
                if (usuario != null && usuario.getTrabajador() != null) {
                        respuesta.put("miNombre",
                                        usuario.getTrabajador().getNomTrab() + " "
                                                        + usuario.getTrabajador().getApeTrab());
                        misAsistencias = asistenciaRepository.findByTrabajadorIdTrabAndFecAsistBetween(
                                        usuario.getTrabajador().getIdTrab(), desde, hasta)
                                        .stream()
                                        .filter(a -> a.getHoraEntrada() != null || a.getHoraSalida() != null)
                                        .map(this::formatearAsistencia).collect(Collectors.toList());
                }
                respuesta.put("propia", misAsistencias);

                // 2. Asistencia general (solo para ADMIN o SUPERVISOR)
                List<Map<String, Object>> todasAsistencias = new ArrayList<>();
                if (esAdmin) {
                        todasAsistencias = asistenciaRepository.findByFecAsistBetween(desde, hasta)
                                        .stream()
                                        .filter(a -> a.getHoraEntrada() != null || a.getHoraSalida() != null)
                                        .map(this::formatearAsistencia).collect(Collectors.toList());
                }
                respuesta.put("general", todasAsistencias);

                return ResponseEntity.ok(respuesta);
        }

        private Map<String, Object> formatearAsistencia(Asistencia a) {
                Map<String, Object> m = new LinkedHashMap<>();
                m.put("id", a.getIdAsist());
                m.put("fecha", a.getFecAsist());
                m.put("trabajador",
                                (a.getTrabajador() != null)
                                                ? a.getTrabajador().getNomTrab() + " " + a.getTrabajador().getApeTrab()
                                                : "N/A");
                m.put("tipo", a.getTipoTarea() != null ? a.getTipoTarea() : "JORNAL");
                m.put("tareas", a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0);
                m.put("sacos", a.getSacosCosechados() != null ? a.getSacosCosechados() : 0);
                m.put("horaEntrada", a.getHoraEntrada());
                m.put("horaSalida", a.getHoraSalida());
                m.put("observacion", a.getObservacionSupervisor());
                return m;
        }
}
