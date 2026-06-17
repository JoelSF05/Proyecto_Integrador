package com.agricola.arroz.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "incidencia")
public class Incidencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_inc")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_trab")
    private Trabajador trabajador;

    @Column(name = "tipo")
    private String tipo;

    private String descripcion;

    @Column(name = "fecha")
    private LocalDate fecha;

    private String estado;

    // ── Lógica especial — se mantiene manual, Lombok no la toca ──
    @PrePersist
    public void prePersist() {
        if (this.fecha == null) this.fecha = LocalDate.now();
        if (this.estado == null) this.estado = "Pendiente";
    }
}
