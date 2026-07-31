package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.security.JwtUtil;
import com.example.demo.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Controller
public class PasswordResetController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String submitForgotPassword(@RequestParam String email, Model model) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            String otp = UUID.randomUUID().toString().replace("-", "").substring(0, 6).toUpperCase();
            user.setResetToken(otp);
            user.setResetTokenExpiry(LocalDateTime.now().plusMinutes(10));
            userRepository.save(user);

            String maskedEmail = maskEmail(user.getEmail());
            System.out.println("PASSWORD RESET OTP for " + maskedEmail + ": " + otp);

            if (mailSender != null) {
                try {
                    SimpleMailMessage message = new SimpleMailMessage();
                    message.setTo(user.getEmail());
                    message.setSubject("Password Reset Verification Code");
                    message.setText("Your password reset verification code is: " + otp + "\n\nThis code will expire in 10 minutes.");
                    message.setFrom("noreply@egc.local");
                    mailSender.send(message);
                } catch (Exception e) {
                    System.out.println("Failed to send email: " + e.getMessage());
                }
            }

            model.addAttribute("email", user.getEmail());
            model.addAttribute("maskedEmail", maskedEmail);
            model.addAttribute("otpSent", true);
            model.addAttribute("step2", true);
        } else {
            model.addAttribute("notFound", true);
        }
        return "forgot-password";
    }

    @PostMapping("/reset-password")
    public String submitResetPassword(@RequestParam String email,
                                      @RequestParam String otp,
                                      @RequestParam String newPassword,
                                      @RequestParam String confirmPassword,
                                      HttpServletResponse response,
                                      Model model) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty()) {
            model.addAttribute("email", email);
            model.addAttribute("step2", true);
            model.addAttribute("error", "Invalid email address.");
            return "forgot-password";
        }

        User user = userOpt.get();

        if (!otp.equals(user.getResetToken())) {
            model.addAttribute("email", email);
            model.addAttribute("step2", true);
            model.addAttribute("error", "Invalid verification code.");
            return "forgot-password";
        }

        if (user.getResetTokenExpiry() == null || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            model.addAttribute("email", email);
            model.addAttribute("step2", true);
            model.addAttribute("error", "Verification code has expired. Please request a new one.");
            return "forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("email", email);
            model.addAttribute("step2", true);
            model.addAttribute("error", "Passwords do not match.");
            return "forgot-password";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setResetToken(null);
        user.setResetTokenExpiry(null);
        userRepository.save(user);

        UserDetails userDetails = userDetailsService.loadUserByUsername(user.getUsername());
        String jwtToken = jwtUtil.generateToken(userDetails);

        String landing = "/complaint";
        boolean isAdmin = user.getRole() != null && user.getRole().contains("ADMIN");
        if (isAdmin) {
            landing = "/admin/dashboard";
        }

        jakarta.servlet.http.Cookie cookie = new jakarta.servlet.http.Cookie("token", jwtToken);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(24 * 60 * 60);
        response.addCookie(cookie);

        return "redirect:" + landing;
    }

    private String maskEmail(String email) {
        if (email == null || !email.contains("@")) {
            return email;
        }
        String[] parts = email.split("@");
        String local = parts[0];
        String domain = parts[1];
        if (local.length() <= 2) {
            return email;
        }
        return local.substring(0, 2) + "****@" + domain;
    }
}
