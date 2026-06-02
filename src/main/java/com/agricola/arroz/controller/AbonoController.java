package com.agricola.arroz.controller;

import com.agricola.arroz.model.Abono;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.AbonoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/abonos")
public class AbonoController {

    @Autowired
    private AbonoRepository abonoRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    // GET /api/abonos — listar todos
    @GetMapping
    public List<Abono> listarTodos() {
        return abonoRepository.findAll();
    }

    // GET /api/abonos/{id}
    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Integer id) {
        return abonoRepository.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    // GET /api/abonos/trabajador/{idTrab}
    @GetMapping("/trabajador/{idTrab}")
    public List<Abono> porTrabajador(@PathVariable Integer idTrab) {
        return abonoRepository.findByTrabajador_IdTrab(idTrab);
    }

    // GET /api/abonos/rango?desde=2026-01-01&hasta=2026-12-31
    @GetMapping("/rango")
    public List<Abono> porRango(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {
        return abonoRepository.findByFechaBetween(desde, hasta);
    }

    // POST /api/abonos — crear registro
    @PostMapping
    public ResponseEntity<?> crear(@RequestBody Map<String, Object> body) {
        try {
            Abono abono = new Abono();

            // Buscar trabajador por idTrab
            Integer idTrab = (Integer) body.get("idTrab");
            if (idTrab == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "idTrab es obligatorio"));
            }
            Trabajador trabajador = trabajadorRepository.findById(idTrab).orElse(null);
            if (trabajador == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "Trabajador no encontrado"));
            }
            abono.setTrabajador(trabajador);

            abono.setFecha(LocalDate.parse((String) body.get("fecha")));
            abono.setTipoSaco((String) body.get("tipoSaco"));
            abono.setCantidadSacos((Integer) body.getOrDefault("cantidadSacos", 0));
            abono.setParcela((String) body.get("parcela"));
            abono.setObservacion((String) body.get("observacion"));

            return ResponseEntity.ok(abonoRepository.save(abono));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    // PUT /api/abonos/{id} — actualizar
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable Integer id, @RequestBody Map<String, Object> body) {
        return abonoRepository.findById(id).map(abono -> {
            if (body.containsKey("tipoSaco"))      abono.setTipoSaco((String) body.get("tipoSaco"));
            if (body.containsKey("cantidadSacos")) abono.setCantidadSacos((Integer) body.get("cantidadSacos"));
            if (body.containsKey("parcela"))       abono.setParcela((String) body.get("parcela"));
            if (body.containsKey("observacion"))   abono.setObservacion((String) body.get("observacion"));
            return ResponseEntity.ok(abonoRepository.save(abono));
        }).orElse(ResponseEntity.notFound().build());
    }

    // DELETE /api/abonos/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        if (!abonoRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        abonoRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("ok", true));
    }
}
