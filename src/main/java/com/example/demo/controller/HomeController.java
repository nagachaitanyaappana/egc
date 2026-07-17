package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("/")
    public String home(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "index";
    }

    @PostMapping("/users")
    public String addUser(@RequestParam String username, @RequestParam String email,
                          @RequestParam String password, @RequestParam(defaultValue = "USER") String role,
                          @RequestParam String villageName) {
        User user = new User(username, email, password, role, villageName);
        userRepository.save(user);
        return "redirect:/";
    }
}