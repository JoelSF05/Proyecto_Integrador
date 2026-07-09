package com.agricola.arroz.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.MovimientoCaja;
import com.agricola.arroz.repository.MovimientoCajaRepository;

@RestController
@RequestMapping("/api/caja")
public class MovimientoCajaController {

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");

    @Autowired
    private MovimientoCajaRepository movimientoCajaRepository;

    @GetMapping
    public List<MovimientoCaja> listar() {
        return movimientoCajaRepository.findAllByOrderByFechaDesc();
    }

    @PostMapping
    public ResponseEntity<?> crear(@RequestBody Map<String, Object> body) {
        try {
            MovimientoCaja m = new MovimientoCaja();
            String tipo = ((String) body.getOrDefault("tipo", "EGRESO")).toString();
            if ("INGRESO".equalsIgnoreCase(tipo)) {
                m.setTipo("Ingreso");
            } else if ("EGRESO".equalsIgnoreCase(tipo)) {
                m.setTipo("Egreso");
            } else {
                m.setTipo(tipo);
            }
            m.setDesc((String) body.getOrDefault("desc", ""));
            Object montoObj = body.get("monto");
            // Robust parsing: accept Number or String with currency symbols, commas, etc.
            if (montoObj instanceof Number) {
                m.setMonto(BigDecimal.valueOf(((Number) montoObj).doubleValue()));
            } else if (montoObj instanceof String) {
                String s = ((String) montoObj).trim();
                // Normalización de moneda y decimales
                s = s.replaceAll("[S/$\\s]", "").replace(",", ".");
                
                if (s.isBlank()) {
                    m.setMonto(BigDecimal.ZERO);
                } else {
                    try {
                        m.setMonto(new BigDecimal(s));
                    } catch (NumberFormatException nfe) {
                        return ResponseEntity.badRequest().body(Map.of("error", "Formato de monto inválido", "monto", montoObj));
                    }
                }
            } else {
                m.setMonto(BigDecimal.ZERO);
            }

            // validar monto positivo (la tabla exige monto > 0)
            if (m.getMonto() == null || m.getMonto().compareTo(BigDecimal.ZERO) <= 0) {
                return ResponseEntity.badRequest().body(Map.of("error", "El monto debe ser mayor que 0", "monto", m.getMonto()));
            }

            // Forzar siempre la fecha del servidor en la zona horaria de Perú para consistencia.
            m.setFecha(LocalDate.now(PERU_ZONE));
            // categoría obligatoria en el esquema
            m.setCategoria((String) body.getOrDefault("categoria", "General"));

            m.setIco((String) body.getOrDefault("ico", m.getTipo().equalsIgnoreCase("Ingreso")?"💰":"💸"));
            try {
                MovimientoCaja saved = movimientoCajaRepository.save(m);
                return ResponseEntity.ok(saved);
            } catch (DataAccessException dae) {
                dae.printStackTrace();
                return ResponseEntity.status(503).body(Map.of("error", "Error de acceso a la base de datos", "exception", dae.getClass().getName(), "message", dae.getMessage()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage(), "exception", e.getClass().getName()));
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        if (!movimientoCajaRepository.existsById(id)) return ResponseEntity.notFound().build();
        movimientoCajaRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("ok", true));
    }
}
