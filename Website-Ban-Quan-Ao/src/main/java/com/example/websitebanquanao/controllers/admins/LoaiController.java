package com.example.websitebanquanao.controllers.admins;

import com.example.websitebanquanao.infrastructures.requests.LoaiRequest;
import com.example.websitebanquanao.infrastructures.responses.LoaiResponse;
import com.example.websitebanquanao.repositories.LoaiRepository;
import com.example.websitebanquanao.services.LoaiService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/loai")
public class LoaiController {
    @Autowired
    private LoaiService loaiService;

    @Autowired
    private LoaiRequest loaiRequest;

    private static final String redirect = "redirect:/admin/loai/index";
    @Autowired
    private LoaiRepository loaiRepository;

    @GetMapping("index")
    public String index(@RequestParam(name = "page", defaultValue = "1") int page, Model model, @ModelAttribute("successMessage") String successMessage, @ModelAttribute("errorMessage") String errorMessage) {
        Page<LoaiResponse> loaiPage = loaiService.getPage(page, 5);
        model.addAttribute("loaiPage", loaiPage);
        model.addAttribute("l", loaiRequest);
        model.addAttribute("successMessage", successMessage);
        model.addAttribute("errorMessage", errorMessage);
        model.addAttribute("view", "/views/admin/loai/index.jsp");
        return "admin/layout";
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        loaiService.delete(id);
        // Lưu thông báo xoá thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Xoá loại thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("store")
    public String store(@Valid @ModelAttribute("l") LoaiRequest loaiRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (!loaiService.isTenValid(loaiRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/loai/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }

        if (loaiRepository.existsByTen(loaiRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên loại đã tồn tại");
            return redirect;
        }

        loaiService.add(loaiRequest);
        // Lưu thông báo thêm thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Thêm loại thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable("id") Integer id, @Valid @ModelAttribute("l") LoaiRequest loaiRequest, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (!loaiService.isTenValid(loaiRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên toàn khoảng trắng không hợp lệ");
            return redirect;
        }

        if (result.hasErrors()) {
            model.addAttribute("view", "/views/admin/loai/index.jsp");
            return "admin/layout"; // Trả về trang index nếu có lỗi
        }

        if (loaiRepository.existsByTen(loaiRequest.getTen())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cập nhật Loại thất bại");
            return redirect;
        }

        loaiService.update(loaiRequest, id);
        // Lưu thông báo cập nhật thành công vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật loại thành công");
        return redirect; // Sử dụng redirect để chuyển hướng đến trang danh sách
    }

    @GetMapping("get/{id}")
    @ResponseBody
    public ResponseEntity<LoaiResponse> getLoai(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(loaiService.getById(id));
    }
}
