package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.Loai;
import com.example.websitebanquanao.infrastructures.responses.LoaiResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoaiRepository extends JpaRepository<Loai, Integer> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.LoaiResponse(l.id, l.ten) FROM Loai l ORDER BY l.ten")
    public List<LoaiResponse> getAll();

    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.LoaiResponse(l.id, l.ten) FROM Loai l ORDER BY l.ten")
    public Page<LoaiResponse> getPage(Pageable pageable);

    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.LoaiResponse(l.id, l.ten) FROM Loai l WHERE l.id = :id")
    public LoaiResponse getByIdResponse(@Param("id") Integer id);

    boolean existsByTen(String ten);
}
