package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

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
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "gasolina")
public class Gasolina {

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idGasolina;

    @NotNull(message = "La fecha es obligatoria")
    @Column(nullable = false)
    private LocalDate fecha;

    // TRANSPORTE_PERSONAL o FUMIGACION
    @NotBlank(message = "El tipo de uso es obligatorio")
    @Column(name = "tipo_uso", length = 30, nullable = false)
    private String tipoUso;

    private String vehiculo;

    @Column(name = "maquina_fumigacion", length = 50)
    private String maquinaFumigacion;

    @DecimalMin(value = "0.0", message = "Los litros no pueden ser negativos")
    @Column(precision = 6, scale = 2)
    private BigDecimal litros;

    private String parcela;
    private String responsable;
    private String observacion;

    @ManyToOne
    @JoinColumn(name = "id_trab")
    private Trabajador trabajador;

    // ✅ Timestamps completos
    @Column(name = "created_at", updatable = false)
    private Instant createdAt;

    @Column(name = "updated_at")
    private Instant updatedAt;

    public Gasolina() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = Instant.now();
        this.updatedAt = Instant.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = Instant.now();
    }

    // --- Getters y Setters ---
    public Integer getIdGasolina() { return idGasolina; }
    public void setIdGasolina(Integer idGasolina) { this.idGasolina = idGasolina; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getTipoUso() { return tipoUso; }
    public void setTipoUso(String tipoUso) { this.tipoUso = tipoUso; }

    public String getVehiculo() { return vehiculo; }
    public void setVehiculo(String vehiculo) { this.vehiculo = vehiculo; }

    public String getMaquinaFumigacion() { return maquinaFumigacion; }
    public void setMaquinaFumigacion(String m) { this.maquinaFumigacion = m; }

    public BigDecimal getLitros() { return litros; }
    public void setLitros(BigDecimal litros) { this.litros = litros; }

    public String getParcela() { return parcela; }
    public void setParcela(String parcela) { this.parcela = parcela; }

    public String getResponsable() { return responsable; }
    public void setResponsable(String responsable) { this.responsable = responsable; }

    public String getObservacion() { return observacion; }
    public void setObservacion(String observacion) { this.observacion = observacion; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador trabajador) { this.trabajador = trabajador; }

    public Instant getCreatedAt() { return createdAt; }
    public Instant getUpdatedAt() { return updatedAt; }
}
