package com.agricola.arroz.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Collections;
import java.util.Comparator;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.MovimientoCaja;
import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.AsistenciaRepository;
import com.agricola.arroz.repository.MovimientoCajaRepository;
import com.agricola.arroz.repository.PlanillaPagoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;

/**
 * PlanillaPagoService — genera y consulta planillas de pago.
 *
 * Lógica de cálculo:
 * JORNAL/TIEMPO → días presentes × sueldo_base_dia
 * POR_SACO/DESTAJO → total sacos × pago_por_saco
 * TRANSPLANTE/SACA/
 * CARGA/RIEGO → total tareas × pago_por_tarea
 */
@Service
public class PlanillaPagoService {

    @Autowired
    private PlanillaPagoRepository planillaRepository;

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private MovimientoCajaRepository movimientoCajaRepository;

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

    public List<PlanillaPago> listarTodas() {
        return planillaRepository.findAll();
    }

    public List<PlanillaPago> listarPorTrabajador(Integer idTrab) {
        return planillaRepository.findByTrabajadorIdTrabOrderByFechaInicioDesc(idTrab);
    }

    public List<PlanillaPago> listarPorPeriodo(LocalDate desde, LocalDate hasta) {
        return planillaRepository.findByFechaInicioBetweenOrderByFechaInicioDesc(desde, hasta);
    }

    public PlanillaPago listarPorId(Integer idPlanilla) {
        return planillaRepository.findById(idPlanilla)
                .orElseThrow(() -> new RuntimeException("Planilla no encontrada: " + idPlanilla));
    }

    /**
     * Genera una planilla de pago para un trabajador en un período dado.
     * Toma las asistencias del período y calcula el monto según el tipo de pago.
     */
    @Transactional
    public PlanillaPago generarPlanilla(Integer idTrab, LocalDate fechaInicio, LocalDate fechaFin) {
        Trabajador trabajador = trabajadorRepository.findById(idTrab)
                .orElseThrow(() -> new RuntimeException("Trabajador no encontrado: " + idTrab));

        List<Asistencia> asistencias = asistenciaRepository.findByTrabajadorIdTrabAndFecAsistBetween(idTrab,
                fechaInicio, fechaFin);

        PlanillaPago existente = planillaRepository
                .findFirstByTrabajadorIdTrabAndFechaInicioAndFechaFinOrderByIdPlanillaDesc(idTrab, fechaInicio,
                        fechaFin);

        // Si la planilla ya fue pagada o anulada, no la sobrescribimos
        if (existente != null && ("pagado".equalsIgnoreCase(existente.getEstado())
                || "anulado".equalsIgnoreCase(existente.getEstado()))) {
            return existente;
        }

        PlanillaPago planilla = (existente != null) ? existente : new PlanillaPago();
        planilla.setTrabajador(trabajador);
        planilla.setFechaInicio(fechaInicio);
        planilla.setFechaFin(fechaFin);
        planilla.setFechaGeneracion(LocalDateTime.now(PERU_ZONE));

        TipoPago tipo = trabajador.getTipoPago();
        BigDecimal montoTotal = BigDecimal.ZERO;

        if (tipo == null) {
            planilla.setMontoTotal(BigDecimal.ZERO);
            planilla.setObservacion("Sin tipo de pago asignado");
            return planillaRepository.save(planilla);
        }

        if (tipo.esPorJornal()) {
            BigDecimal tarifa = trabajador.getSueldoBaseDia() != null ? trabajador.getSueldoBaseDia() : BigDecimal.ZERO;
            // Al permitir múltiples registros por día, contamos días únicos para el pago de
            // jornal
            long diasUnicos = asistencias.stream()
                    .filter(a -> Boolean.TRUE.equals(a.getPresente()))
                    .map(Asistencia::getFecAsist)
                    .distinct()
                    .count();
            planilla.setTotalDias((int) diasUnicos);
            montoTotal = tarifa.multiply(BigDecimal.valueOf(diasUnicos));
        } else if (tipo.esPorSaco()) {
            BigDecimal tarifa = trabajador.getPagoPorSaco() != null ? trabajador.getPagoPorSaco() : BigDecimal.ZERO;
            int totalSacos = asistencias.stream()
                    .mapToInt(a -> a.getSacosCosechados() != null ? a.getSacosCosechados() : 0)
                    .sum();
            planilla.setTotalSacos(totalSacos);
            montoTotal = tarifa.multiply(BigDecimal.valueOf(totalSacos));
        } else if (tipo.esPorTarea()) {
            BigDecimal tarifa = trabajador.getPagoPorTarea() != null ? trabajador.getPagoPorTarea() : BigDecimal.ZERO;
            int totalTareas = asistencias.stream()
                    .mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0)
                    .sum();
            planilla.setTotalTareas(totalTareas);
            planilla.setTipoTareaPlanilla(tipo.name());
            montoTotal = tarifa.multiply(BigDecimal.valueOf(totalTareas));
        }

