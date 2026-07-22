package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Mandal;
import com.example.demo.model.Village;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.MandalRepository;
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
    private MandalRepository mandalRepository;

    @Autowired
    private VillageRepository villageRepository;

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private UserRepository userRepository;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        List<Mandal> mandals = mandalRepository.findAll();
        model.addAttribute("mandals", mandals);
        return "admin-dashboard";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/mandal/{id}")
    public String mandalVillages(@PathVariable Long id, Model model) {
        Mandal mandal = mandalRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Mandal not found: " + id));

        List<Village> villages = villageRepository.findByMandal(mandal);

        model.addAttribute("mandal", mandal);
        model.addAttribute("villages", villages);
        return "mandal-villages";
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
        if (village.getMandal() != null) {
            model.addAttribute("mandalId", village.getMandal().getId());
        }
        return "village-report";
    }
}
