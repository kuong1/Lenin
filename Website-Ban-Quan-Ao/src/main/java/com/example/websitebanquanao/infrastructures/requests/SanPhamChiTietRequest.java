package com.example.websitebanquanao.infrastructures.requests;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SanPhamChiTietRequest {

    private UUID id;
    private String maSanPham;
    private UUID idSanPham;
    private Integer idMauSac;
    private Integer idKichCo;
    private BigDecimal gia;
    private Integer soLuong;
    private String moTa;
    private Integer trangThai;
    private List<String> duongDan;
}