        planilla.setMontoTotal(montoTotal);
        return planillaRepository.save(planilla);
    }

    /**
     * Genera planillas para todos los trabajadores que tengan asistencias en el
     * período.
     */
    @Transactional
    public void generarPlanillasPeriodo(LocalDate desde, LocalDate hasta) {
        List<Asistencia> todas = asistenciaRepository.findByFecAsistBetween(desde, hasta);
        if (todas.isEmpty()) {
            return;
        }

        // Obtener todos los IDs de trabajadores únicos que tienen asistencia
        List<Integer> idTrabajadores = todas.stream()
                .map(a -> a.getTrabajador() != null ? a.getTrabajador().getIdTrab() : null)
                .filter(id -> id != null)
                .distinct()
                .collect(Collectors.toList());

        if (idTrabajadores.isEmpty()) {
            return;
        }

        // Cargar todos los trabajadores en una sola consulta
        List<Trabajador> trabajadores = trabajadorRepository.findAllById(idTrabajadores);
        Map<Integer, Trabajador> trabajadorMap = trabajadores.stream()
                .collect(Collectors.toMap(Trabajador::getIdTrab, t -> t));

        // Cargar todas las planillas existentes para este rango exacto en una sola
        // consulta
        List<PlanillaPago> planillasExistentes = planillaRepository.findByFechaInicioAndFechaFin(desde, hasta);

        // Agrupar planillas existentes por trabajador ID
        Map<Integer, List<PlanillaPago>> planillasPorTrabajador = planillasExistentes.stream()
                .filter(p -> p.getTrabajador() != null)
                .collect(Collectors.groupingBy(p -> p.getTrabajador().getIdTrab()));

        // Agrupar asistencias por trabajador ID
        Map<Integer, List<Asistencia>> asistenciasPorTrabajador = todas.stream()
                .filter(a -> a.getTrabajador() != null)
                .collect(Collectors.groupingBy(a -> a.getTrabajador().getIdTrab()));

        // Generar planillas para cada trabajador
        for (Integer idTrab : idTrabajadores) {
            Trabajador trabajador = trabajadorMap.get(idTrab);
            if (trabajador == null)
                continue;

            List<Asistencia> asistencias = asistenciasPorTrabajador.getOrDefault(idTrab, Collections.emptyList());
            List<PlanillaPago> existingList = planillasPorTrabajador.getOrDefault(idTrab, Collections.emptyList());

            // Si hay duplicados, preferir la pagada; si no, la de mayor ID
            PlanillaPago planilla = null;
            if (!existingList.isEmpty()) {
                // Primero buscar si alguna ya fue pagada
                planilla = existingList.stream()
                        .filter(p -> "pagado".equalsIgnoreCase(p.getEstado()))
                        .max(Comparator.comparing(PlanillaPago::getIdPlanilla))
                        .orElse(null);
                // Si ya fue pagada, no la tocamos
                if (planilla != null) {
                    continue;
                }
                // Si no, tomar la de mayor ID
                planilla = existingList.stream()
                        .filter(p -> !"anulado".equalsIgnoreCase(p.getEstado()))
                        .max(Comparator.comparing(PlanillaPago::getIdPlanilla))
                        .orElse(null);
            }

            if (planilla == null) {
                planilla = new PlanillaPago();
                planilla.setTrabajador(trabajador);
                planilla.setFechaInicio(desde);
                planilla.setFechaFin(hasta);
                planilla.setEstado("pendiente");
            }

            planilla.setFechaGeneracion(LocalDateTime.now(PERU_ZONE));

            TipoPago tipo = trabajador.getTipoPago();
            BigDecimal montoTotal = BigDecimal.ZERO;

            if (tipo == null) {
                planilla.setMontoTotal(BigDecimal.ZERO);
                planilla.setObservacion("Sin tipo de pago asignado");
                planillaRepository.save(planilla);
                continue;
            }

            // Reiniciamos los contadores a 0 por si reutilizamos una planilla existente
            planilla.setTotalDias(0);
            planilla.setTotalSacos(0);
            planilla.setTotalTareas(0);
            planilla.setTipoTareaPlanilla(null);

            if (tipo.esPorJornal()) {
                BigDecimal tarifa = trabajador.getSueldoBaseDia() != null ? trabajador.getSueldoBaseDia()
                        : BigDecimal.ZERO;
                long diasUnicos = asistencias.stream()
                        .filter(a -> Boolean.TRUE.equals(a.getPresente()))
                        .map(Asistencia::getFecAsist)
                        .distinct()
                        .count();
                planilla.setTotalDias((int) diasUnicos);
                montoTotal = tarifa.multiply(BigDecimal.valueOf(diasUnicos));
            } else if (tipo.esPorSaco()) {
                BigDecimal tarifa = trabajador.getPagoPorSaco() != null ? trabajador.getPagoPorSaco() : BigDecimal.ZERO;
                int totalSacos = asistencias.stream()
                        .mapToInt(a -> a.getSacosCosechados() != null ? a.getSacosCosechados() : 0)
                        .sum();
                planilla.setTotalSacos(totalSacos);
                montoTotal = tarifa.multiply(BigDecimal.valueOf(totalSacos));
            } else if (tipo.esPorTarea()) {
                BigDecimal tarifa = trabajador.getPagoPorTarea() != null ? trabajador.getPagoPorTarea()
                        : BigDecimal.ZERO;
                int totalTareas = asistencias.stream()
                        .mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0)
                        .sum();
                planilla.setTotalTareas(totalTareas);
                planilla.setTipoTareaPlanilla(tipo.name());
                montoTotal = tarifa.multiply(BigDecimal.valueOf(totalTareas));
            }

            planilla.setMontoTotal(montoTotal);
            planillaRepository.save(planilla);
        }
    }

    @Transactional
    public PlanillaPago marcarPagado(Integer idPlanilla) {
        PlanillaPago p = planillaRepository.findById(idPlanilla)
                .orElseThrow(() -> new RuntimeException("Planilla no encontrada: " + idPlanilla));

        if ("pagado".equalsIgnoreCase(p.getEstado())) {
            throw new RuntimeException("Esta planilla ya ha sido pagada anteriormente.");
        }

        p.setEstado("pagado");

        // Crear movimiento de egreso en caja
        MovimientoCaja mov = new MovimientoCaja();
        mov.setFecha(LocalDate.now(PERU_ZONE));
        mov.setTipo("Egreso");
        mov.setCategoria("Planilla");
        mov.setMonto(p.getMontoTotal());

        String desc = "Pago planilla";
        if (p.getTrabajador() != null) {
            desc += " a " + p.getTrabajador().getNomTrab() + " " + p.getTrabajador().getApeTrab();
        }
        mov.setDesc(desc);

        movimientoCajaRepository.save(mov);
        return planillaRepository.save(p);
    }

    @Transactional
    public PlanillaPago anular(Integer idPlanilla, String motivo) {
        PlanillaPago p = planillaRepository.findById(idPlanilla)
                .orElseThrow(() -> new RuntimeException("Planilla no encontrada: " + idPlanilla));
        p.setEstado("anulado");
        p.setObservacion(motivo);
        return planillaRepository.save(p);
    }
}
