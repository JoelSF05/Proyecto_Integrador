package com.agricola.arroz.repository;

import com.agricola.arroz.model.Asistencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface AsistenciaRepository extends JpaRepository<Asistencia, Integer> {

    List<Asistencia> findByFecAsist(LocalDate fecha);

    List<Asistencia> findByTrabajadorIdTrab(Integer idTrab);

    /** NUEVO — Rango de fechas para cálculo de planilla */
    List<Asistencia> findByTrabajadorIdTrabAndFecAsistBetween(
        Integer idTrab, LocalDate fechaInicio, LocalDate fechaFin);

    /** NUEVO — Asistencias por tipo de tarea (para reportes) */
    List<Asistencia> findByTipoTareaAndFecAsistBetween(
        String tipoTarea, LocalDate fechaInicio, LocalDate fechaFin);

    /** Filtra solo por tipo de tarea — para las vistas de transplante, saca, carga, riego */
    List<Asistencia> findByTipoTarea(String tipoTarea);
}
