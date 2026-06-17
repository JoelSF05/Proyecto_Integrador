package com.agricola.arroz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.repository.AsistenciaRepository;

@Service
public class AsistenciaService {

    private final AsistenciaRepository asistenciaRepository;

    public AsistenciaService(AsistenciaRepository asistenciaRepository) {
        this.asistenciaRepository = asistenciaRepository;
    }

    public List<Asistencia> listarTodos(String tipoTarea) {
        if (tipoTarea != null && !tipoTarea.isBlank()) {
            return asistenciaRepository.findByTipoTarea(tipoTarea.toUpperCase());
        }
        return asistenciaRepository.findAll();
    }

    public Asistencia buscarPorId(Integer id) {
        return asistenciaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Asistencia no encontrada con id: " + id));
    }

    @Transactional
    public Asistencia crear(Asistencia asistencia) {
        if (asistencia.getTrabajador() == null || asistencia.getTrabajador().getIdTrab() == null) {
            throw new RuntimeException("Se requiere un trabajador válido");
        }
        if (asistencia.getFecAsist() == null) {
            throw new RuntimeException("La fecha de asistencia es obligatoria");
        }
        return asistenciaRepository.save(asistencia);
    }

    @Transactional
    public void eliminar(Integer id) {
        if (!asistenciaRepository.existsById(id)) {
            throw new RuntimeException("Asistencia no encontrada con id: " + id);
        }
        asistenciaRepository.deleteById(id);
    }

    @Transactional
    public Asistencia aprobar(Integer id) {
        Asistencia asistencia = buscarPorId(id);
        asistencia.setEstadoAprobacion("APROBADO");
        return asistenciaRepository.save(asistencia);
    }

    @Transactional
    public Asistencia observar(Integer id, String motivo) {
        Asistencia asistencia = buscarPorId(id);
        asistencia.setEstadoAprobacion("OBSERVADO");
        if (motivo != null && !motivo.isBlank()) {
            asistencia.setObservacionSupervisor(motivo);
        }
        return asistenciaRepository.save(asistencia);
    }
}
