package com.agricola.arroz.controller;

import com.agricola.arroz.model.Gasolina;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.GasolinaRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/gasolina")
public class GasolinaController {

    @Autowired
    private GasolinaRepository gasolinaRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @GetMapping
    public List<Gasolina> listarTodos() {
        return gasolinaRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable Integer id) {
        return gasolinaRepository.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/trabajador/{idTrab}")
    public List<Gasolina> porTrabajador(@PathVariable Integer idTrab) {
        return gasolinaRepository.findByTrabajador_IdTrab(idTrab);
    }

    @GetMapping("/tipo")
    public List<Gasolina> porTipo(@RequestParam String tipoUso) {
        return gasolinaRepository.findByTipoUso(tipoUso);
    }

    @GetMapping("/rango")
    public List<Gasolina> porRango(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta) {
        return gasolinaRepository.findByFechaBetween(desde, hasta);
    }

    @PostMapping
    public ResponseEntity<?> crear(@RequestBody Map<String, Object> body) {
        try {
            Gasolina gasolina = new Gasolina();

            // ✅ idTrab es OPCIONAL — gasolina puede registrarse sin trabajador
            Object idTrabObj = body.get("idTrab");
            if (idTrabObj instanceof Number) {
                Integer idTrab = ((Number) idTrabObj).intValue();
                Trabajador trabajador = trabajadorRepository.findById(idTrab).orElse(null);
                gasolina.setTrabajador(trabajador);
            }

            gasolina.setFecha(LocalDate.parse((String) body.get("fecha")));
            gasolina.setTipoUso((String) body.get("tipoUso"));

            Object litros = body.get("litros");
            if (litros instanceof Number) {
                gasolina.setLitros(BigDecimal.valueOf(((Number) litros).doubleValue()));
            }

            gasolina.setVehiculo((String) body.get("vehiculo"));
            gasolina.setMaquinaFumigacion((String) body.get("maquinaFumigacion"));
            gasolina.setParcela((String) body.get("parcela"));
            gasolina.setResponsable((String) body.get("responsable"));
            gasolina.setObservacion((String) body.get("observacion"));

            return ResponseEntity.ok(gasolinaRepository.save(gasolina));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable Integer id, @RequestBody Map<String, Object> body) {
        return gasolinaRepository.findById(id).map(gasolina -> {
            if (body.containsKey("tipoUso"))          gasolina.setTipoUso((String) body.get("tipoUso"));
            if (body.containsKey("litros")) {
                Object l = body.get("litros");
                if (l instanceof Number) gasolina.setLitros(BigDecimal.valueOf(((Number) l).doubleValue()));
            }
            if (body.containsKey("vehiculo"))          gasolina.setVehiculo((String) body.get("vehiculo"));
            if (body.containsKey("maquinaFumigacion")) gasolina.setMaquinaFumigacion((String) body.get("maquinaFumigacion"));
            if (body.containsKey("parcela"))           gasolina.setParcela((String) body.get("parcela"));
            if (body.containsKey("responsable"))       gasolina.setResponsable((String) body.get("responsable"));
            if (body.containsKey("observacion"))       gasolina.setObservacion((String) body.get("observacion"));
            return ResponseEntity.ok(gasolinaRepository.save(gasolina));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminar(@PathVariable Integer id) {
        if (!gasolinaRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        gasolinaRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("ok", true));
    }
}
