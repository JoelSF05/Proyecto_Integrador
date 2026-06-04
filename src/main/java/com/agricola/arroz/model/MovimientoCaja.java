package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "movimientos_caja")
public class MovimientoCaja {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movimientos_seq")
    @jakarta.persistence.SequenceGenerator(name = "movimientos_seq", sequenceName = "movimientos_caja_id_mov_seq", allocationSize = 1)
    @jakarta.persistence.Column(name = "id_mov")
    private Integer id;

    @jakarta.persistence.Column(name = "tipo_mov")
    private String tipo; // INGreso | EGRESO

    @Column(name = "descripcion")
    private String desc;

    private BigDecimal monto;

    @jakarta.persistence.Column(name = "fec_mov")
    private LocalDate fecha;

    // No persistir el icono en la BD (solo UI)
    @jakarta.persistence.Transient
    private String ico;

    // Campo requerido en el esquema
    @jakarta.persistence.Column(name = "categoria")
    private String categoria;

    public MovimientoCaja() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getDesc() { return desc; }
    public void setDesc(String desc) { this.desc = desc; }

    public BigDecimal getMonto() { return monto; }
    public void setMonto(BigDecimal monto) { this.monto = monto; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getIco() { return ico; }
    public void setIco(String ico) { this.ico = ico; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
}
