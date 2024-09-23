package com.example.websitebanquanao.services;

import com.example.websitebanquanao.configs.QRCodeGenerator;
import com.example.websitebanquanao.entities.*;
import com.example.websitebanquanao.infrastructures.requests.SanPhamChiTietRequest;
import com.example.websitebanquanao.infrastructures.responses.BanHangTaiQuayResponse;
import com.example.websitebanquanao.infrastructures.responses.NhanVienResponse;
import com.example.websitebanquanao.infrastructures.responses.SanPhamChiTietResponse;
import com.example.websitebanquanao.repositories.SanPhamChiTietRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Service
public class SanPhamChiTietService {
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @Autowired
    private AnhSanPhamService anhSanPhamService;
    @Autowired
    private QRCodeGenerator qrCodeGenerator;

    // admin


    public List<SanPhamChiTietResponse> getAll() {
        return sanPhamChiTietRepository.getAll();
    }

    public List<BanHangTaiQuayResponse> findAllCtsp() {
        return sanPhamChiTietRepository.findAllCtsp();
    }

    // mã sp tự tăng :
    public String maSPCount() {
        String code = "";
        List<SanPhamChiTiet> list = sanPhamChiTietRepository.findAll();
        if (list.isEmpty()) {
            code = "SP0001";
        } else {
            int max = 0;
            for (SanPhamChiTiet sp : list) {
                String ma = sp.getMaSanPham();
                if (ma.length() >= 4) {
                    int so = Integer.parseInt(ma.substring(3));
                    if (so > max) {
                        max = so;
                    }
                }
            }
            max++;
            if (max < 10) {
                code = "SP000" + max;
            } else if (max < 100) {
                code = "SP00" + max;
            } else if (max < 1000) {
                code = "SP0" + max;
            } else {
                code = "SP" + max;
            }
        }
        return code;
    }

    public void add(SanPhamChiTietRequest sanPhamChiTietRequest) {
        SanPhamChiTiet sanPhamChiTiet = new SanPhamChiTiet();
        sanPhamChiTiet.setMaSanPham(maSPCount());
        sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
        sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
        sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
        sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

        SanPham sanPham = new SanPham();
        sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

        MauSac mauSac = new MauSac();
        mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

        KichCo kichCo = new KichCo();
        kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

        sanPhamChiTiet.setIdSanPham(sanPham);
        sanPhamChiTiet.setIdMauSac(mauSac);
        sanPhamChiTiet.setIdKichCo(kichCo);

        SanPhamChiTiet sanPhamChiTietSaved = sanPhamChiTietRepository.save(sanPhamChiTiet);
        String qrCodeData = String.valueOf(sanPhamChiTietSaved.getId());
        String filePath = "src/main/java/com/example/websitebanquanao/images/" + sanPhamChiTietSaved.getMaSanPham() + ".png";
        qrCodeGenerator.generateQRCode(qrCodeData, filePath);
        anhSanPhamService.add(sanPhamChiTietSaved, sanPhamChiTietRequest.getDuongDan());

        System.out.println("SanPhamChiTietService.add: " + sanPhamChiTietSaved.getId());
        System.out.println("file đường dẫn: " + filePath);
    }

