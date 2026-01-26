package com.example.rentals.entity;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Пользователь системы аренды.
 * Может выступать в роли арендодателя (Landlord) или арендатора (Tenant).
 */
@Data
@Entity
@Table(name = "users")
public class User {

    /**
     * Уникальный идентификатор пользователя (PRIMARY KEY).
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Полное имя пользователя.
     */
    @Column(name = "full_name")
    private String fullName;

    /**
     * Email пользователя (уникальный).
     */
    private String email;

    /**
     * Хэш пароля.
     */
    @Column(name = "password_hash")
    private String passwordHash;

    /**
     * Роль пользователя в системе (например, Landlord или Tenant).
     */
    private String role;

    /**
     * Контактный телефон пользователя.
     */
    private String phone;
}