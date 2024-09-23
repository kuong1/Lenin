package com.example.websitebanquanao.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SanPhamChiTietResponse {
    private UUID id;
    private String maSanPham;
    private String tenSanPham;
    private String tenMauSac;
    private String tenKichCo;
    private BigDecimal gia;
    private Integer soLuong;
    private String moTa;
    private Integer trangThai;
}
