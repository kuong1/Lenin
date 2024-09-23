package com.example.websitebanquanao.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SanPhamResponse {
    private UUID id;
    private Integer idLoai;
    private String ten;
    private Date ngayTao;
    private String anh;
    private String tenLoai;
}
