package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.Loai;
import com.example.websitebanquanao.infrastructures.requests.LoaiRequest;
import com.example.websitebanquanao.infrastructures.responses.LoaiResponse;
import com.example.websitebanquanao.repositories.LoaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoaiService {
    @Autowired
    private LoaiRepository loaiRepository;

    public List<LoaiResponse> getAll() {
        return loaiRepository.getAll();
    }

    public Page<LoaiResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return loaiRepository.getPage(pageable);
    }

    public void add(LoaiRequest loaiRequest) {
            Loai loai = new Loai();
            loai.setTen(loaiRequest.getTen());
            loaiRepository.save(loai);

            System.out.println("LoaiService.add: " + loai.getTen());

    }

    public void update(LoaiRequest loaiRequest, Integer id){
        Loai loai = loaiRepository.findById(id).orElse(null);
        if (loai != null){
            loai.setTen(loaiRequest.getTen());
            loaiRepository.save(loai);
            System.out.println("loaiService.update: " + loai.getTen());
        } else {
            System.out.println("loaiService.update: null");
        }
    }

    public void delete(Integer id) {
        Loai loai = loaiRepository.findById(id).orElse(null);
        if (loai != null) {
            loaiRepository.deleteById(id);

            System.out.println("LoaiService.delete: " + id);
        } else {
            System.out.println("LoaiService.delete: null");
        }
    }

    public LoaiResponse getById(Integer id) {
        LoaiResponse loaiResponse = loaiRepository.getByIdResponse(id);
        if (loaiResponse != null) {
            System.out.println("LoaiService.findById: " + loaiResponse.getTen());
            return loaiResponse;
        } else {
            System.out.println("LoaiService.findById: null");
            return null;
        }
    }

    public boolean isTenValid(String ten) {
        return ten != null && !ten.trim().isEmpty(); }
}
