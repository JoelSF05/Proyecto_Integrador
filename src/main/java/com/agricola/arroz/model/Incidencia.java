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

    public Incidencia() {}

    @PrePersist
    public void prePersist() {
        if (this.fecha == null) this.fecha = LocalDate.now();
        if (this.estado == null) this.estado = "Pendiente";
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador trabajador) { this.trabajador = trabajador; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}