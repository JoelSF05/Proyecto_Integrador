package com.agricola.arroz.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(
    name = "asistencia",
    uniqueConstraints = {
        // ✅ Un trabajador no puede tener dos asistencias el mismo día con el mismo tipo de tarea
        @UniqueConstraint(
            name = "uk_asistencia_trab_fecha_tarea",
            columnNames = {"id_trab", "fec_asist", "tipo_tarea"}
        )
    }
)
public class Asistencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAsist;

    @ManyToOne
    @JoinColumn(name = "id_trab", nullable = false)
    private Trabajador trabajador;

    @Column(name = "fec_asist", nullable = false)
    private LocalDate fecAsist;

    private LocalTime horaEntrada;
    private LocalTime horaSalida;
    private Boolean presente = true;
    private Integer sacosCosechados = 0;

    @Column(name = "tipo_tarea", length = 20)
    private String tipoTarea;

    @Column(name = "tareas_completadas")
    private Integer tareasCompletadas = 0;

    @Column(name = "observacion_supervisor", length = 300)
    private String observacionSupervisor;

    @Column(name = "estado_aprobacion", length = 20)
    private String estadoAprobacion = "PENDIENTE";

    // ✅ Timestamps de auditoría
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Asistencia() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // ── Getters y Setters ─────────────────────────────────────

    public Integer getIdAsist() { return idAsist; }
    public void setIdAsist(Integer idAsist) { this.idAsist = idAsist; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador trabajador) { this.trabajador = trabajador; }

    public LocalDate getFecAsist() { return fecAsist; }
    public void setFecAsist(LocalDate fecAsist) { this.fecAsist = fecAsist; }

    public LocalTime getHoraEntrada() { return horaEntrada; }
    public void setHoraEntrada(LocalTime horaEntrada) { this.horaEntrada = horaEntrada; }

    public LocalTime getHoraSalida() { return horaSalida; }
    public void setHoraSalida(LocalTime horaSalida) { this.horaSalida = horaSalida; }

    public Boolean getPresente() { return presente; }
    public void setPresente(Boolean presente) { this.presente = presente; }

    public Integer getSacosCosechados() { return sacosCosechados; }
    public void setSacosCosechados(Integer sacosCosechados) { this.sacosCosechados = sacosCosechados; }

    public String getTipoTarea() { return tipoTarea; }
    public void setTipoTarea(String tipoTarea) { this.tipoTarea = tipoTarea; }

    public Integer getTareasCompletadas() { return tareasCompletadas; }
    public void setTareasCompletadas(Integer tareasCompletadas) { this.tareasCompletadas = tareasCompletadas; }

    public String getObservacionSupervisor() { return observacionSupervisor; }
    public void setObservacionSupervisor(String obs) { this.observacionSupervisor = obs; }

    public String getEstadoAprobacion() { return estadoAprobacion; }
    public void setEstadoAprobacion(String estadoAprobacion) { this.estadoAprobacion = estadoAprobacion; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
