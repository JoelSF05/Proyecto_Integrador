package com.agricola.arroz.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Cargo;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.CargoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;

/**
 * TrabajadorService — versión extendida con validación de pago_por_tarea.
 */
@Service
public class TrabajadorService {

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private CargoRepository cargoRepository;

    public List<Trabajador> listarActivos() {
        return trabajadorRepository.findByActivoTrue();
    }

    public List<Trabajador> listarTodos() {
        return trabajadorRepository.findAll();
    }

    public List<Trabajador> listarPorTipoPago(TipoPago tipoPago) {
        return trabajadorRepository.findByTipoPagoAndActivoTrue(tipoPago);
    }

    public Trabajador buscarPorId(Integer id) {
        return trabajadorRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Trabajador no encontrado: " + id));
    }

    public Trabajador buscarPorDni(String dni) {
        Trabajador t = trabajadorRepository.findByDniTrab(dni);
        if (t == null) throw new RuntimeException("No existe trabajador con DNI: " + dni);
        return t;
    }

    @Transactional
    public Trabajador crear(Trabajador trabajador) {
        Trabajador existente = trabajadorRepository.findByDniTrab(trabajador.getDniTrab());
        if (existente != null) {
            throw new RuntimeException("Ya existe un trabajador con el DNI: " + trabajador.getDniTrab());
        }

        if (trabajador.getCargoId() == null) {
            throw new RuntimeException("El cargo es obligatorio");
        }

        Cargo cargo = cargoRepository.findById(trabajador.getCargoId())
            .orElseThrow(() -> new RuntimeException("Cargo no existe: " + trabajador.getCargoId()));

        trabajador.setCargo(cargo);
        
        // Asegurar que siempre tenga un token QR al crearse
        if (trabajador.getQrToken() == null || trabajador.getQrToken().isEmpty()) {
            trabajador.setQrToken(UUID.randomUUID().toString());
        }
        
        validarCamposPago(trabajador);
        return trabajadorRepository.save(trabajador);
    }

    @Transactional
    public Trabajador actualizar(Integer id, Trabajador datosNuevos) {
        Trabajador existente = buscarPorId(id);

        Trabajador conMismoDni = trabajadorRepository.findByDniTrab(datosNuevos.getDniTrab());
        if (conMismoDni != null && !conMismoDni.getIdTrab().equals(id)) {
            throw new RuntimeException("El DNI ya está en uso por otro trabajador");
        }

        existente.setNomTrab(datosNuevos.getNomTrab());
        existente.setApeTrab(datosNuevos.getApeTrab());
        existente.setDniTrab(datosNuevos.getDniTrab());
        existente.setTipoPago(datosNuevos.getTipoPago());
        existente.setSueldoBaseDia(datosNuevos.getSueldoBaseDia());
        existente.setPagoPorSaco(datosNuevos.getPagoPorSaco());
        existente.setPagoPorTarea(datosNuevos.getPagoPorTarea());

        if (datosNuevos.getCargoId() != null) {
            Cargo cargo = cargoRepository.findById(datosNuevos.getCargoId())
                .orElseThrow(() -> new RuntimeException("Cargo no existe"));
            existente.setCargo(cargo);
        }

        // Si no tiene token (registros antiguos) o los datos nuevos no lo traen, mantenemos o generamos
        if (existente.getQrToken() == null || existente.getQrToken().isEmpty()) {
            existente.setQrToken(UUID.randomUUID().toString());
        }

        validarCamposPago(existente);
        return trabajadorRepository.save(existente);
    }

    @Transactional
    public void eliminar(Integer id) {
        Trabajador t = buscarPorId(id);
        t.setActivo(false);
        trabajadorRepository.save(t);
    }

    /**
     * Valida que el campo de monto correspondiente al tipo de pago
     * esté informado.
     */
    private void validarCamposPago(Trabajador t) {
        if (t.getTipoPago() == null) return;

        TipoPago tipo = t.getTipoPago();

        if (tipo.esPorJornal() && t.getSueldoBaseDia() == null) {
            throw new RuntimeException(
                "Debe indicar el sueldo base por día para tipo de pago: " + tipo.getEtiqueta());
        }
        if (tipo.esPorSaco() && t.getPagoPorSaco() == null) {
            throw new RuntimeException(
                "Debe indicar el monto por saco para tipo de pago: " + tipo.getEtiqueta());
        }
        if (tipo.esPorTarea() && t.getPagoPorTarea() == null) {
            throw new RuntimeException(
                "Debe indicar el monto por tarea para tipo de pago: " + tipo.getEtiqueta());
        }
    }
}
