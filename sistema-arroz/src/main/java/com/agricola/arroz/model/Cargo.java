package com.agricola.arroz.model;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "cargos")
public class Cargo {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCargo;
    
    private String nomCargo;
    
    @OneToMany(mappedBy = "cargo")
    private List<Trabajador> trabajadores;
    

    public Cargo() {}
    

    public Cargo(String nomCargo) {
        this.nomCargo = nomCargo;
    }
    

    public Integer getIdCargo() {
        return idCargo;
    }
    
    public void setIdCargo(Integer idCargo) {
        this.idCargo = idCargo;
    }
    
    public String getNomCargo() {
        return nomCargo;
    }
    
    public void setNomCargo(String nomCargo) {
        this.nomCargo = nomCargo;
    }
    
    public List<Trabajador> getTrabajadores() {
        return trabajadores;
    }
    
    public void setTrabajadores(List<Trabajador> trabajadores) {
        this.trabajadores = trabajadores;
    }
}