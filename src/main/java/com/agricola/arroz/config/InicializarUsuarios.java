package com.agricola.arroz.config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.agricola.arroz.model.Cargo;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.model.TipoPago;
import com.agricola.arroz.repository.CargoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;
import com.agricola.arroz.repository.UsuarioRepository;

@Component
public class InicializarUsuarios implements CommandLineRunner {

    @Autowired
    private UsuarioRepository usuarioRepo;
    @Autowired
    private TrabajadorRepository trabajadorRepo;
    @Autowired
    private CargoRepository cargoRepo;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        hacer("admin", "admin123", 1);
        hacer("supervisor", "super2024", 2);
        hacer("contador", "conta2026", 5); // Nuevo usuario CONTADOR
    }

    private void hacer(String user, String pass, int idCargo) {
        Optional<Usuario> existente = usuarioRepo.findByNombreUsuario(user);

        if (existente.isPresent()) {
            Usuario u = existente.get();
            if (u.getContrasenaHash() == null || !u.getContrasenaHash().startsWith("$2")) {
                u.setContrasenaHash(passwordEncoder.encode(pass));
                usuarioRepo.save(u);
            }
            return;
        }

        Cargo cargo = cargoRepo.findById(idCargo).orElse(null);
        if (cargo == null) {
            System.out.println("AVISO: no hay cargo id=" + idCargo + ", creando...");
            String nombreCargo = "Indefinido";
            if (user.equals("admin"))
                nombreCargo = "Administrador";
            else if (user.equals("supervisor"))
                nombreCargo = "Supervisor";
            else if (user.equals("contador"))
                nombreCargo = "Contador";
            else
                nombreCargo = user.substring(0, 1).toUpperCase() + user.substring(1);

            cargo = new Cargo(nombreCargo);
            cargo = cargoRepo.save(cargo);
        }

        Trabajador t = trabajadorRepo.findByDniTrab("SYS0000" + idCargo);
        if (t == null) {
            t = new Trabajador();
            t.setNomTrab(user.substring(0, 1).toUpperCase() + user.substring(1));
            t.setApeTrab("Sistema");
            t.setDniTrab("SYS0000" + idCargo);
            t.setCargo(cargo);
            t.setTipoPago(TipoPago.TIEMPO); // Esto guardará "TIEMPO" en la BD
            t = trabajadorRepo.save(t);
        }

        Usuario u = new Usuario();
        u.setNombreUsuario(user);
        // Asignar rol basado en el nombre de usuario
        String rol = "TRABAJADOR";
        if (user.equals("admin"))
            rol = "ADMIN";
        else if (user.equals("supervisor"))
            rol = "SUPERVISOR";
        else if (user.equals("contador"))
            rol = "CONTADOR";

        u.setRol(rol);
        u.setContrasenaHash(passwordEncoder.encode(pass));
        u.setTrabajador(t);
        u.setActivo(true);
        u.setBloqueado(false);
        usuarioRepo.save(u);
        System.out.println("Usuario creado: " + user + " / " + pass);
    }
}
