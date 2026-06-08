package com.agricola.arroz.controller;

import com.agricola.arroz.service.AsistenciaQrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/asistencia")
public class AsistenciaQrController {

    @Autowired
    private AsistenciaQrService qrService;

    @PostMapping("/qr")
    public ResponseEntity<?> marcarAsistencia(@RequestBody Map<String, String> body) {
        try {
            String token = body.get("token");
            if (token == null || token.isEmpty()) {
                return ResponseEntity.badRequest().body(Map.of("error", "Token QR ausente"));
            }
            String resultado = qrService.procesarMarcadoQr(token);
            return ResponseEntity.ok(Map.of("mensaje", resultado));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}