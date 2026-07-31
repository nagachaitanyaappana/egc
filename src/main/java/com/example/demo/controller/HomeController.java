package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.model.Village;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.VillageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VillageRepository villageRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/users")
    public String addUser(@RequestParam String username, @RequestParam String email,
                          @RequestParam String password, @RequestParam(defaultValue = "USER") String role,
                          @RequestParam String villageName) {
        String encodedPassword = passwordEncoder.encode(password);
        Village village = villageRepository.findByName(villageName)
                .orElseGet(() -> villageRepository.save(new Village(villageName, null)));
        User user = new User(username, email, encodedPassword, role, village);
        userRepository.save(user);
        return "redirect:/";
    }
}