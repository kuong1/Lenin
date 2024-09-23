package com.example.websitebanquanao.infrastructures.requests;

import com.example.websitebanquanao.repositories.KichCoRepository;
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
public class KichCoRequest {

    @NotBlank(message = "Tên không được để trống")
    private String ten;

    public boolean isTenDuplicated(KichCoRepository kichCoRepository) {
        return kichCoRepository.existsByTen(this.ten);
    }
}
