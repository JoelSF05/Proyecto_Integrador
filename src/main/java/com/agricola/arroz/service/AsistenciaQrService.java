package com.agricola.arroz.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.agricola.arroz.model.Asistencia;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.AsistenciaRepository;
import com.agricola.arroz.repository.TrabajadorRepository;

@Service
public class AsistenciaQrService {

    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Autowired
    private SimpMessagingTemplate messagingTemplate; // Inyectar SimpMessagingTemplate

    @Transactional
    public String procesarMarcadoQr(String token) {
        // 1. Buscar trabajador por token
        // Usando orElseThrow para un manejo de errores más claro
        Trabajador t = trabajadorRepository.findByQrToken(token)
                .orElseThrow(() -> new RuntimeException("Código QR no reconocido o trabajador inactivo"));

        if (!Boolean.TRUE.equals(t.getActivo())) {
            throw new RuntimeException("El trabajador se encuentra inactivo");
        }

        LocalDate hoy = LocalDate.now(ZoneOffset.UTC);
        // Buscamos todos los registros de hoy para este trabajador
        // Ordenamos por ID para asegurar un comportamiento consistente si existen múltiples registros "abiertos"
        List<Asistencia> registrosHoy = asistenciaRepository.findByTrabajadorIdTrabAndFecAsistOrderByIdAsistAsc(t.getIdTrab(), hoy);

        // Buscamos si existe algún registro "abierto" (sin hora de salida)
        Optional<Asistencia> registroAbierto = registrosHoy.stream()
                .filter(a -> a.getHoraSalida() == null)
                .findFirst();
        
        Asistencia asistenciaGuardada;
        String mensaje;

        if (registroAbierto.isPresent()) {
            Asistencia abierta = registroAbierto.get();
            if (abierta.getHoraEntrada() == null) {
                // Caso A: Hay una tarea asignada (ej. Riego) esperando entrada
                abierta.setHoraEntrada(LocalTime.now(ZoneOffset.UTC));
                abierta.setPresente(true);
                asistenciaGuardada = asistenciaRepository.save(abierta);
                mensaje = "ENTRADA REGISTRADA (Tarea): " + t.getNomTrab() + " a las " + abierta.getHoraEntrada();
            } else {
                // Caso B: Ya entró, registramos su SALIDA
                abierta.setHoraSalida(LocalTime.now(ZoneOffset.UTC));
                asistenciaGuardada = asistenciaRepository.save(abierta);
                mensaje = "SALIDA REGISTRADA: " + t.getNomTrab() + " a las " + abierta.getHoraSalida();
            }
        } else {
            // Caso C: No hay registros hoy o todos están cerrados -> Nueva Entrada
            Asistencia nueva = new Asistencia();
            nueva.setTrabajador(t);
            nueva.setFecAsist(hoy);
            nueva.setHoraEntrada(LocalTime.now(ZoneOffset.UTC));
            nueva.setPresente(true);
            nueva.setEstadoAprobacion("PENDIENTE");
            asistenciaGuardada = asistenciaRepository.save(nueva);
            mensaje = "NUEVA ENTRADA: " + t.getNomTrab() + " a las " + nueva.getHoraEntrada();
        }

        // Publicar el registro de asistencia actualizado/creado a través de WebSocket
        // El frontend puede suscribirse a "/topic/asistencia-updates"
        messagingTemplate.convertAndSend("/topic/asistencia-updates", asistenciaGuardada);

        return mensaje;
    }
}