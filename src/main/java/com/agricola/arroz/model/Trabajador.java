package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
@NoArgsConstructor
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

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // ── Métodos con lógica especial — se mantienen manuales ──

    public Integer getCargoId() {
        return cargoId != null ? cargoId : (cargo != null ? cargo.getIdCargo() : null);
    }

    @JsonProperty("cargoNombre")
    public String getCargoNombre() {
        return cargo != null ? cargo.getNomCargo() : null;
    }
}
