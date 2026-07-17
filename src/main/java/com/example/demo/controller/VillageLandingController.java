package com.example.demo.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VillageLandingController {

    @GetMapping("/")
    public String landing() {
        // After successful login Spring will redirect here automatically,
        // but we expose a simple landing page that forwards to complaint form.
        return "complaint-form";
    }
}