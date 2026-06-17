package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * PlanillaPago — versión extendida con soporte para pago por tarea.
 *
 * Cálculo según tipo de pago del trabajador:
 *   JORNAL / TIEMPO     → total_dias × sueldo_base_dia
 *   POR_SACO / DESTAJO  → total_sacos × pago_por_saco
 *   TRANSPLANTE/SACA/
 *   CARGA/RIEGO         → total_tareas × pago_por_tarea
 */
@Getter
@Setter
@NoArgsConstructor
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
     * Total de tareas completadas en el período.
     * Se suma la columna tareas_completadas de las asistencias del período.
     */
    @Column(name = "total_tareas")
    private Integer totalTareas = 0;

    /**
     * Tipo de tarea dominante en este pago (si aplica).
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
}
