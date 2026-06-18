package com.agricola.arroz.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum TipoPago {

    JORNAL      ("Jornal / Día"),
    TIEMPO      ("Tiempo Completo"),
    POR_SACO    ("Por Saco Cosechado"),
    RENDIMIENTO ("Por Rendimiento"),
    DESTAJO     ("Por Destajo"),
    TRANSPLANTE ("Por Tarea — Transplante"),
    SACA        ("Por Tarea — Saca"),
    CARGA       ("Por Tarea — Carga"),
    RIEGO       ("Por Tarea — Riego");

    private final String etiqueta;

    TipoPago(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    @JsonValue
    public String toValue() {
        return name().toLowerCase();
    }

    @JsonCreator
    public static TipoPago fromValue(String value) {
        return value == null ? null : TipoPago.valueOf(value.toUpperCase());
    }

    /** ¿Se paga por día trabajado? */
    public boolean esPorJornal() {
        return this == JORNAL || this == TIEMPO;
    }

    /** ¿Se paga por saco cosechado? */
    public boolean esPorSaco() {
        return this == POR_SACO || this == RENDIMIENTO || this == DESTAJO;
    }

    /** ¿Se paga por tarea ejecutada? */
    public boolean esPorTarea() {
        return this == TRANSPLANTE || this == SACA || this == CARGA || this == RIEGO;
    }
}