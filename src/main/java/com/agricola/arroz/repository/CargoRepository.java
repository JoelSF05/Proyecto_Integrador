package com.agricola.arroz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.agricola.arroz.model.Cargo;

public interface CargoRepository extends JpaRepository<Cargo, Integer> {
}
