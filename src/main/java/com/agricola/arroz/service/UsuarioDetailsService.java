package com.agricola.arroz.service;

import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UsuarioDetailsService implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByNombreUsuario(username)
            .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado: " + username));

        if (Boolean.TRUE.equals(usuario.getBloqueado())) {
            throw new UsernameNotFoundException("Usuario bloqueado");
        }
        if (!Boolean.TRUE.equals(usuario.getActivo())) {
            throw new UsernameNotFoundException("Usuario inactivo");
        }

        // ✅ Usa el rol real de la BD (ADMIN, SUPERVISOR, TRABAJADOR)
        String rol = (usuario.getRol() != null) ? usuario.getRol() : "TRABAJADOR";

        // Actualizar último login
        usuario.setUltimoLogin(LocalDateTime.now());
        usuario.setIntentosFallidos(0);
        usuarioRepository.save(usuario);

        return User.builder()
            .username(usuario.getNombreUsuario())
            .password(usuario.getContrasenaHash())
            .roles(rol)   // Spring agrega el prefijo ROLE_ automáticamente
            .build();
    }
}
