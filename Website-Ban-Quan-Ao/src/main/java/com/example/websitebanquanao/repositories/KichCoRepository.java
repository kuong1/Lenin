package com.example.websitebanquanao.repositories;

import com.example.websitebanquanao.entities.KichCo;
import com.example.websitebanquanao.infrastructures.responses.KichCoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface KichCoRepository extends JpaRepository<KichCo, Integer> {
    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.KichCoResponse(k.id, k.ten) FROM KichCo k ORDER BY k.ten")
    public List<KichCoResponse> getAll();

    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.KichCoResponse(k.id, k.ten) FROM KichCo k ORDER BY k.ten")
    public Page<KichCoResponse> getPage(Pageable pageable);

    @Query("SELECT new com.example.websitebanquanao.infrastructures.responses.KichCoResponse(k.id, k.ten) FROM KichCo k WHERE k.id = :id")
    public KichCoResponse getByIdResponse(@Param("id") Integer id);

    @Query("SELECT DISTINCT new com.example.websitebanquanao.infrastructures.responses.KichCoResponse(kc.id, kc.ten) FROM KichCo kc INNER JOIN kc.sanPhamChiTiets spct INNER JOIN spct.idSanPham sp INNER JOIN spct.idMauSac ms WHERE sp.id = :idSanPham AND ms.id = :idMauSac AND spct.soLuong > 0 AND spct.trangThai = 1 ORDER BY kc.ten")
    public List<KichCoResponse> getListKichCoByIdSanPhamAndMauSac(@Param("idSanPham") UUID idSanPham, @Param("idMauSac") Integer idMauSac);

    boolean existsByTen(String ten);
}
