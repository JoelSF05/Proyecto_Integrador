package com.agricola.arroz.repository;

import com.agricola.arroz.model.Incidencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IncidenciaRepository extends JpaRepository<Incidencia, Integer> {
    // Aquí puedes añadir métodos de búsqueda personalizados si los necesitas después
}