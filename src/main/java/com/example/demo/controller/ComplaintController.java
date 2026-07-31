package com.example.demo.controller;

import com.example.demo.model.Complaint;
import com.example.demo.model.Photo;
import com.example.demo.model.User;
import com.example.demo.repository.ComplaintRepository;
import com.example.demo.repository.PhotoRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    @GetMapping("/complaint")
    public String showComplaintForm(Model model) {
        return "complaint-form";
    }

    @PostMapping("/complaint")
    public String submitComplaint(@RequestParam String complaintContent,
                                  @RequestParam("photos") MultipartFile[] photos,
                                  @RequestParam(value = "createdAt", required = false) String createdAtStr,
                                  @AuthenticationPrincipal UserDetails userDetails,
                                  Model model) throws IOException {

        User currentUser = userRepository.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new IllegalStateException("Authenticated user not found"));

        Complaint complaint = new Complaint();
        complaint.setUser(currentUser);
        complaint.setContent(complaintContent);

        if (createdAtStr != null && !createdAtStr.isBlank()) {
            try {
                LocalDateTime parsed = LocalDateTime.parse(createdAtStr, DateTimeFormatter.ISO_DATE_TIME);
                complaint.setCreatedAt(parsed);
            } catch (Exception e) {
                // ignore invalid format and use default
            }
        }

        List<Photo> savedPhotos = new ArrayList<>();
        for (MultipartFile photo : photos) {
            if (!photo.isEmpty()) {
                Photo photoEntity = new Photo(
                        photo.getBytes(),
                        photo.getContentType(),
                        complaint
                );
                savedPhotos.add(photoEntity);
            }
        }
        complaint.setPhotos(savedPhotos);
        complaintRepository.save(complaint);

        model.addAttribute("success", true);
        return "complaint-form";
    }

    @GetMapping("/photos/{id}")
    public ResponseEntity<byte[]> servePhoto(@PathVariable Long id) {
        Photo photo = photoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Photo not found: " + id));

        if (photo.getData() == null || photo.getData().length == 0) {
            return ResponseEntity.notFound().build();
        }

        MediaType mediaType = MediaType.IMAGE_JPEG;
        if (photo.getContentType() != null) {
            try {
                mediaType = MediaType.parseMediaType(photo.getContentType());
            } catch (Exception e) {
                mediaType = MediaType.IMAGE_JPEG;
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(mediaType);
        headers.setContentLength(photo.getData().length);

        return new ResponseEntity<>(photo.getData(), headers, HttpStatus.OK);
    }
}
