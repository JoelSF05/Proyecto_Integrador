package com.agricola.arroz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.repository.AsistenciaRepository;

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

    @PatchMapping("/{id}/aprobar")
    public Asistencia aprobar(@PathVariable Integer id) {
        return asistenciaRepository.findById(id).map(a -> {
            a.setEstadoAprobacion("APROBADO");
            return asistenciaRepository.save(a);
        }).orElse(null);
    }

    @PatchMapping("/{id}/observar")
    public Asistencia observar(@PathVariable Integer id, @RequestBody(required = false) java.util.Map<String,String> body) {
        final String motivo = body != null ? body.getOrDefault("motivo", "") : "";
        return asistenciaRepository.findById(id).map(a -> {
            a.setEstadoAprobacion("OBSERVADO");
            if(motivo != null && !motivo.isBlank()) a.setObservacionSupervisor(motivo);
            return asistenciaRepository.save(a);
        }).orElse(null);
    }
}