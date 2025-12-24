package com.example.rentals.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "properties")
public class Property {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String description;

    @Column(name = "price_per_month")
    private BigDecimal pricePerMonth;

    private String address;
    private String city;

    @Column(name = "property_type")
    private String propertyType;

    private Double area;
    private Integer rooms;

    @Column(name = "is_available")
    private Boolean isAvailable;

    // связь с таблицей users
    @ManyToOne
    @JoinColumn(name = "owner_id")
    private User owner;
}