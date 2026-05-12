package com.agricola.arroz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.agricola.arroz.model.Cargo;
import com.agricola.arroz.model.Trabajador;
import com.agricola.arroz.repository.CargoRepository;
import com.agricola.arroz.repository.TrabajadorRepository;

@RestController
@RequestMapping("/api/trabajadores")
public class TrabajadorController {
    
    @Autowired
    private TrabajadorRepository trabajadorRepository;

    @Autowired
    private CargoRepository cargoRepository;
    
    // Listar todos los trabajadores
    @GetMapping
    public List<Trabajador> listarTodos() {
        return trabajadorRepository.findAll();
    }

    @GetMapping("/cargos")
    public List<Cargo> listarCargos() {
        return cargoRepository.findAll();
    }
    
    // Buscar trabajador por ID
    @GetMapping("/{id}")
    public Trabajador buscarPorId(@PathVariable Integer id) {
        return trabajadorRepository.findById(id).orElse(null);
    }
    
    // Buscar trabajador por DNI
    @GetMapping("/dni/{dni}")
    public Trabajador buscarPorDni(@PathVariable String dni) {
        return trabajadorRepository.findByDniTrab(dni);
    }
    
    // Crear nuevo trabajador
    @PostMapping
    public Trabajador crear(@RequestBody Trabajador trabajador) {
        if (trabajador.getCargoId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El cargo es obligatorio");
        }

        Cargo cargo = cargoRepository.findById(trabajador.getCargoId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cargo no existe"));
        trabajador.setCargo(cargo);

        return trabajadorRepository.save(trabajador);
    }
    
    // Actualizar trabajador
    @PutMapping("/{id}")
    public Trabajador actualizar(@PathVariable Integer id, @RequestBody Trabajador trabajador) {
        trabajador.setIdTrab(id);
        if (trabajador.getCargoId() != null) {
            Cargo cargo = cargoRepository.findById(trabajador.getCargoId())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cargo no existe"));
            trabajador.setCargo(cargo);
        }
        return trabajadorRepository.save(trabajador);
    }
    
    // Eliminar trabajador
    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Integer id) {
        trabajadorRepository.deleteById(id);
    }
}