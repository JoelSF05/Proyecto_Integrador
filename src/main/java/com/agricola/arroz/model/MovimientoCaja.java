package com.agricola.arroz.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "movimientos_caja")
public class MovimientoCaja {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movimientos_seq")
    @SequenceGenerator(name = "movimientos_seq", sequenceName = "movimientos_caja_id_mov_seq", allocationSize = 1)
    @Column(name = "id_mov")
    private Integer id;

    @Column(name = "tipo_mov")
    private String tipo; // INGRESO | EGRESO

    @Column(name = "descripcion")
    private String desc;

    private BigDecimal monto;

    @Column(name = "fec_mov")
    private LocalDate fecha;

    // No persistir el icono en la BD (solo UI)
    @Transient
    private String ico;

    // Campo requerido en el esquema
    @Column(name = "categoria")
    private String categoria;

    // Constructor manual
    public MovimientoCaja() {}

    // ── Métodos manuales (Fix para fallos de Lombok) ──

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
