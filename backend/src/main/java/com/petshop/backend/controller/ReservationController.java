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

import com.petshop.backend.entities.Reservation;
import com.petshop.backend.services.contracts.IReservationService;

// @CrossOrigin(origins = "*")
@RestController
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private IReservationService reservationService;

    @GetMapping("/list")
    private ResponseEntity<List<Reservation>> getAllReservation() {
        return this.reservationService.getAllReservations();
    }

    @GetMapping("/listByUser")
    private ResponseEntity<List<Reservation>> getReservationByUser() {
        return this.reservationService.getReservationByUser();
    }

    @PostMapping("/create")
    private ResponseEntity<Reservation> createReservation(@RequestBody Reservation reservation) {
        return this.reservationService.create(reservation);
    }

    @DeleteMapping("/cancel/{id}")
    private ResponseEntity<Reservation> cancelReservation(@PathVariable Long id) {
        return this.reservationService.cancel(id);
    }
}
