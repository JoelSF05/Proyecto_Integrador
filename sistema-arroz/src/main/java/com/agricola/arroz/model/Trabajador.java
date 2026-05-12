package com.agricola.arroz.model;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;  // ← Importante
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "trabajadores")
public class Trabajador {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTrab;
    
    private String nomTrab;
    private String apeTrab;
    
    @Column(unique = true, length = 8)
    private String dniTrab;
    
    @ManyToOne
    @JoinColumn(name = "id_cargo")
    @JsonIgnore  // ← Ignora el objeto Cargo en el JSON
    private Cargo cargo;
    
    @Enumerated(EnumType.STRING)
    private TipoPago tipoPago;
    
    private BigDecimal sueldoBaseDia;
    private BigDecimal pagoPorSaco;
    
    // Constructor vacío
    public Trabajador() {}
    
    // Getters y Setters
    public Integer getIdTrab() {
        return idTrab;
    }
    
    public void setIdTrab(Integer idTrab) {
        this.idTrab = idTrab;
    }
    
    public String getNomTrab() {
        return nomTrab;
    }
    
    public void setNomTrab(String nomTrab) {
        this.nomTrab = nomTrab;
    }
    
    public String getApeTrab() {
        return apeTrab;
    }
    
    public void setApeTrab(String apeTrab) {
        this.apeTrab = apeTrab;
    }
    
    public String getDniTrab() {
        return dniTrab;
    }
    
    public void setDniTrab(String dniTrab) {
        this.dniTrab = dniTrab;
    }
    
    public Cargo getCargo() {
        return cargo;
    }
    
    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }
    
    public TipoPago getTipoPago() {
        return tipoPago;
    }
    
    public void setTipoPago(TipoPago tipoPago) {
        this.tipoPago = tipoPago;
    }
    
    public BigDecimal getSueldoBaseDia() {
        return sueldoBaseDia;
    }
    
    public void setSueldoBaseDia(BigDecimal sueldoBaseDia) {
        this.sueldoBaseDia = sueldoBaseDia;
    }
    
    public BigDecimal getPagoPorSaco() {
        return pagoPorSaco;
    }
    
    public void setPagoPorSaco(BigDecimal pagoPorSaco) {
        this.pagoPorSaco = pagoPorSaco;
    }
}