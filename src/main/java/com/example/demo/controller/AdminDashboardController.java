package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Village;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.VillageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class AdminDashboardController {

    @Autowired
    private VillageRepository villageRepository;

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private UserRepository userRepository;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        List<Village> villages = villageRepository.findAll().stream()
                .filter(v -> complaintRepository.countByUserVillage(v) > 0)
                .toList();
        model.addAttribute("villages", villages);
        return "admin-dashboard";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/village/{id}")
    public String villageReport(@PathVariable Long id, Model model) {
        Village village = villageRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Village not found: " + id));

        List<Complaint> complaints = complaintRepository.findByUserVillage(village);
        long userCount = userRepository.countByVillage(village);

        model.addAttribute("village", village);
        model.addAttribute("complaints", complaints);
        model.addAttribute("userCount", userCount);
        return "village-report";
    }
}
