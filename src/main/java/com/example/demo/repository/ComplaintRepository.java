package com.example.demo.repository;

import com.example.demo.model.Complaint;
import com.example.demo.model.Village;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ComplaintRepository extends JpaRepository<Complaint, Long> {

    @Query("SELECT c FROM Complaint c WHERE c.user.village = :village ORDER BY c.createdAt DESC")
    List<Complaint> findByUserVillage(@Param("village") Village village);

    @Query("SELECT COUNT(c) FROM Complaint c WHERE c.user.village = :village")
    long countByUserVillage(@Param("village") Village village);
}
