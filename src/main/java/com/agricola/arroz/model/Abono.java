package com.agricola.arroz.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "abono")
public class Abono {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAbono;

    @ManyToOne
    @JoinColumn(name = "id_trab", nullable = false)
    private Trabajador trabajador;

    @NotNull(message = "La fecha es obligatoria")
    @Column(nullable = false)
    private LocalDate fecha;

    @NotBlank(message = "El tipo de saco no puede estar vacío")
    @Column(name = "tipo_saco", length = 50, nullable = false)
    private String tipoSaco;

    @Min(value = 0, message = "La cantidad de sacos no puede ser negativa")
    @Column(name = "cantidad_sacos")
    private Integer cantidadSacos = 0;

    private String parcela;
    private String observacion;

    // ✅ Timestamps completos
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Abono() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // --- Getters y Setters ---
    public Integer getIdAbono() { return idAbono; }
    public void setIdAbono(Integer idAbono) { this.idAbono = idAbono; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador trabajador) { this.trabajador = trabajador; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getTipoSaco() { return tipoSaco; }
    public void setTipoSaco(String tipoSaco) { this.tipoSaco = tipoSaco; }

    public Integer getCantidadSacos() { return cantidadSacos; }
    public void setCantidadSacos(Integer cantidadSacos) { this.cantidadSacos = cantidadSacos; }

    public String getParcela() { return parcela; }
    public void setParcela(String parcela) { this.parcela = parcela; }

    public String getObservacion() { return observacion; }
    public void setObservacion(String observacion) { this.observacion = observacion; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
