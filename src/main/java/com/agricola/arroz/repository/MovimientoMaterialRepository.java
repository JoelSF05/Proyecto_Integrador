package com.agricola.arroz.repository;

import com.agricola.arroz.model.MovimientoMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface MovimientoMaterialRepository
        extends JpaRepository<MovimientoMaterial, Integer> {

    // Historial de movimientos de un material, del más reciente al más antiguo
    List<MovimientoMaterial> findByMaterialIdMatOrderByFechaMovimientoDesc(Integer idMat);

    List<MovimientoMaterial> findByFechaMovimientoBetweenOrderByFechaMovimientoDesc(LocalDateTime desde, LocalDateTime hasta);
}
