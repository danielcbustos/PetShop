package com.petshop.backend.services.contracts;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.petshop.backend.entities.Pet;

public interface IPetService {

    public ResponseEntity<List<Pet>> findAll();

    public ResponseEntity<Pet> create(Pet pet);

    public ResponseEntity<List<Pet>> getPetByUser();

    public ResponseEntity<Pet> delete(Long id);
}
