package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Photo;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.PhotoRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

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
        // Populate any attributes if needed
        return "complaint-form";
    }

    @PostMapping("/complaint")
    public String submitComplaint(@RequestParam String complaintContent,
                                  @RequestParam("photos") MultipartFile[] photos,
                                  @RequestParam String villageName,
                                  @RequestParam String role,
                                  Model model) throws IOException {

        // Get current authenticated user (village user) from security context
        // For simplicity retrieving by username "currentUser" placeholder
        User currentUser = userRepository.findByUsername("currentUser").orElseGet(() -> 
            userRepository.findAll().stream().findFirst().orElse(null));

        if (currentUser == null) {
            // fallback - should not happen in real usage
            throw new IllegalStateException("Authenticated user not found");
        }

        String currentVillage = villageName != null ? villageName : currentUser.getVillageName();
        String currentRole = role != null ? role : currentUser.getRole();

        // Create complaint
        Complaint complaint = new Complaint();
        complaint.setUser(currentUser);
        complaint.setContent(complaintContent);
        complaintRepository.save(complaint);

        // Store photos
        List<Photo> savedPhotos = new ArrayList<>();
        for (MultipartFile photo : photos) {
            if (!photo.isEmpty()) {
                String storedPath = fileStorageService.store(photo);
                Photo photoEntity = new Photo();
                photoEntity.setFilePath(storedPath);
                photoEntity.setComplaint(complaint);
                Photo saved = photoRepository.save(photoEntity);
                savedPhotos.add(saved);
            }
        }

        // Attach photos to complaint (optional for later retrieval)
        complaint.setPhotos(savedPhotos);
        complaintRepository.save(complaint); // save again to update photos list

        // Redirect to success page or same page
        return "redirect:/complaint?success";
    }
}