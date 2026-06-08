package com.agricola.arroz.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic"); // Habilita un broker de mensajes simple en memoria para enviar mensajes a clientes suscritos a destinos con prefijo "/topic"
        config.setApplicationDestinationPrefixes("/app"); // Prefijo para mensajes que van a métodos @MessageMapping en controladores
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws").withSockJS(); // Registra el endpoint "/ws" para la conexión WebSocket, con soporte SockJS para navegadores antiguos
    }
}