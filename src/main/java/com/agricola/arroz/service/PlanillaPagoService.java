package com.agricola.arroz.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.model.PlanillaPago;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.AsistenciaRepository;
import com.agricola.arroz.repository.PlanillaPagoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;

/**
 * PlanillaPagoService — genera y consulta planillas de pago.
 *
 * Lógica de cálculo:
 *   JORNAL/TIEMPO      → días presentes × sueldo_base_dia
 *   POR_SACO/DESTAJO   → total sacos × pago_por_saco
 *   TRANSPLANTE/SACA/
 *   CARGA/RIEGO        → total tareas × pago_por_tarea
 */
@Service
public class PlanillaPagoService {

    @Autowired
    private PlanillaPagoRepository planillaRepository;

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    public List<PlanillaPago> listarTodas() {
        return planillaRepository.findAll();
    }

    public List<PlanillaPago> listarPorTrabajador(Integer idTrab) {
        return planillaRepository.findByTrabajadorIdTrabOrderByFechaInicioDesc(idTrab);
    }

    public List<PlanillaPago> listarPorPeriodo(LocalDate desde, LocalDate hasta) {
        return planillaRepository.findByFechaInicioBetweenOrderByFechaInicioDesc(desde, hasta);
    }

    /**
     * Genera una planilla de pago para un trabajador en un período dado.
     * Toma las asistencias del período y calcula el monto según el tipo de pago.
     */
    @Transactional
    public PlanillaPago generarPlanilla(Integer idTrab, LocalDate fechaInicio, LocalDate fechaFin) {
        Trabajador trabajador = trabajadorRepository.findById(idTrab)
            .orElseThrow(() -> new RuntimeException("Trabajador no encontrado: " + idTrab));

        List<Asistencia> asistencias =
            asistenciaRepository.findByTrabajadorIdTrabAndFecAsistBetween(idTrab, fechaInicio, fechaFin);

        PlanillaPago planilla = new PlanillaPago();
        planilla.setTrabajador(trabajador);
        planilla.setFechaInicio(fechaInicio);
        planilla.setFechaFin(fechaFin);

        TipoPago tipo = trabajador.getTipoPago();
        BigDecimal montoTotal = BigDecimal.ZERO;

        if (tipo == null) {
            planilla.setMontoTotal(BigDecimal.ZERO);
            planilla.setObservacion("Sin tipo de pago asignado");
            return planillaRepository.save(planilla);
        }

        if (tipo.esPorJornal()) {
          
long diasPresentes = asistencias.stream()
    .filter(a -> Boolean.TRUE.equals(a.getPresente()))
    .count();
planilla.setTotalDias((int) diasPresentes);
BigDecimal tasaDia = trabajador.getSueldoBaseDia() != null
    ? trabajador.getSueldoBaseDia() : BigDecimal.ZERO;
montoTotal = tasaDia.multiply(BigDecimal.valueOf(diasPresentes));

        } else if (tipo.esPorSaco()) {
            // Sumar sacos cosechados
            // Línea 97 — reemplaza el bloque del saco con esto:
int totalSacos = asistencias.stream()
    .mapToInt(a -> a.getSacosCosechados() != null ? a.getSacosCosechados() : 0)
    .sum();
planilla.setTotalSacos(totalSacos);
BigDecimal tasaSaco = trabajador.getPagoPorSaco() != null
    ? trabajador.getPagoPorSaco() : BigDecimal.ZERO;
montoTotal = tasaSaco.multiply(BigDecimal.valueOf(totalSacos));

        } else if (tipo.esPorTarea()) {
            // Sumar tareas completadas
            int totalTareas = asistencias.stream()
                .mapToInt(a -> a.getTareasCompletadas() != null ? a.getTareasCompletadas() : 0)
                .sum();
            planilla.setTotalTareas(totalTareas);
            planilla.setTipoTareaPlanilla(tipo.name().toUpperCase());
            BigDecimal tasaTarea = trabajador.getPagoPorTarea() != null
                ? trabajador.getPagoPorTarea() : BigDecimal.ZERO;
            montoTotal = tasaTarea.multiply(BigDecimal.valueOf(totalTareas));
        }

        planilla.setMontoTotal(montoTotal);
        return planillaRepository.save(planilla);
    }

    @Transactional
    public PlanillaPago marcarPagado(Integer idPlanilla) {
        PlanillaPago p = planillaRepository.findById(idPlanilla)
            .orElseThrow(() -> new RuntimeException("Planilla no encontrada: " + idPlanilla));
        p.setEstado("pagado");
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
