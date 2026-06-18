package com.agricola.arroz.model;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class TipoPagoConverter implements AttributeConverter<TipoPago, String> {

    @Override
    public String convertToDatabaseColumn(TipoPago attribute) {
        if (attribute == null) return null;
        return attribute.name().toLowerCase(); // Guarda en minúsculas (ej: "transplante")
    }

    @Override
    public TipoPago convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        try {
            return TipoPago.valueOf(dbData.toUpperCase()); // Lee a Enum (ej: TRANSPLANTE)
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}