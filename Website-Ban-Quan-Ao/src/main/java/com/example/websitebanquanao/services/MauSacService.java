package com.example.websitebanquanao.services;

import com.example.websitebanquanao.entities.MauSac;
import com.example.websitebanquanao.infrastructures.requests.MauSacRequest;
import com.example.websitebanquanao.infrastructures.responses.MauSacResponse;
import com.example.websitebanquanao.repositories.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class MauSacService {
    @Autowired
    private MauSacRepository mauSacRepository;

    // admin

    public List<MauSacResponse> getAll() {
        return mauSacRepository.getAll();
    }

    public Page<MauSacResponse> getPage(int page, int pageSize) {
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        return mauSacRepository.getPage(pageable);
    }

    public void add(MauSacRequest mauSacRequest) {
        MauSac mauSac = new MauSac();
        mauSac.setTen(mauSacRequest.getTen());
        mauSacRepository.save(mauSac);

        System.out.println("MauSacService.add: " + mauSac.getTen());
    }

    public void update(MauSacRequest mauSacRequest, Integer id) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(null);
        if (mauSac != null) {
            mauSac.setTen(mauSacRequest.getTen());
            mauSacRepository.save(mauSac);
            System.out.println("mauSacService.update: " + mauSac.getTen());
        } else {
            System.out.println("mauSacService.update: null");
        }

    }

    public void delete(int id) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(null);
        if (mauSac != null) {
            mauSacRepository.deleteById(id);

            System.out.println("MauSacService.delete: " + id);
        } else {
            System.out.println("MauSacService.delete: null");
        }
    }

    public MauSacResponse getById(Integer id) {
        MauSacResponse mauSacResponse = mauSacRepository.getByIdResponse(id);
        if (mauSacResponse != null) {
            System.out.println("MauSacService.getById: " + mauSacResponse.getTen());
            return mauSacResponse;
        } else {
            System.out.println("MauSacService.getById: null");
            return null;
        }
    }

    public boolean isTenValid(String ten) {
        return ten != null && !ten.trim().isEmpty(); }

    // user
    public List<MauSacResponse> getListMauSacByIdSanPham(UUID idSanPham) {
        return mauSacRepository.getListMauSacByIdSanPham(idSanPham);
    }
}
