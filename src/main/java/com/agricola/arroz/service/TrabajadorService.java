package com.agricola.arroz.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Cargo;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.repository.CargoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import com.agricola.arroz.repository.UsuarioRepository;

/**
 * TrabajadorService — versión extendida con validación de pago_por_tarea.
 */
@Service
public class TrabajadorService {

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private CargoRepository cargoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public List<Trabajador> listarActivos() {
        List<Trabajador> trabajadores = trabajadorRepository.findByActivoTrue();
        // Forzar la carga de la relación para que el nombre del cargo se serialice.
        // Esto evita errores de "LazyInitializationException" y asegura que el JSON
        // incluya el cargo.
        for (Trabajador t : trabajadores) {
            // Forzamos la carga de la relación para que el nombre del cargo se serialice
            // correctamente.
            if (t.getCargo() != null)
                t.setCargoNombre(t.getCargo().getNomCargo());
        }
        return trabajadores;
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
        if (t == null)
            throw new RuntimeException("No existe trabajador con DNI: " + dni);
        return t;
    }

    @Transactional
    public Trabajador crear(Trabajador trabajador) {
        validarDni(trabajador.getDniTrab());

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
        Trabajador nuevoTrabajador = trabajadorRepository.save(trabajador);

        // --- INICIO: Creación automática de usuario ---
        crearUsuarioParaTrabajador(nuevoTrabajador);
        // --- FIN: Creación automática de usuario ---

        return nuevoTrabajador;
    }

    private void crearUsuarioParaTrabajador(Trabajador trabajador) {
        String username = trabajador.getDniTrab();
        Optional<Usuario> existente = usuarioRepository.findByNombreUsuario(username);
        if (existente.isPresent()) {
            return; // Si ya existe un usuario con ese DNI, no hacemos nada.
        }

        String inicialNombre = trabajador.getNomTrab().substring(0, 1).toUpperCase();
        String inicialApellido = trabajador.getApeTrab().substring(0, 1).toUpperCase();
        String ultimos4Dni = trabajador.getDniTrab().substring(trabajador.getDniTrab().length() - 4);
        String password = inicialNombre + inicialApellido + ultimos4Dni;

        String rol = determinarRolPorCargo(trabajador.getCargo());
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombreUsuario(username);
        nuevoUsuario.setContrasenaHash(passwordEncoder.encode(password));
        nuevoUsuario.setRol(rol);
        nuevoUsuario.setTrabajador(trabajador);
        nuevoUsuario.setActivo(true);
        usuarioRepository.save(nuevoUsuario);
    }

    private String determinarRolPorCargo(Cargo cargo) {
        if (cargo == null || cargo.getNomCargo() == null) {
            return "TRABAJADOR";
        }
        String nombreCargo = cargo.getNomCargo().toUpperCase();
        if (nombreCargo.contains("ADMIN"))
            return "ADMIN";
        if (nombreCargo.contains("SUPERVISOR") || nombreCargo.contains("CAPATAZ"))
            return "SUPERVISOR";
        if (nombreCargo.contains("CONTADOR"))
            return "CONTADOR";
        if (nombreCargo.contains("INGENIERO"))
            return "INGENIERO";
        return "TRABAJADOR"; // Rol por defecto
    }

    @Transactional
    public Trabajador actualizar(Integer id, Trabajador datosNuevos) {
        Trabajador existente = buscarPorId(id);

        validarDni(datosNuevos.getDniTrab());

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

            // --- INICIO: Actualización automática de ROL de usuario ---
            // Si el usuario existe, actualiza su rol. Si no, lo crea.
            usuarioRepository.findByTrabajadorIdTrab(existente.getIdTrab()).ifPresentOrElse(usuario -> {
                String nuevoRol = determinarRolPorCargo(cargo);
                usuario.setRol(nuevoRol);
                usuarioRepository.save(usuario);
            }, () -> {
                crearUsuarioParaTrabajador(existente);
            }); // <-- FIN: Lógica mejorada
            // --- FIN: Actualización automática de ROL ---
        }

        // Si no tiene token (registros antiguos) o los datos nuevos no lo traen,
        // mantenemos o generamos
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
        if (t.getTipoPago() == null)
            return;

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

    /**
     * Valida que el DNI tenga 8 dígitos numéricos.
     */
    private void validarDni(String dni) {
        if (dni == null || !dni.matches("\\d{8}")) {
            throw new RuntimeException("El DNI debe contener exactamente 8 dígitos numéricos.");
        }
    }
}
