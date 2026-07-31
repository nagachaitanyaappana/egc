package com.example.demo.repository;

import com.example.demo.model.Mandal;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MandalRepository extends JpaRepository<Mandal, Long> {
    Optional<Mandal> findByName(String name);
}
