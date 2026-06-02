package com.agricola.arroz.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * VERSIÓN MEJORADA de Material.java
 * Cambios vs versión anterior:
 *  - Validaciones con @NotBlank y @PositiveOrZero
 *  - Campos de auditoría: createdAt, updatedAt
 *  - @PrePersist y @PreUpdate para actualizar timestamps automáticamente
 */
@Entity
@Table(name = "materiales")
public class Material {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idMat;

    @NotBlank(message = "El nombre del material no puede estar vacío")
    private String nomMat;

    private String tipoMat;

    @PositiveOrZero(message = "El stock no puede ser negativo")
    private BigDecimal stockActual;

    @PositiveOrZero(message = "El stock mínimo no puede ser negativo")
    private BigDecimal stockMinimo;

    private String unidadMedida;
    private Boolean activo = true;

    // ---- NUEVOS CAMPOS DE AUDITORÍA ----
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    // ------------------------------------

    public Material() {}

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // Getters y Setters
    public Integer getIdMat() { return idMat; }
    public void setIdMat(Integer idMat) { this.idMat = idMat; }

    public String getNomMat() { return nomMat; }
    public void setNomMat(String nomMat) { this.nomMat = nomMat; }

    public String getTipoMat() { return tipoMat; }
    public void setTipoMat(String tipoMat) { this.tipoMat = tipoMat; }

    public BigDecimal getStockActual() { return stockActual; }
    public void setStockActual(BigDecimal stockActual) { this.stockActual = stockActual; }

    public BigDecimal getStockMinimo() { return stockMinimo; }
    public void setStockMinimo(BigDecimal stockMinimo) { this.stockMinimo = stockMinimo; }

    public String getUnidadMedida() { return unidadMedida; }
    public void setUnidadMedida(String unidadMedida) { this.unidadMedida = unidadMedida; }

    public Boolean getActivo() { return activo; }
    public void setActivo(Boolean activo) { this.activo = activo; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
