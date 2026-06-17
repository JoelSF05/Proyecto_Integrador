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
                // Rutas públicas — solo login y recursos estáticos
                .requestMatchers(
                    "/login",
                    "/api/auth/login",
                    "/css/**", "/js/**", "/images/**"
                ).permitAll()
                // Solo admins pueden crear/gestionar usuarios
                .requestMatchers("/api/usuarios/**").hasRole("ADMIN")
                // Registro de trabajador solo para ADMIN
                .requestMatchers("/api/auth/registro-trabajador").hasRole("ADMIN")
                // El resto requiere autenticación
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/layout", true)
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .permitAll()
            )
            // ✅ CSRF activado — se excluyen solo las APIs REST con token propio
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/api/asistencias/qr/**") // WebSocket QR usa token propio
            );

        return http.build();
    }
}
