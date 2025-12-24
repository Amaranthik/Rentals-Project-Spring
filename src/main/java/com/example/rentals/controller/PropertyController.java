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

@Controller
public class PropertyController {

    @Autowired
    private PropertyRepository propertyRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BookingRepository bookingRepository;

    @GetMapping("/properties")
    public String listProperties(@RequestParam(required = false) String keyword, Model model) {
        List<Property> properties;
        if (keyword != null && !keyword.isEmpty()) {
            properties = propertyRepository.findByTitleContainingIgnoreCaseOrCityContainingIgnoreCase(keyword, keyword);
        } else {
            properties = propertyRepository.findAll();
        }
        model.addAttribute("properties", properties);
        model.addAttribute("keyword", keyword);
        return "properties-list";
    }

    @GetMapping("/properties/new")
    public String showCreateForm(Model model) {
        model.addAttribute("property", new Property());
        model.addAttribute("users", userRepository.findAll());
        return "property-form";
    }

    @PostMapping("/properties/save")
    public String saveProperty(@ModelAttribute Property property) {
        if (property.getIsAvailable() == null) property.setIsAvailable(true);
        propertyRepository.save(property);
        return "redirect:/properties";
    }

    @GetMapping("/properties/delete/{id}")
    public String deleteProperty(@PathVariable Long id) {
        propertyRepository.deleteById(id);
        return "redirect:/properties";
    }

    @GetMapping("/properties/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Property property = propertyRepository.findById(id).orElseThrow();
        model.addAttribute("property", property);
        model.addAttribute("users", userRepository.findAll());
        return "property-form";
    }

    @GetMapping("/bookings")
    public String listBookings(Model model) {
        model.addAttribute("bookings", bookingRepository.findAll());
        return "bookings-list";
    }

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

    @PostMapping("/bookings/save")
    public String saveBooking(@ModelAttribute Booking booking) {
        booking.setStatus("Confirmed");
        bookingRepository.save(booking);
        return "redirect:/bookings";
    }

    @GetMapping("/bookings/delete/{id}")
    public String deleteBooking(@PathVariable Long id) {
        bookingRepository.deleteById(id);
        return "redirect:/bookings";
    }

    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "users-list";
    }

    @GetMapping("/users/new")
    public String showUserCreateForm(Model model) {
        model.addAttribute("user", new User());
        return "user-form";
    }

    @PostMapping("/users/save")
    public String saveUser(@ModelAttribute User user) {
        user.setPasswordHash("12345"); // Заглушка для пароля
        userRepository.save(user);
        return "redirect:/users";
    }

    @GetMapping("/users/edit/{id}")
    public String showUserEditForm(@PathVariable Long id, Model model) {
        User user = userRepository.findById(id).orElseThrow();
        model.addAttribute("user", user);
        return "user-form";
    }

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        try {
            userRepository.deleteById(id);
        } catch (Exception e) {
            // Игнорируем ошибку если у юзера есть квартиры
        }
        return "redirect:/users";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/properties";
    }
}