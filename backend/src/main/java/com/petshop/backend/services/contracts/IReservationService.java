package com.petshop.backend.services.contracts;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.petshop.backend.entities.Reservation;

public interface IReservationService {

    public ResponseEntity<List<Reservation>> getAllReservations();

    public ResponseEntity<Reservation> create(Reservation reservation);

    public ResponseEntity<List<Reservation>> getReservationByUser();

    public ResponseEntity<Reservation> cancel(Long id);
}
