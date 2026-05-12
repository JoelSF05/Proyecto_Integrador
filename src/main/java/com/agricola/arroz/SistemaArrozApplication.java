package com.agricola.arroz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class SistemaArrozApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(SistemaArrozApplication.class, args);

        String port = context.getEnvironment().getProperty("server.port");
        if (port == null) port = "8080"; // Valor por defecto

        // Imprimimos con un formato llamativo
        System.out.println("\n\n" + "=".repeat(50));
        System.out.println("SISTEMA AGRÍCOLA LISTO PARA USAR");
        System.out.println("URL: http://localhost:" + port);
        System.out.println("=".repeat(50) + "\n");
    }
}