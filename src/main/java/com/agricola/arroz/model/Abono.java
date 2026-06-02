package com.agricola.arroz.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "abono")
public class Abono {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAbono;

    @ManyToOne
    @JoinColumn(name = "id_trab", nullable = false)
    private Trabajador trabajador;

    @Column(nullable = false)
    private LocalDate fecha;

    @Column(name = "tipo_saco", length = 50, nullable = false)
    private String tipoSaco;

    @Column(name = "cantidad_sacos")
    private Integer cantidadSacos = 0;

    private String parcela;
    private String observacion;

    @Column(name = "created_at", updatable = false)
    private final LocalDateTime createdAt = LocalDateTime.now();

    // --- Getters y Setters ---
    public Integer getIdAbono() { return idAbono; }
    public void setIdAbono(Integer idAbono) { this.idAbono = idAbono; }

    public Trabajador getTrabajador() { return trabajador; }
    public void setTrabajador(Trabajador trabajador) { this.trabajador = trabajador; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getTipoSaco() { return tipoSaco; }
    public void setTipoSaco(String tipoSaco) { this.tipoSaco = tipoSaco; }

    public Integer getCantidadSacos() { return cantidadSacos; }
    public void setCantidadSacos(Integer cantidadSacos) { this.cantidadSacos = cantidadSacos; }

    public String getParcela() { return parcela; }
    public void setParcela(String parcela) { this.parcela = parcela; }

    public String getObservacion() { return observacion; }
    public void setObservacion(String observacion) { this.observacion = observacion; }

    public LocalDateTime getCreatedAt() { return createdAt; }
}