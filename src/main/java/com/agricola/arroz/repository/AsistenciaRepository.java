package com.agricola.arroz.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.agricola.arroz.model.Asistencia;

public interface AsistenciaRepository extends JpaRepository<Asistencia, Integer> {
    List<Asistencia> findByFecAsistBetween(LocalDate inicio, LocalDate fin);
    List<Asistencia> findByTrabajadorIdTrabAndFecAsistBetween(Integer idTrab, LocalDate inicio, LocalDate fin);
    
    // Métodos requeridos por el servicio QR y controladores
    Optional<Asistencia> findByTrabajadorIdTrabAndFecAsist(Integer idTrab, LocalDate fecha);
    
    List<Asistencia> findByTipoTarea(String tipoTarea);
    
    List<Asistencia> findByTipoTareaAndFecAsistBetween(String tipo, LocalDate desde, LocalDate hasta);

    List<Asistencia> findByTrabajadorIdTrabAndFecAsistOrderByIdAsistAsc(Integer idTrab, LocalDate fecha);

    
}