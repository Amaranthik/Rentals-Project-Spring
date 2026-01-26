package com.example.rentals.controller;

import com.example.rentals.entity.Booking;
import com.example.rentals.entity.Property;
import com.example.rentals.entity.User;
import com.example.rentals.repository.BookingRepository;
import com.example.rentals.repository.PropertyRepository;
import com.example.rentals.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Веб-контроллер приложения.
 * Отвечает за работу с объектами недвижимости, пользователями и бронированиями.
 */
@Controller
public class PropertyController {

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookingRepository bookingRepository;

    /**
     * Отображает список объектов недвижимости.
     * При наличии параметра keyword выполняет поиск по названию и городу.
     *
     * @param keyword строка поиска (может быть null)
     * @param model   модель для передачи данных в шаблон
     * @return имя шаблона со списком объектов
     */
    @GetMapping("/properties")
    public String listProperties(@RequestParam(required = false) String keyword, Model model) {
        List<Property> properties;
        if (keyword != null && !keyword.isEmpty()) {
            properties = propertyRepository
                    .findByTitleContainingIgnoreCaseOrCityContainingIgnoreCase(keyword, keyword);
        } else {
            properties = propertyRepository.findAll();
        }
        model.addAttribute("properties", properties);
        model.addAttribute("keyword", keyword);
        return "properties-list";
    }

    /**
     * Отображает форму создания нового объекта недвижимости.
     *
     * @param model модель для передачи пустого объекта и списка пользователей
     * @return имя шаблона формы объекта
     */
    @GetMapping("/properties/new")
    public String showCreateForm(Model model) {
        model.addAttribute("property", new Property());
        model.addAttribute("users", userRepository.findAll());
        return "property-form";
    }

    /**
     * Сохраняет объект недвижимости (создание или редактирование).
     *
     * @param property объект, полученный из формы
     * @return редирект на список объектов
     */
    @PostMapping("/properties/save")
    public String saveProperty(@ModelAttribute Property property) {
        if (property.getIsAvailable() == null) {
            property.setIsAvailable(true);
        }
        propertyRepository.save(property);
        return "redirect:/properties";
    }

    /**
     * Удаляет объект недвижимости по идентификатору.
     *
     * @param id идентификатор объекта
     * @return редирект на список объектов
     */
    @GetMapping("/properties/delete/{id}")
    public String deleteProperty(@PathVariable Long id) {
        propertyRepository.deleteById(id);
        return "redirect:/properties";
    }

    /**
     * Отображает форму редактирования существующего объекта недвижимости.
     *
     * @param id    идентификатор объекта
     * @param model модель для передачи объекта и списка пользователей
     * @return имя шаблона формы объекта
     */
    @GetMapping("/properties/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Property property = propertyRepository.findById(id).orElseThrow();
        model.addAttribute("property", property);
        model.addAttribute("users", userRepository.findAll());
        return "property-form";
    }

    /**
     * Отображает список всех бронирований.
     *
     * @param model модель для передачи списка бронирований
     * @return имя шаблона со списком бронирований
     */
    @GetMapping("/bookings")
    public String listBookings(Model model) {
        model.addAttribute("bookings", bookingRepository.findAll());
        return "bookings-list";
    }

    /**
     * Отображает форму оформления бронирования для выбранного объекта.
     *
     * @param id    идентификатор объекта недвижимости
     * @param model модель для передачи объекта, бронирования и списка пользователей
     * @return имя шаблона формы бронирования
     */
    @GetMapping("/properties/{id}/book")
    public String showBookingForm(@PathVariable Long id, Model model) {
        Property property = propertyRepository.findById(id).orElseThrow();
        Booking booking = new Booking();
        booking.setProperty(property);
        model.addAttribute("booking", booking);
        model.addAttribute("property", property);
        model.addAttribute("users", userRepository.findAll());
        return "booking-form";
    }

    /**
     * Сохраняет новое бронирование.
     *
     * @param booking объект бронирования, полученный из формы
     * @return редирект на список бронирований
     */
    @PostMapping("/bookings/save")
    public String saveBooking(@ModelAttribute Booking booking) {
        booking.setStatus("Confirmed");
        bookingRepository.save(booking);
        return "redirect:/bookings";
    }

    /**
     * Удаляет (отменяет) бронирование по идентификатору.
     *
     * @param id идентификатор бронирования
     * @return редирект на список бронирований
     */
    @GetMapping("/bookings/delete/{id}")
    public String deleteBooking(@PathVariable Long id) {
        bookingRepository.deleteById(id);
        return "redirect:/bookings";
    }

    /**
     * Отображает список всех пользователей системы.
     *
     * @param model модель для передачи списка пользователей
     * @return имя шаблона со списком пользователей
     */
    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "users-list";
    }

    /**
     * Отображает форму создания нового пользователя.
     *
     * @param model модель для передачи пустого объекта пользователя
     * @return имя шаблона формы пользователя
     */
    @GetMapping("/users/new")
    public String showUserCreateForm(Model model) {
        model.addAttribute("user", new User());
        return "user-form";
    }

    /**
     * Сохраняет пользователя (создание или редактирование).
     *
     * @param user объект пользователя, полученный из формы
     * @return редирект на список пользователей
     */
    @PostMapping("/users/save")
    public String saveUser(@ModelAttribute User user) {
        user.setPasswordHash("12345");
        userRepository.save(user);
        return "redirect:/users";
    }

    /**
     * Отображает форму редактирования пользователя.
     *
     * @param id    идентификатор пользователя
     * @param model модель для передачи объекта пользователя
     * @return имя шаблона формы пользователя
     */
    @GetMapping("/users/edit/{id}")
    public String showUserEditForm(@PathVariable Long id, Model model) {
        User user = userRepository.findById(id).orElseThrow();
        model.addAttribute("user", user);
        return "user-form";
    }

    /**
     * Удаляет пользователя по идентификатору.
     * В случае ошибок (например, при наличии зависимостей) исключение игнорируется.
     *
     * @param id идентификатор пользователя
     * @return редирект на список пользователей
     */
    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        try {
            userRepository.deleteById(id);
        } catch (Exception e) {
            // намеренно игнорируем исключение при наличии зависимостей
        }
        return "redirect:/users";
    }

    /**
     * Перенаправляет корневой URL на список объектов недвижимости.
     *
     * @return редирект на /properties
     */
    @GetMapping("/")
    public String home() {
        return "redirect:/properties";
    }
}