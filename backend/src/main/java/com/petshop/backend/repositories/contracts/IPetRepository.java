package com.petshop.backend.repositories.contracts;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.petshop.backend.entities.Pet;

import com.petshop.backend.entities.User;

public interface IPetRepository extends JpaRepository<Pet, Long> {
    List<Pet> findByUser(User user);
}
