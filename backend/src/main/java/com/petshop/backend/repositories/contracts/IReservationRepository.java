package com.petshop.backend.repositories.contracts;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.petshop.backend.entities.Reservation;
import com.petshop.backend.entities.User;

public interface IReservationRepository extends JpaRepository<Reservation, Long> {
    public List<Reservation> findByReservationDate(LocalDateTime reservationDate);

    List<Reservation> findByUser(User user);
}
