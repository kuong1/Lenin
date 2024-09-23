package com.example.websitebanquanao.infrastructures.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GiamGiaResponse {
    private UUID id;
    private String ma;
    private Integer soPhanTramGiam;
    private Integer soLuong;
    private LocalDate ngayBatDau;
    private LocalDate ngayKetThuc;
}
