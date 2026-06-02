package com.agricola.arroz.repository;

import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.TipoPago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * VERSIÓN MEJORADA de TrabajadorRepository
 * Nuevo método: findByActivoTrue() para filtrar solo activos
 */
@Repository
public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {

    Trabajador findByDniTrab(String dni);

    // solo trabajadores activos (soft delete)
    List<Trabajador> findByActivoTrue();

    // filtrar activos por tipo de pago (transplante, saca, carga, riego)
    List<Trabajador> findByTipoPagoAndActivoTrue(TipoPago tipoPago);
}
