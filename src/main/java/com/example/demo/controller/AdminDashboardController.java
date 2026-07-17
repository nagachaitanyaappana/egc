package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.repository.ComplaintRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class AdminDashboardController {

    @Autowired
    private ComplaintRepository complaintRepository;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        List<Complaint> complaints = complaintRepository.findAll();
        model.addAttribute("complaints", complaints);
        return "admin-dashboard";
    }
}
