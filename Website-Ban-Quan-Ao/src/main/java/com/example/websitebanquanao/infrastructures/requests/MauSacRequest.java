package com.example.websitebanquanao.infrastructures.requests;

import com.example.websitebanquanao.repositories.MauSacRepository;
import io.micrometer.common.util.StringUtils;
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
public class MauSacRequest {
    @NotBlank(message = "Tên mà không được để trống")
    private String ten;

    public boolean isTenDuplicated(MauSacRepository mauSacRepository) {
        return mauSacRepository.existsByTen(this.ten);
    }

    public boolean validNull() {
        return StringUtils.isEmpty(ten);
    }
}
