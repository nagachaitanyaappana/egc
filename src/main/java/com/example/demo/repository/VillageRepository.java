package com.example.demo.repository;

import com.example.demo.model.Village;
import com.example.demo.model.Mandal;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.List;

public interface VillageRepository extends JpaRepository<Village, Long> {
    Optional<Village> findByName(String name);
    List<Village> findByMandal(Mandal mandal);
}
