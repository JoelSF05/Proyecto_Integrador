package com.agricola.arroz.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.model.Trabajador;

public interface TrabajadorRepository extends JpaRepository<Trabajador, Integer> {
    List<Trabajador> findByActivoTrue();
    
    Trabajador findByDniTrab(String dni);
    
    Optional<Trabajador> findByQrToken(String qrToken);
    
    List<Trabajador> findByTipoPagoAndActivoTrue(TipoPago tipoPago);
}