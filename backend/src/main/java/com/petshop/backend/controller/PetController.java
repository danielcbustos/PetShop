package com.petshop.backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.petshop.backend.entities.Pet;
import com.petshop.backend.services.contracts.IPetService;

@RestController
@RequestMapping("/pet")
public class PetController {
    @Autowired
    private IPetService petService;

    @GetMapping("/list")
    private ResponseEntity<List<Pet>> getAllPets() {
        return this.petService.findAll();
    }

    @GetMapping("/listByUser")
    private ResponseEntity<List<Pet>> getPetByUser() {
        return this.petService.getPetByUser();
    }

    @PostMapping("/create")
    private ResponseEntity<Pet> createPet(@RequestBody Pet pet) {
        return this.petService.create(pet);
    }

    @DeleteMapping("/delete/{id}")
    private ResponseEntity<Pet> deletePet(@PathVariable Long id) {
        return this.petService.delete(id);
    }
}
