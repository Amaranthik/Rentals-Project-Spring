package com.example.rentals.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Бронирование (договор аренды) для конкретного объекта и пользователя.
 * Связывает объект недвижимости и арендатора на определённый период дат.
 */
@Data
@Entity
@Table(name = "bookings")
public class Booking {

    /**
     * Уникальный идентификатор бронирования.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Дата начала аренды.
     */
    @Column(name = "start_date")
    private LocalDate startDate;

    /**
     * Дата окончания аренды.
     */
    @Column(name = "end_date")
    private LocalDate endDate;

    /**
     * Статус бронирования (например, Confirmed).
     */
    private String status;

    /**
     * Итоговая сумма договора аренды.
     */
    @Column(name = "total_price")
    private BigDecimal totalPrice;

    /**
     * Забронированный объект недвижимости (FK property_id → properties.id).
     */
    @ManyToOne
    @JoinColumn(name = "property_id")
    private Property property;

    /**
     * Арендатор (пользователь, который снимает объект) —
     * внешний ключ tenant_id → users.id.
     */
    @ManyToOne
    @JoinColumn(name = "tenant_id")
    private User tenant;
}