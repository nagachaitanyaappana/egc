package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Photo;
import com.example.demo.model.User;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.PhotoRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@PreAuthorize("isAuthenticated()")
public class ComplaintController {

    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping("/complaint")
    public String showComplaintForm(Model model) {
        return "complaint-form";
    }

    @PostMapping("/complaint")
    public String submitComplaint(@RequestParam String complaintContent,
                                  @RequestParam("photos") MultipartFile[] photos,
                                  @AuthenticationPrincipal UserDetails userDetails,
                                  Model model) throws IOException {

        User currentUser = userRepository.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new IllegalStateException("Authenticated user not found"));

        Complaint complaint = new Complaint();
        complaint.setUser(currentUser);
        complaint.setContent(complaintContent);

        List<Photo> savedPhotos = new ArrayList<>();
        for (MultipartFile photo : photos) {
            if (!photo.isEmpty()) {
                String storedPath = fileStorageService.store(photo);
                Photo photoEntity = new Photo(storedPath, complaint);
                savedPhotos.add(photoEntity);
            }
        }
        complaint.setPhotos(savedPhotos);
        complaintRepository.save(complaint);

        model.addAttribute("success", true);
        return "complaint-form";
    }
}
