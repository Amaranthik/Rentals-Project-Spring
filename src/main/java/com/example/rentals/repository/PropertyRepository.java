package com.example.rentals.repository;

import com.example.rentals.entity.Property;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PropertyRepository extends JpaRepository<Property, Long> {
    List<Property> findByTitleContainingIgnoreCaseOrCityContainingIgnoreCase(String title, String city);
}