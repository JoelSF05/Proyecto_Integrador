package com.agricola.arroz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Incidencia;
import com.agricola.arroz.repository.IncidenciaRepository;

@RestController
@RequestMapping("/api/incidencias")
public class IncidenciaController {

    @Autowired
    private IncidenciaRepository incidenciaRepository;

    @GetMapping
    public List<Incidencia> listar() {
        return incidenciaRepository.findAll();
    }

    @PostMapping
    public ResponseEntity<?> guardar(@RequestBody Incidencia incidencia) {
        try {
            Incidencia nueva = incidenciaRepository.save(incidencia);
            return ResponseEntity.ok(nueva);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("error", "No se pudo guardar la incidencia: " + e.getMessage()));
        }
    }

    @PatchMapping("/{id}/estado")
    public ResponseEntity<?> actualizarEstado(@PathVariable Integer id, @RequestBody Map<String, String> body) {
        return incidenciaRepository.findById(id).map(inc -> {
            inc.setEstado(body.get("estado"));
            incidenciaRepository.save(inc);
            return ResponseEntity.ok(Map.of("ok", true));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        if (incidenciaRepository.existsById(id)) {
            incidenciaRepository.deleteById(id);
            return ResponseEntity.ok(Map.of("ok", true));
        }
        return ResponseEntity.notFound().build();
    }
}