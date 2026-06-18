package com.agricola.arroz.model;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "cargos")
public class Cargo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCargo;

    private String nomCargo;

    @OneToMany(mappedBy = "cargo")
    private List<Trabajador> trabajadores;

    // Constructor por defecto requerido por JPA/Hibernate (Fix para fallos de Lombok)
    public Cargo() {
    }

    // ── Constructor con parámetro — Lombok no lo genera, se mantiene manual ──
    public Cargo(String nomCargo) {
        this.nomCargo = nomCargo;
    }

    // ── Métodos manuales para asegurar compilación (fix para "cannot find symbol") ──
    public Integer getIdCargo() {
        return idCargo;
    }

    public String getNomCargo() {
        return nomCargo;
    }

    public void setIdCargo(Integer idCargo) {
        this.idCargo = idCargo;
    }

    public void setNomCargo(String nomCargo) {
        this.nomCargo = nomCargo;
    }
}
