package com.example.websitebanquanao.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Nationalized;

import java.sql.Date;
import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "san_pham")
public class SanPham {
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Nationalized
    @Lob
    @Column(name = "ten", nullable = false)
    private String ten;

    @Column(name = "ngay_tao")
    private Date ngayTao;

    @Nationalized
    @Lob
    @Column(name = "anh", nullable = false)
    private String anh;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_loai", nullable = false)
    private Loai idLoai;

    @OneToMany(mappedBy = "idSanPham")
    private Set<SanPhamChiTiet> sanPhamChiTiets = new LinkedHashSet<>();

}