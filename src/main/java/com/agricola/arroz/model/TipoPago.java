package com.agricola.arroz.model;

public enum TipoPago {

    jornal      ("Jornal / Día"),
    tiempo      ("Tiempo Completo"),
    por_saco    ("Por Saco Cosechado"),
    rendimiento ("Por Rendimiento"),
    destajo     ("Por Destajo"),
    transplante ("Por Tarea — Transplante"),
    saca        ("Por Tarea — Saca"),
    carga       ("Por Tarea — Carga"),
    riego       ("Por Tarea — Riego");

    private final String etiqueta;

    TipoPago(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    /** ¿Se paga por día trabajado? */
    public boolean esPorJornal() {
        return this == jornal || this == tiempo;
    }

    /** ¿Se paga por saco cosechado? */
    public boolean esPorSaco() {
        return this == por_saco || this == rendimiento || this == destajo;
    }

    /** ¿Se paga por tarea ejecutada? */
    public boolean esPorTarea() {
        return this == transplante || this == saca || this == carga || this == riego;
    }
}