package com.example.rentals;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Точка входа в приложение Spring Boot.
 * Запускает встроенный веб‑сервер и инициализирует контекст Spring.
 */
@SpringBootApplication
public class RentalsApplication {

	/**
	 * Главный метод запуска приложения.
	 *
	 * @param args аргументы командной строки (не используются)
	 */
	public static void main(String[] args) {
		SpringApplication.run(RentalsApplication.class, args);
	}

}