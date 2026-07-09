package com.agricola.arroz.repository;

import com.agricola.arroz.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<Usuario> findByNombreUsuario(String nombreUsuario);

    // Busca un usuario por el ID del trabajador asociado
    Optional<Usuario> findByTrabajadorIdTrab(Integer idTrab);
}
