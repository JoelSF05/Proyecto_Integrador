package com.agricola.arroz.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.servlet.resource.NoResourceFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * NUEVO: GlobalExceptionHandler
 * Captura errores y devuelve respuestas JSON claras al frontend.
 * Crear en: src/main/java/com/agricola/arroz/exception/GlobalExceptionHandler.java
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    // Errores de validación (@NotBlank, @Size, etc.)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, Object>> manejarValidaciones(
            MethodArgumentNotValidException ex) {

        Map<String, String> erroresCampos = new HashMap<>();
        for (FieldError error : ex.getBindingResult().getFieldErrors()) {
            erroresCampos.put(error.getField(), error.getDefaultMessage());
        }

        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("timestamp", LocalDateTime.now().toString());
        respuesta.put("status", 400);
        respuesta.put("mensaje", "Error de validación");
        respuesta.put("errores", erroresCampos);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(respuesta);
    }

    // Errores de negocio (lanzados desde los Services)
    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, Object>> manejarRuntimeException(RuntimeException ex) {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("timestamp", LocalDateTime.now().toString());
        respuesta.put("status", 400);
        respuesta.put("error", ex.getMessage());

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(respuesta);
    }

    // Manejar recursos no encontrados (como el favicon.ico) para evitar el error 500
    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<Void> manejarRecursoNoEncontrado() {
        return ResponseEntity.notFound().build();
    }

    // Cualquier otro error inesperado
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> manejarException(Exception ex) {
        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("timestamp", LocalDateTime.now().toString());
        respuesta.put("status", 500);
        respuesta.put("error", "Error interno del servidor");
        respuesta.put("detalle", ex.getMessage());

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(respuesta);
    }
}
