package com.agricola.arroz.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.agricola.arroz.model.Asistencia;

@Repository
public interface AsistenciaRepository extends JpaRepository<Asistencia, Integer> {
    List<Asistencia> findByFecAsist(LocalDate fecha);
    List<Asistencia> findByTrabajadorIdTrab(Integer idTrab);
}