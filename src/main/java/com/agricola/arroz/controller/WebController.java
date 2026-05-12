package com.agricola.arroz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {
    
    @GetMapping("/")
    public String inicio() {
        return "index";
    }
    
    @GetMapping("/trabajadores")
    public String trabajadores() {
        return "trabajadores";
    }
    
    @GetMapping("/cosechas")
    public String cosechas() {
        return "cosechas";
    }
    
    @GetMapping("/materiales")
    public String materiales() {
        return "materiales";
    }
    
    @GetMapping("/asistencia")
    public String asistencia() {
        return "asistencia";
    }
}