package com.agricola.arroz.repository;

import com.agricola.arroz.model.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * VERSIÓN MEJORADA de MaterialRepository
 * Nuevos métodos añadidos:
 *  - findStockBajo(): materiales con stock <= stockMinimo
 */
@Repository
public interface MaterialRepository extends JpaRepository<Material, Integer> {

    List<Material> findByActivoTrue();

    @Query("SELECT m FROM Material m WHERE m.activo = true AND m.stockActual <= m.stockMinimo")
    List<Material> findStockBajo();
}
