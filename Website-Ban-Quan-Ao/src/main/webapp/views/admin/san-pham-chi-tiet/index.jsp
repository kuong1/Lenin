<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<script>
    function filterByStatus() {
        var selectedStatus = document.getElementById("statusSelect").value;
        if (selectedStatus === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter?status=" + selectedStatus;
        }
    }

    function filterByColor() {
        var selectedColor = document.getElementById("colorSelect").value;
        if (selectedColor === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter-mau-sac?tenMauSac=" + selectedColor;
        }
    }
    function filterBySize() {
        var selectedSize = document.getElementById("sizeSelect").value;
        if (selectedSize === "") {
            window.location.href = "/admin/san-pham-chi-tiet/index";
        } else {
            window.location.href = "/admin/san-pham-chi-tiet/filter-kich-co?tenKichCo=" + selectedSize;
        }
    }
</script>

<div>
    <h1 class="text-center mt-3">Quản Lý Sản Phẩm Chi Tiết</h1>
    <div class="row col-2 ms-1 mt-3">
        <a href="/admin/san-pham-chi-tiet/create" class="btn btn-success">Thêm sản phẩm chi tiết</a>
    </div>

    <div class="row ">
        <%--    lọc đang bán-ngừng bán--%>
        <div class="col-2 ms-1 mt-3">
            <select id="statusSelect" class="form-select" aria-label="Default select example"
                    onchange="filterByStatus()">
                <option value="" ${param.status == null ? 'selected' : ''}>Tất cả</option>
                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>
            </select>
        </div>
        <%-- lọc theo màu sắc--%>
        <div class="col-2 ms-1 mt-3">
            <select id="colorSelect" class="form-select" aria-label="Default select example"
                    onchange="filterByColor()">
                <option value="" ${param.ten == null ? 'selected' : ''}>Tất cả màu sắc</option>
                <c:forEach items="${listMauSac}" var="color">
                    <option value="${color.ten}" ${param.tenMauSac == color.ten ? 'selected' : ''}>
                            ${color.ten}
                    </option>
                </c:forEach>
            </select>
        </div>
            <%-- Lọc theo kích cỡ--%>
        <div class="col-2 ms-1 mt-3">
            <select id="sizeSelect" class="form-select" aria-label="Default select example"
                    onchange="filterBySize()">
                <option value="" ${param.ten == null ? 'selected' : ''}>Tất cả kích cỡ</option>
                <c:forEach items="${listKichCo}" var="size">
                    <option value="${size.ten}" ${param.tenKichCo == size.ten ? 'selected' : ''}>
                        ${size.ten}
                    </option>
                </c:forEach>
            </select>
</div>
        <div class="ms-1">
            <table class="table table-bordered text-center mt-3">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Màu Sắc</th>
                    <th>Kích cỡ</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Mô tả</th>
                    <th>Trạng thái</th>
                    <th colspan="2">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="sanPhamChiTiet" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${sanPhamChiTiet.maSanPham}</td>
                        <td>${sanPhamChiTiet.tenSanPham}</td>
                        <td>${sanPhamChiTiet.tenMauSac}</td>
                        <td>${sanPhamChiTiet.tenKichCo}</td>
                        <td>${sanPhamChiTiet.gia}</td>
                        <td>${sanPhamChiTiet.soLuong}</td>
                        <td>${sanPhamChiTiet.moTa}</td>
                        <td>
                            <c:if test="${sanPhamChiTiet.trangThai == 1}">
                                <span class="badge bg-success">Đang bán</span>
                            </c:if>
                            <c:if test="${sanPhamChiTiet.trangThai == 0}">
                                <span class="badge bg-danger">Ngừng bán</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="/admin/san-pham-chi-tiet/edit/${sanPhamChiTiet.id}"
                               class="btn btn-warning">Sửa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
