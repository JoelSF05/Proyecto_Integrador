package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * Modelo Trabajador — versión extendida con pago_por_tarea.
 *
 * Campos de pago según tipo:
 *   - sueldo_base_dia  → usado cuando tipoPago = jornal / tiempo
 *   - pago_por_saco    → usado cuando tipoPago = por_saco / rendimiento / destajo
 *   - pago_por_tarea   → NUEVO: usado cuando tipoPago = transplante / saca / carga / riego
 */
@Entity
@Table(name = "trabajadores")
public class Trabajador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTrab;

    @NotBlank(message = "El nombre es obligatorio")
    private String nomTrab;

    @NotBlank(message = "El apellido es obligatorio")
    private String apeTrab;

    @NotBlank(message = "El DNI es obligatorio")
    @Size(min = 8, max = 8, message = "El DNI debe tener exactamente 8 caracteres")
    @Column(unique = true, length = 8)
    private String dniTrab;

    @ManyToOne
    @JoinColumn(name = "id_cargo")
    @JsonIgnore
    private Cargo cargo;

    @Transient
    @JsonProperty("cargoId")
    private Integer cargoId;

    @Enumerated(EnumType.STRING)
    private TipoPago tipoPago;

    /** Usado para tipoPago = jornal / tiempo */
    private BigDecimal sueldoBaseDia;

    /** Usado para tipoPago = por_saco / rendimiento / destajo */
    private BigDecimal pagoPorSaco;

    /**
     * NUEVO — Monto fijo por tarea completada.
     * Usado para tipoPago = transplante / saca / carga / riego.
    * Ejemplo: S/ 50 por tarea de transplante terminada.
     */
    @Column(name = "pago_por_tarea")
    private BigDecimal pagoPorTarea;

    /** Token único para el marcado de asistencia por QR */
    @Column(name = "qr_token", unique = true)
    private String qrToken;

    private Boolean activo = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    public Trabajador() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // ── Getters y Setters ────────────────────────────────────

    public Integer getIdTrab() { return idTrab; }
    public void setIdTrab(Integer idTrab) { this.idTrab = idTrab; }

    public String getNomTrab() { return nomTrab; }
    public void setNomTrab(String nomTrab) { this.nomTrab = nomTrab; }

    public String getApeTrab() { return apeTrab; }
    public void setApeTrab(String apeTrab) { this.apeTrab = apeTrab; }

    public String getDniTrab() { return dniTrab; }
    public void setDniTrab(String dniTrab) { this.dniTrab = dniTrab; }

    public Cargo getCargo() { return cargo; }
    public void setCargo(Cargo cargo) { this.cargo = cargo; }

    public Integer getCargoId() {
        return cargoId != null ? cargoId : (cargo != null ? cargo.getIdCargo() : null);
    }
    public void setCargoId(Integer cargoId) { this.cargoId = cargoId; }

    @JsonProperty("cargoNombre")
    public String getCargoNombre() { return cargo != null ? cargo.getNomCargo() : null; }

    public TipoPago getTipoPago() { return tipoPago; }
    public void setTipoPago(TipoPago tipoPago) { this.tipoPago = tipoPago; }

    public BigDecimal getSueldoBaseDia() { return sueldoBaseDia; }
    public void setSueldoBaseDia(BigDecimal s) { this.sueldoBaseDia = s; }

    public BigDecimal getPagoPorSaco() { return pagoPorSaco; }
    public void setPagoPorSaco(BigDecimal p) { this.pagoPorSaco = p; }

    public BigDecimal getPagoPorTarea() { return pagoPorTarea; }
    public void setPagoPorTarea(BigDecimal p) { this.pagoPorTarea = p; }

    public String getQrToken() { return qrToken; }
    public void setQrToken(String qrToken) { this.qrToken = qrToken; }

    public Boolean getActivo() { return activo; }
    public void setActivo(Boolean activo) { this.activo = activo; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
