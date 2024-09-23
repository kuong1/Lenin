package com.example.websitebanquanao.repositories;


import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.infrastructures.responses.MauSacResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac, Integer> {
    @Query("select new com.example.websitebanquanao.infrastructures.responses.MauSacResponse(m.id, m.ten) from MauSac m ORDER BY m.ten")
    public List<MauSacResponse> getAll();

    @Query("select new com.example.websitebanquanao.infrastructures.responses.MauSacResponse(m.id, m.ten) from MauSac m ORDER BY m.ten")
    public Page<MauSacResponse> getPage(Pageable pageable);

    @Query("select new com.example.websitebanquanao.infrastructures.responses.MauSacResponse(m.id, m.ten) from MauSac m where m.id = :id")
    public MauSacResponse getByIdResponse(@Param("id") Integer id);

    @Query("SELECT DISTINCT new com.example.websitebanquanao.infrastructures.responses.MauSacResponse(ms.id, ms.ten) FROM MauSac ms INNER JOIN ms.sanPhamChiTiets spct INNER JOIN spct.idSanPham sp WHERE sp.id = :idSanPham AND spct.soLuong > 0 AND spct.trangThai = 1")
    public List<MauSacResponse> getListMauSacByIdSanPham(@Param("idSanPham") UUID idSanPham);

    boolean existsByTen(String ten);
}
