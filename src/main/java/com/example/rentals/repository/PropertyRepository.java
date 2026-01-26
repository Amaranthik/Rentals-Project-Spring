package com.example.rentals.repository;

import com.example.rentals.entity.Property;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Репозиторий для работы с сущностью {@link Property}.
 * Используется для выполнения CRUD-операций и поиска объектов недвижимости.
 */
public interface PropertyRepository extends JpaRepository<Property, Long> {

    /**
     * Находит объекты недвижимости, у которых название или город
     * содержат указанную подстроку (без учёта регистра).
     *
     * @param title часть названия объекта
     * @param city  часть названия города
     * @return список найденных объектов
     */
    List<Property> findByTitleContainingIgnoreCaseOrCityContainingIgnoreCase(String title, String city);
}