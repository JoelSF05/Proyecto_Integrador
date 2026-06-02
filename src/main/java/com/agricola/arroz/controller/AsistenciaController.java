package com.agricola.arroz.controller;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.repository.AsistenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/asistencias")
public class AsistenciaController {
    
    @Autowired
    private AsistenciaRepository asistenciaRepository;
    
    /**
     * GET /api/asistencias              → todas
     * GET /api/asistencias?tipoTarea=TRANSPLANTE → solo ese tipo
     */
    @GetMapping
    public List<Asistencia> listarTodos(
            @RequestParam(required = false) String tipoTarea) {
        if (tipoTarea != null && !tipoTarea.isBlank()) {
            return asistenciaRepository.findByTipoTarea(tipoTarea.toUpperCase());
        }
        return asistenciaRepository.findAll();
    }
    
    @GetMapping("/{id}")
    public Asistencia buscarPorId(@PathVariable Integer id) {
        return asistenciaRepository.findById(id).orElse(null);
    }
    
    @PostMapping
    public Asistencia crear(@RequestBody Asistencia asistencia) {
        return asistenciaRepository.save(asistencia);
    }
    
    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Integer id) {
        asistenciaRepository.deleteById(id);
    }
}