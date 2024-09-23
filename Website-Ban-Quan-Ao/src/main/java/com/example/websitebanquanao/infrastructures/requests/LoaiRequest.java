package com.example.websitebanquanao.infrastructures.requests;

import com.example.websitebanquanao.repositories.KichCoRepository;
import com.example.websitebanquanao.repositories.LoaiRepository;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Component
public class LoaiRequest {
    @NotBlank(message = "Loại không được để trống")
    private String ten;

    public boolean isTenDuplicated(LoaiRepository loaiRepository) {
        return loaiRepository.existsByTen(this.ten);
    }
}
