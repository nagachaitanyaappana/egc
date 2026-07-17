package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.repository.ComplaintRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class AdminDashboardController {

    @Autowired
    private ComplaintRepository complaintRepository;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/dashboard")
    public String adminDashboard() {
        List<Complaint> complaints = complaintRepository.findAll();
        // Pass to view
        return "admin-dashboard";
    }
}