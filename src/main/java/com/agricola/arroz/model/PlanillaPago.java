package com.agricola.arroz.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * PlanillaPago — versión extendida con soporte para pago por tarea.
 *
 * Cálculo según tipo de pago del trabajador:
 *   JORNAL / TIEMPO     → total_dias × sueldo_base_dia
 *   POR_SACO / DESTAJO  → total_sacos × pago_por_saco
 *   TRANSPLANTE/SACA/
 *   CARGA/RIEGO         → total_tareas × pago_por_tarea
 */
@Entity
@Table(name = "planilla_pago")
public class PlanillaPago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPlanilla;

    @ManyToOne
    @JoinColumn(name = "id_trab", nullable = false)
    private Trabajador trabajador;

    @Column(name = "fecha_inicio")
    private LocalDate fechaInicio;

    @Column(name = "fecha_fin")
    private LocalDate fechaFin;

    // ── Contadores por tipo ──────────────────────────────────

    @Column(name = "total_sacos")
    private Integer totalSacos = 0;

    @Column(name = "total_dias")
    private Integer totalDias = 0;

    /**
     * NUEVO — Total de tareas completadas en el período.
     * Se suma la columna tareas_completadas de las asistencias del período.
     */
    @Column(name = "total_tareas")
    private Integer totalTareas = 0;

    /**
     * NUEVO — Tipo de tarea dominante en este pago (si aplica).
     * Ej: "TRANSPLANTE", "SACA", "CARGA", "RIEGO"
     */
    @Column(name = "tipo_tarea_planilla", length = 20)
    private String tipoTareaPlanilla;

    // ── Montos ───────────────────────────────────────────────

    @Column(name = "monto_total")
    private BigDecimal montoTotal;

    // pendiente, pagado, anulado
    private String estado = "pendiente";

    private String observacion;

    @Column(name = "fecha_generacion")
    private LocalDateTime fechaGeneracion = LocalDateTime.now();

    public PlanillaPago() {}

    // ── Getters y Setters ─────────────────────────────────────

    public Integer getIdPlanilla() { return idPlanilla; }
    public void setIdPlanilla(Integer id) { this.idPlanilla = id; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador t) { this.trabajador = t; }

    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate f) { this.fechaInicio = f; }

    public LocalDate getFechaFin() { return fechaFin; }
    public void setFechaFin(LocalDate f) { this.fechaFin = f; }

    public Integer getTotalSacos() { return totalSacos; }
    public void setTotalSacos(Integer s) { this.totalSacos = s; }

    public Integer getTotalDias() { return totalDias; }
    public void setTotalDias(Integer d) { this.totalDias = d; }

    public Integer getTotalTareas() { return totalTareas; }
    public void setTotalTareas(Integer t) { this.totalTareas = t; }

    public String getTipoTareaPlanilla() { return tipoTareaPlanilla; }
    public void setTipoTareaPlanilla(String t) { this.tipoTareaPlanilla = t; }

    public BigDecimal getMontoTotal() { return montoTotal; }
    public void setMontoTotal(BigDecimal m) { this.montoTotal = m; }

    public String getEstado() { return estado; }
    public void setEstado(String e) { this.estado = e; }

    public String getObservacion() { return observacion; }
    public void setObservacion(String o) { this.observacion = o; }

    public LocalDateTime getFechaGeneracion() { return fechaGeneracion; }
    public void setFechaGeneracion(LocalDateTime f) { this.fechaGeneracion = f; }
}
