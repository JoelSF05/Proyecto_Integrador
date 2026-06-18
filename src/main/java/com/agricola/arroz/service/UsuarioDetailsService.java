package com.agricola.arroz.service;

import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.ZoneId;

@Service
public class UsuarioDetailsService implements UserDetailsService {

    private static final ZoneId PERU_ZONE = ZoneId.of("America/Lima");
    private static final int MAX_INTENTOS = 5;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByNombreUsuario(username)
            .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        if (Boolean.TRUE.equals(usuario.getBloqueado())) {
            throw new LockedException("Cuenta bloqueada por demasiados intentos fallidos");
        }
        if (!Boolean.TRUE.equals(usuario.getActivo())) {
            throw new DisabledException("Usuario inactivo");
        }

        String rol = (usuario.getRol() != null) ? usuario.getRol() : "TRABAJADOR";

        // Devolvemos un UserDetails con un password "decorado" que incluye el id
        // para poder identificar al usuario en el postCheck sin consultar la BD de nuevo
        return User.builder()
            .username(usuario.getNombreUsuario())
            .password(usuario.getContrasenaHash())
            .roles(rol)
            .build();
    }

    /** Llamado desde el AuthenticationSuccessHandler — resetea intentos y guarda ultimoLogin */
    public void registrarLoginExitoso(String username) {
        usuarioRepository.findByNombreUsuario(username).ifPresent(u -> {
            u.setIntentosFallidos(0);
            u.setUltimoLogin(Instant.now());
            usuarioRepository.save(u);
        });
    }

    /**
     * Llamado desde el AuthenticationFailureHandler.
     * Incrementa el contador y bloquea la cuenta al llegar a MAX_INTENTOS.
     * Retorna true si la cuenta quedó bloqueada en este intento.
     */
    public boolean registrarLoginFallido(String username) {
        return usuarioRepository.findByNombreUsuario(username).map(u -> {
            int intentos = (u.getIntentosFallidos() == null ? 0 : u.getIntentosFallidos()) + 1;
            u.setIntentosFallidos(intentos);
            if (intentos >= MAX_INTENTOS) {
                u.setBloqueado(true);
            }
            usuarioRepository.save(u);
            return intentos >= MAX_INTENTOS;
        }).orElse(false);
    }
}
