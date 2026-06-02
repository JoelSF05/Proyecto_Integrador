package com.agricola.arroz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String raiz() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // Todas estas rutas requieren autenticación (Spring Security las protege)
    @GetMapping("/layout")
    public String layout() {
        return "layout";
    }

    @GetMapping("/trabajadores")
    public String trabajadores() {
        return "layout";
    }

    @GetMapping("/cosechas")
    public String cosechas() {
        return "layout";
    }

    @GetMapping("/materiales")
    public String materiales() {
        return "layout";
    }

    @GetMapping("/asistencia")
    public String asistencia() {
        return "layout";
    }

    @GetMapping("/riego")
    public String riego() {
        return "layout";
    }

    @GetMapping("/reportes")
    public String reportes() {
        return "layout";
    }
}