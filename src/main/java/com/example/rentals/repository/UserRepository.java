package com.example.rentals.repository;

import com.example.rentals.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Репозиторий для работы с сущностью {@link User}.
 * Предоставляет стандартные CRUD-операции через Spring Data JPA.
 */
public interface UserRepository extends JpaRepository<User, Long> {
}