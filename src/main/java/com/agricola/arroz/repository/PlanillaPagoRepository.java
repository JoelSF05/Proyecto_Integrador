package com.agricola.arroz.repository;

import com.agricola.arroz.model.PlanillaPago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PlanillaPagoRepository extends JpaRepository<PlanillaPago, Integer> {

    List<PlanillaPago> findByTrabajadorIdTrabOrderByFechaInicioDesc(Integer idTrab);

    List<PlanillaPago> findByFechaInicioBetweenOrderByFechaInicioDesc(
        LocalDate desde, LocalDate hasta);

    List<PlanillaPago> findByEstado(String estado);
}
