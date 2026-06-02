package com.agricola.arroz.repository;

import com.agricola.arroz.model.Abono;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface AbonoRepository extends JpaRepository<Abono, Integer> {

    // Todos los abonos de un trabajador
    List<Abono> findByTrabajador_IdTrab(Integer idTrab);

    // Abonos por rango de fecha
    List<Abono> findByFechaBetween(LocalDate desde, LocalDate hasta);

    // Abonos de un trabajador en un rango de fecha
    List<Abono> findByTrabajador_IdTrabAndFechaBetween(Integer idTrab, LocalDate desde, LocalDate hasta);

    // Abonos por parcela
    List<Abono> findByParcela(String parcela);
}
