package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Modelo Trabajador con Lombok.
 * @Getter + @Setter elimina todos los getters/setters manuales.
 * @NoArgsConstructor elimina el constructor vacío manual.
 *
 * NOTA: Los métodos con lógica especial (getCargoId, getCargoNombre)
 * se mantienen escritos a mano — Lombok no los toca.
 */
@Getter
@Setter
@Entity
@Table(name = "trabajadores")
public class Trabajador {

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

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

    @Convert(converter = TipoPagoConverter.class)
    @Column(name = "tipo_pago")
    private TipoPago tipoPago;

    private BigDecimal sueldoBaseDia;
    private BigDecimal pagoPorSaco;

    @Column(name = "pago_por_tarea")
    private BigDecimal pagoPorTarea;

    @Column(name = "qr_token", unique = true)
    private String qrToken;

    private Boolean activo = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Constructor por defecto requerido por JPA/Hibernate (Fix para fallos de Lombok)
    public Trabajador() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now(PERU_ZONE);
        this.updatedAt = LocalDateTime.now(PERU_ZONE);
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now(PERU_ZONE);
    }

    // ── Métodos manuales (Fix para errores de compilación "symbol not found") ──

    public Integer getIdTrab() {
        return idTrab;
    }

    public String getNomTrab() {
        return nomTrab;
    }

    public String getApeTrab() {
        return apeTrab;
    }

    public String getDniTrab() {
        return dniTrab;
    }

    public void setNomTrab(String nomTrab) { this.nomTrab = nomTrab; }
    public void setApeTrab(String apeTrab) { this.apeTrab = apeTrab; }
    public void setDniTrab(String dniTrab) { this.dniTrab = dniTrab; }

    public TipoPago getTipoPago() {
        return tipoPago;
    }

    public void setTipoPago(TipoPago tipoPago) { this.tipoPago = tipoPago; }

    public BigDecimal getSueldoBaseDia() { return sueldoBaseDia; }
    public void setSueldoBaseDia(BigDecimal sueldoBaseDia) { this.sueldoBaseDia = sueldoBaseDia; }

    public BigDecimal getPagoPorSaco() { return pagoPorSaco; }
    public void setPagoPorSaco(BigDecimal pagoPorSaco) { this.pagoPorSaco = pagoPorSaco; }

    public BigDecimal getPagoPorTarea() { return pagoPorTarea; }
    public void setPagoPorTarea(BigDecimal pagoPorTarea) { this.pagoPorTarea = pagoPorTarea; }

    public String getQrToken() { return qrToken; }
    public void setQrToken(String qrToken) { this.qrToken = qrToken; }

    public Boolean getActivo() { return activo; }
    public void setActivo(Boolean activo) { this.activo = activo; }

    public Cargo getCargo() { return cargo; }
    public void setCargo(Cargo cargo) { this.cargo = cargo; }

    public Integer getCargoId() {
        return cargoId != null ? cargoId : (cargo != null ? cargo.getIdCargo() : null);
    }

    @JsonProperty("cargoNombre")
    public String getCargoNombre() {
        return cargo != null ? cargo.getNomCargo() : null;
    }
}
