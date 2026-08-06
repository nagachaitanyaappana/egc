package com.example.demo.repository;

import com.example.demo.model.Complaint;
import com.example.demo.model.Village;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.LocalDateTime;
import java.util.List;

public interface ComplaintRepository extends JpaRepository<Complaint, Long>, JpaSpecificationExecutor<Complaint> {

    @Query("SELECT c FROM Complaint c WHERE c.user.village = :village ORDER BY c.createdAt DESC")
    List<Complaint> findByUserVillage(@Param("village") Village village);

    @Query("SELECT COUNT(c) FROM Complaint c WHERE c.user.village = :village")
    long countByUserVillage(@Param("village") Village village);

    @Query("SELECT COUNT(c) FROM Complaint c")
    long countAll();

    List<Complaint> findByIsDemoTrue();
    boolean existsByIsDemo(boolean isDemo);

    long countByTypeIn(List<String> types);

    long countByCreatedAtAfter(LocalDateTime createdAt);

    long countByPriority(String priority);

    List<Complaint> findByPriority(String priority);

    List<Complaint> findByCreatedAtAfter(LocalDateTime createdAt);

    List<Complaint> findByTypeIn(List<String> types);

    List<Complaint> findByUser_Village_Id(Long villageId);
}
