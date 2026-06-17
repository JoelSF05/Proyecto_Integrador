package com.agricola.arroz.controller;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.model.Usuario;
import com.agricola.arroz.repository.TrabajadorRepository;
import com.agricola.arroz.repository.UsuarioRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // POST /api/auth/login
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body,
                                   HttpServletRequest request) {
        String username = body.get("username");
        String password = body.get("password");
        try {
            Authentication auth = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(username, password)
            );
            SecurityContext sc = SecurityContextHolder.getContext();
            sc.setAuthentication(auth);
            HttpSession session = request.getSession(true);
            session.setAttribute(
                HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, sc);

            // Devolver también el rol para que el frontend sepa qué mostrar
            Usuario usuario = usuarioRepository.findByNombreUsuario(username).orElse(null);
            String rol = (usuario != null && usuario.getRol() != null) ? usuario.getRol() : "TRABAJADOR";

            return ResponseEntity.ok(Map.of(
                "ok", true,
                "username", auth.getName(),
                "rol", rol
            ));
        } catch (AuthenticationException e) {
            return ResponseEntity.status(401).body(Map.of("ok", false, "error", "Credenciales incorrectas"));
        }
    }

    // GET /api/auth/me
    @GetMapping("/me")
    public ResponseEntity<?> me() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getPrincipal())) {
            return ResponseEntity.status(401).body(Map.of("ok", false));
        }
        Usuario usuario = usuarioRepository.findByNombreUsuario(auth.getName()).orElse(null);
        String rol = (usuario != null && usuario.getRol() != null) ? usuario.getRol() : "TRABAJADOR";

        // Nombre real del trabajador vinculado al usuario
        String nombre = auth.getName();
        if (usuario != null && usuario.getTrabajador() != null) {
            nombre = usuario.getTrabajador().getNomTrab() + " " + usuario.getTrabajador().getApeTrab();
        }

        return ResponseEntity.ok(Map.of(
            "ok", true,
            "username", auth.getName(),
            "rol", rol,
            "nombre", nombre
        ));
    }

    // ✅ POST /api/auth/registro-trabajador  — crea usuario para un trabajador existente
    @PostMapping("/registro-trabajador")
    public ResponseEntity<?> registroTrabajador(@RequestBody Map<String, String> body) {
        String dni       = body.get("dni");
        String username  = body.get("username");
        String password  = body.get("password");
        String email     = body.get("email");     // opcional
        String rol       = body.getOrDefault("rol", "TRABAJADOR");

        // Validaciones básicas
        if (dni == null || username == null || password == null) {
            return ResponseEntity.badRequest().body(Map.of("ok", false, "error", "dni, username y password son obligatorios"));
        }
        if (username.trim().length() < 4 || username.trim().length() > 50) {
            return ResponseEntity.badRequest().body(Map.of("ok", false, "error", "El nombre de usuario debe tener entre 4 y 50 caracteres"));
        }
        if (password.length() < 8) {
            return ResponseEntity.badRequest().body(Map.of("ok", false, "error", "La contraseña debe tener al menos 8 caracteres"));
        }
        if (usuarioRepository.findByNombreUsuario(username).isPresent()) {
            return ResponseEntity.badRequest().body(Map.of("ok", false, "error", "El nombre de usuario ya existe"));
        }

        Trabajador trabajador = trabajadorRepository.findByDniTrab(dni);
        if (trabajador == null) {
            return ResponseEntity.badRequest().body(Map.of("ok", false, "error", "No existe trabajador con ese DNI"));
        }

        // Generar token QR automáticamente si no tiene uno
        if (trabajador.getQrToken() == null || trabajador.getQrToken().isEmpty()) {
            trabajador.setQrToken(UUID.randomUUID().toString());
            trabajadorRepository.save(trabajador);
        }

        Usuario nuevo = new Usuario();
        nuevo.setTrabajador(trabajador);
        nuevo.setNombreUsuario(username);
        nuevo.setContrasenaHash(passwordEncoder.encode(password));
        nuevo.setEmail(email);
        nuevo.setRol(rol);
        nuevo.setActivo(true);
        nuevo.setBloqueado(false);

        usuarioRepository.save(nuevo);
        return ResponseEntity.ok(Map.of("ok", true, "mensaje", "Usuario creado correctamente"));
    }
}
