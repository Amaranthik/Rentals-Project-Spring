package com.example.rentals.repository;

import com.example.rentals.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Репозиторий для работы с сущностью {@link Booking}.
 * Обеспечивает доступ к таблице бронирований.
 */
public interface BookingRepository extends JpaRepository<Booking, Long> {
}