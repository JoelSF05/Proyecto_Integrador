package com.agricola.arroz.config;

import com.agricola.arroz.service.UsuarioDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.security.authentication.event.AbstractAuthenticationFailureEvent;
import org.springframework.stereotype.Component;

/**
 * Escucha logins fallidos e incrementa el contador de intentos.
 * Tras 5 intentos consecutivos, la cuenta queda bloqueada (bloqueado = true).
 * Un ADMIN debe desbloquearla manualmente desde la BD o via API futura.
 */
@Component
public class LoginFailureListener {

    @Autowired
    private UsuarioDetailsService usuarioDetailsService;

    @EventListener
    public void onFailure(AbstractAuthenticationFailureEvent event) {
        // getName() devuelve el username que se intentó usar
        String username = event.getAuthentication().getName();
        usuarioDetailsService.registrarLoginFallido(username);
    }
}
