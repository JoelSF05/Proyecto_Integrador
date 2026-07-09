package com.agricola.arroz.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "areas")
public class Area {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_area")
    private Integer idArea;

    @Column(name = "nombre_area")
    private String nombreArea;

    @Column(name = "tamanio_hectareas")
    private BigDecimal tamanioHectareas;

    @Column(name = "variedad_predeterminada")
    private String variedadPredeterminada;

    private Boolean activo = true;

    public Area() {
    }

    public Area(Integer idArea) {
        this.idArea = idArea;
    }

    // Getters y setters manuales si Lombok da problemas
    public Integer getIdArea() {
        return idArea;
    }
}