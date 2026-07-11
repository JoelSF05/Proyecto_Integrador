package com.agricola.arroz.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "areas")
public class Area {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_area")
    private Integer idArea;

    @Column(name = "nombre_area", length = 100)
    private String nombreArea;

    @Column(name = "tamanio_area", precision = 8, scale = 2)
    private BigDecimal tamanioArea;

    private Boolean activo = true;

    /**
     * Constructor para crear una referencia a un Area existente
     * solo con su ID. Útil para asignaciones en relaciones.
     * 
     * @param idArea El ID del área a referenciar.
     */
    public Area(Integer idArea) {
        this.idArea = idArea;
    }

}