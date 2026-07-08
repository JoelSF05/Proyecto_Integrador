package com.agricola.arroz.service;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.JdbcTemplate;

import com.agricola.arroz.model.Material;
import com.agricola.arroz.repository.MaterialRepository;
import com.agricola.arroz.repository.MovimientoMaterialRepository;

@ExtendWith(MockitoExtension.class)
class MaterialServiceTest {

    @Mock
    private MaterialRepository materialRepository;

    @Mock
    private MovimientoMaterialRepository movimientoRepository;

    @Mock
    private JdbcTemplate jdbcTemplate;

    @InjectMocks
    private MaterialService materialService;

    @Test
    void actualizarStockNoDebeRegistrarMovimientoManual() {
        Material material = new Material();
        material.setIdMat(1);
        material.setStockActual(new BigDecimal("10"));

        when(materialRepository.findById(1)).thenReturn(Optional.of(material));
        when(materialRepository.save(any(Material.class))).thenAnswer(invocation -> invocation.getArgument(0));

        materialService.actualizarStock(1, new BigDecimal("12"), "Prueba");

        verify(materialRepository).save(any(Material.class));
        verify(movimientoRepository, never()).save(any());
    }
}
