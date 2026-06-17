package com.agricola.arroz.config;

import com.agricola.arroz.service.UsuarioDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.stereotype.Component;

/**
 * Escucha logins exitosos y actualiza ultimoLogin + resetea intentos fallidos.
 * Se hace aquí (no en loadUserByUsername) porque ese método se llama
 * en cada request, no solo al hacer login.
 */
@Component
public class LoginSuccessListener {

    @Autowired
    private UsuarioDetailsService usuarioDetailsService;

    @EventListener
    public void onSuccess(AuthenticationSuccessEvent event) {
        String username = event.getAuthentication().getName();
        usuarioDetailsService.registrarLoginExitoso(username);
    }
}
