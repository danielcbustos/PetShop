package com.petshop.backend.services.implementations;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.petshop.backend.entities.Pet;
import com.petshop.backend.entities.User;
import com.petshop.backend.repositories.contracts.IPetRepository;
import com.petshop.backend.security.authentication.AuthService;
import com.petshop.backend.services.contracts.IPetService;

@Service
public class PetService implements IPetService {

    @Autowired
    private IPetRepository petRepository;
    @Autowired
    private AuthService authService;

    @Override
    public ResponseEntity<List<Pet>> findAll() {
        try {
            List<Pet> pets = this.petRepository.findAll();
            return new ResponseEntity<List<Pet>>(pets, HttpStatus.OK);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<List<Pet>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<Pet> create(Pet pet) {

        try {
            User currentUser = this.authService.getCurrentUser();
            // pet.setUser(currentUser);
            Pet petSaves = this.petRepository.save(pet);
            return new ResponseEntity<Pet>(petSaves, HttpStatus.CREATED);
        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<Pet>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<Pet> delete(Long id) {
        try {
            User currentUser = this.authService.getCurrentUser();
            List<Pet> userPets = this.petRepository.findByUser(currentUser);
            Optional<Pet> petToDelete = userPets.stream()
                    .filter(pet -> pet.getId().equals(id))
                    .findFirst();
            if (petToDelete.isPresent()) {
                Pet pet = petToDelete.get();
                this.petRepository.delete(pet);
                return new ResponseEntity<Pet>(HttpStatus.OK);
            } else {
                return new ResponseEntity<Pet>(HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<Pet>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<List<Pet>> getPetByUser() {

        User currentUser = this.authService.getCurrentUser();
        List<Pet> petsByUser = this.petRepository.findByUser(currentUser);
        return new ResponseEntity<List<Pet>>(petsByUser, HttpStatus.OK);

    }

}
