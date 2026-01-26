package com.example.rentals.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;

/**
 * Объект недвижимости, доступный для аренды.
 * Связан с владельцем через поле {@link #owner}.
 */
@Data
@Entity
@Table(name = "properties")
public class Property {

    /**
     * Уникальный идентификатор объекта недвижимости.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Название объявления / объекта.
     */
    private String title;

    /**
     * Текстовое описание объекта.
     */
    private String description;

    /**
     * Цена аренды за месяц.
     */
    @Column(name = "price_per_month")
    private BigDecimal pricePerMonth;

    /**
     * Почтовый адрес объекта.
     */
    private String address;

    /**
     * Город, в котором находится объект.
     */
    private String city;

    /**
     * Тип недвижимости (Apartment, Studio, House, Room и т.п.).
     */
    @Column(name = "property_type")
    private String propertyType;

    /**
     * Площадь объекта (кв. метры).
     */
    private Double area;

    /**
     * Количество комнат.
     */
    private Integer rooms;

    /**
     * Признак доступности объекта для аренды.
     */
    @Column(name = "is_available")
    private Boolean isAvailable;

    /**
     * Владелец объекта (внешний ключ owner_id → users.id).
     */
    @ManyToOne
    @JoinColumn(name = "owner_id")
    private User owner;
}