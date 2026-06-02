package com.agricola.arroz.repository;

import com.agricola.arroz.model.Gasolina;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface GasolinaRepository extends JpaRepository<Gasolina, Integer> {

    // Por tipo de uso: TRANSPORTE_PERSONAL o FUMIGACION
    List<Gasolina> findByTipoUso(String tipoUso);

    // Por rango de fecha
    List<Gasolina> findByFechaBetween(LocalDate desde, LocalDate hasta);

    // Por trabajador
    List<Gasolina> findByTrabajador_IdTrab(Integer idTrab);

    // Por parcela
    List<Gasolina> findByParcela(String parcela);
}
