package com.petshop.backend.repositories.contracts;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.petshop.backend.entities.User;

public interface IUserRepository extends JpaRepository<User, Long> {
    public Optional<User> findByUsername(String username);
}
