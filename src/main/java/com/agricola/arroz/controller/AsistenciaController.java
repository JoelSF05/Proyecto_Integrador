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
    
    @GetMapping
    public List<Asistencia> listarTodos() {
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