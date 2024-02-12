package com.petshop.backend.services.implementations;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.petshop.backend.entities.Reservation;
import com.petshop.backend.entities.User;
import com.petshop.backend.repositories.contracts.IReservationRepository;
import com.petshop.backend.security.authentication.AuthService;
import com.petshop.backend.services.contracts.IReservationService;

@Service
public class ReservationService implements IReservationService {

    @Autowired
    private IReservationRepository reservationRepository;
    @Autowired
    private AuthService authService;

    @Override
    public ResponseEntity<List<Reservation>> getAllReservations() {
        try {
            List<Reservation> reservations = this.reservationRepository.findAll();
            return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<List<Reservation>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<Reservation> create(Reservation reservation) {

        try {
            User currentUser = this.authService.getCurrentUser();
            reservation.setUser(currentUser);
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime aMonth = now.plusMonths(1);

            LocalDateTime reservationDate = reservation.getReservationDate();

            List<Reservation> existingReservations = this.reservationRepository.findByReservationDate(reservationDate);

            if (!existingReservations.isEmpty()) {
                throw new RuntimeException("Ya tienes una reserva para ese día, elige otro día.");
            }

            if (reservation.getReservationDate().isAfter(aMonth)) {
                throw new RuntimeException("No se pueden hacer reservas con más de 1 mes de anticipación.");
            }

            reservation.setAvailable(false);
            Reservation reservationSaves = this.reservationRepository.save(reservation);
            return new ResponseEntity<Reservation>(reservationSaves, HttpStatus.CREATED);
        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<Reservation>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @Override
    public ResponseEntity<Reservation> cancel(Long id) {
        try {
            User currentUser = this.authService.getCurrentUser();
            List<Reservation> userReservations = this.reservationRepository.findByUser(currentUser);
            Optional<Reservation> reservationToDelete = userReservations.stream()
                    .filter(reservation -> reservation.getId().equals(id))
                    .findFirst();
            if (reservationToDelete.isPresent()) {
                Reservation reservation = reservationToDelete.get();
                this.reservationRepository.delete(reservation);
                return new ResponseEntity<Reservation>(HttpStatus.OK);
            } else {
                return new ResponseEntity<Reservation>(HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<Reservation>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<List<Reservation>> getReservationByUser() {

        User currentUser = this.authService.getCurrentUser();
        List<Reservation> reservationsByUser = this.reservationRepository.findByUser(currentUser);
        return new ResponseEntity<List<Reservation>>(reservationsByUser, HttpStatus.OK);

    }

}
