package com.agricola.arroz.config;

import com.agricola.arroz.service.UsuarioDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.authentication.LockedException;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UsuarioDetailsService usuarioDetailsService;

    public SecurityConfig(@Lazy UsuarioDetailsService usuarioDetailsService) {
        this.usuarioDetailsService = usuarioDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .userDetailsService(usuarioDetailsService)
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/login",
                    "/api/auth/login",
                    "/css/**", "/js/**", "/images/**"
                ).permitAll()
                .requestMatchers("/api/usuarios/**").hasRole("ADMIN")
                .requestMatchers("/api/auth/registro-trabajador").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/layout", true)
                // ✅ SUCCESS: resetea contador de intentos y guarda ultimoLogin
                .successHandler((request, response, authentication) -> {
                    usuarioDetailsService.registrarLoginExitoso(authentication.getName());
                    response.sendRedirect("/layout");
                })
                // ✅ FAILURE: incrementa contador; si llega a 5 bloquea la cuenta
                .failureHandler((request, response, exception) -> {
                    String username = request.getParameter("username");
                    if (username != null && !username.isBlank()) {
                        boolean bloqueado = usuarioDetailsService.registrarLoginFallido(username);
                        if (bloqueado || exception instanceof LockedException) {
                            response.sendRedirect("/login?bloqueado=true");
                            return;
                        }
                    }
                    response.sendRedirect("/login?error=true");
                })
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .permitAll()
            )
            .csrf(csrf -> csrf
    .ignoringRequestMatchers("/api/**", "/login")
);

        return http.build();
    }
}