    public void update(SanPhamChiTietRequest sanPhamChiTietRequest, UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTiet.setGia(sanPhamChiTietRequest.getGia());
            sanPhamChiTiet.setSoLuong(sanPhamChiTietRequest.getSoLuong());
            sanPhamChiTiet.setMoTa(sanPhamChiTietRequest.getMoTa());
            sanPhamChiTiet.setTrangThai(sanPhamChiTietRequest.getTrangThai());

            SanPham sanPham = new SanPham();
            sanPham.setId(sanPhamChiTietRequest.getIdSanPham());

            MauSac mauSac = new MauSac();
            mauSac.setId(sanPhamChiTietRequest.getIdMauSac());

            KichCo kichCo = new KichCo();
            kichCo.setId(sanPhamChiTietRequest.getIdKichCo());

            sanPhamChiTiet.setIdSanPham(sanPham);
            sanPhamChiTiet.setIdMauSac(mauSac);
            sanPhamChiTiet.setIdKichCo(kichCo);

            sanPhamChiTietRepository.save(sanPhamChiTiet);
            System.out.println("SanPhamChiTietService.update: " + sanPhamChiTiet.getId());
        }
    }

    public void delete(UUID id) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet != null) {
            sanPhamChiTietRepository.deleteById(id);
            System.out.println("SanPhamChiTietService.delete: " + id);
        }
    }

    public SanPhamChiTiet findById(UUID idSanPhamChiTiet) {
        if (sanPhamChiTietRepository.findById(idSanPhamChiTiet).isPresent()) {
            return sanPhamChiTietRepository.findById(idSanPhamChiTiet).get();
        } else {
            return null;
        }
    }

    public void updateSoLuong(SanPhamChiTiet sanPhamChiTiet) {
        sanPhamChiTietRepository.save(sanPhamChiTiet);
    }

    @Transactional
    public void updateSoLuongAfterDelete(UUID idSanPhamChiTiet, int currentSoLuong) {
        // Gọi phương thức tương ứng từ repository để thực hiện việc cập nhật số lượng
        sanPhamChiTietRepository.updateSoLuongAfterDelete(idSanPhamChiTiet, currentSoLuong);
    }

    public List<SanPhamChiTiet> findByIdSanPham(UUID idSanPham) {
        return sanPhamChiTietRepository.findSanPhamChiTietByIdSanPham(idSanPham);
    }

    public List<SanPhamChiTietResponse> getByStatus(Integer trangThai) {
        return sanPhamChiTietRepository.getByStatus(trangThai);
    }

    public List<SanPhamChiTietResponse> getByTenMauSac(String tenMauSac) {
        return sanPhamChiTietRepository.getByTenMauSac(tenMauSac);
    }

    public List<SanPhamChiTietResponse> getByTenKichCo(String tenKichCo) {
        return sanPhamChiTietRepository.getByTenKichCo(tenKichCo);
    }

    // user
    public SanPhamChiTiet getByIdSanPhamAndIdMauSacAndIdKichCo(UUID idSanPham, Integer idMauSac, Integer idKichCo) {
        System.out.println("SanPhamChiTietService.getByIdSanPhamAndIdMauSacAndIdKichCo: " + idSanPham + " " + idMauSac + " " + idKichCo);
        return sanPhamChiTietRepository.getByIdSanPhamAndIdMauSacAndIdKichCo(idSanPham, idMauSac, idKichCo);
    }

    @Transactional
    public void updateSoLuongByIdSanPhamChiTiet(UUID idSanPhamChiTiet, int currentSoLuong) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(idSanPhamChiTiet).orElse(null);

        int soLuong = sanPhamChiTiet.getSoLuong() - currentSoLuong;

        sanPhamChiTietRepository.updateSoLuongAfterDelete(idSanPhamChiTiet, soLuong);
        System.out.println("SanPhamChiTietService.updateSoLuongByIdSanPhamChiTiet: " + idSanPhamChiTiet + " " + soLuong);
    }

    public List<BanHangTaiQuayResponse> filterProducts(String size, String color, String searchTerm) {
        // Xử lý yêu cầu lọc và trả về danh sách sản phẩm phù hợp
        List<BanHangTaiQuayResponse> filteredProducts = sanPhamChiTietRepository.filterProducts(size, color, searchTerm);
        return filteredProducts;
    }
    @Transactional
    public void xuLyTraHangVaoKho(UUID idSanPhamChiTiet, int soLuongTraHang) {
        // Lấy số lượng hiện tại trong kho
        Integer soLuongHienTai = sanPhamChiTietRepository.getSoLuongSanPhamChiTietByIdSanPham(idSanPhamChiTiet);

        // Cập nhật số lượng trong kho (cộng thêm số lượng trả hàng)
        int soLuongDaCapNhat = soLuongHienTai + soLuongTraHang;
        sanPhamChiTietRepository.updateSoLuongAfterDelete(idSanPhamChiTiet, soLuongDaCapNhat);
    }

    public Integer getSoLuongSanPhamChiTietByIdSanPham(UUID idSanPham) {
        return sanPhamChiTietRepository.getSoLuongSanPhamChiTietByIdSanPham(idSanPham);
    }

    public SanPhamChiTiet findByMaSanPham(String maSanPham) {
        return sanPhamChiTietRepository.findByMaSanPham(maSanPham);
    }

    public Integer getSoLuongSanPham(UUID idSanPham, Integer idMauSac, Integer idKichCo) {
        return sanPhamChiTietRepository.getSoLuongSanPham(idSanPham, idMauSac, idKichCo);
    }
}
