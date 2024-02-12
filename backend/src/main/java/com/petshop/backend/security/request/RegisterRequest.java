package com.petshop.backend.security.request;

import java.util.List;

import com.petshop.backend.entities.Pet;
import com.petshop.backend.entities.Reservation;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RegisterRequest {
    private String username;
    private String password;
    private String firstname;
    private String lastname;
    private String email;
    // private List<Pet> pets;
    // private List<Reservation> reservations;
}