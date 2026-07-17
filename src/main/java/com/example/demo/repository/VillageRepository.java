package com.example.demo.repository;

import com.example.demo.model.Village;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface VillageRepository extends JpaRepository<Village, Long> {
    Optional<Village> findByName(String name);
}
