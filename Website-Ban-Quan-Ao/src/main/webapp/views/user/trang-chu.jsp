<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="content">
    <style>
        .discount-percentage {
            position: absolute; /* Vị trí tuyệt đối */
            top: 0; /* Đặt ở đỉnh */
            left: 0; /* Đặt ở bên trái */
            background-color: red; /* Màu nền đỏ */
            color: white; /* Màu chữ trắng */
            padding: 5px; /* Khoảng cách nội dung từ viền */
            font-weight: bold; /* In đậm */
        }
    </style>
    <div class="container ">
        <h3 class="fw-bold text-lg-start mt-4">Sản phẩm mới nhất</h3>
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <c:forEach items="${listTrangChu}" var="sanPham">
                <div class="col">
                    <a href="/san-pham/${sanPham.id}/${sanPham.idMauSac}" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="${sanPham.anh}" class="card-img-top" alt="${sanPham.ten}" style="width: 19rem; height: 19rem;">
                            <span class="discount-percentage" id="so-phan-tram-giam_${sanPham.id}"></span>
                            <div class="card-body text-center">
                                <p class="text-uppercase">${sanPham.ten}</p>
                                <p class="fw-bold gia-cu" id="gia-san-pham_${sanPham.id}">${sanPham.gia}</p>
                                <script>
                                    var giaSanPhamElement = document.getElementById("gia-san-pham_${sanPham.id}");
                                    var giaSanPhamText = giaSanPhamElement.innerText;
                                    var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                                    giaSanPhamElement.innerText = formattedGia + " vnđ";
                                </script>
                                <p class="fw-bold gia-moi" id="gia-moi_${sanPham.id}"></p>
                            </div>
                        </div>
                    </a>
                </div>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                    $(document).ready(function () {
                        var idSanPham = '${sanPham.id}';
                        $.ajax({
                            url: "/so-phan-tram-giam/" + idSanPham,
                            method: "GET",
                            success: function (data) {
                                var span = $("#so-phan-tram-giam_" + idSanPham);
                                var giaSpan = $("#gia-san-pham_" + idSanPham);
                                var giaCu = giaSpan.html();

                                if (data != null) {
                                    // nếu tồn tại khuyến mãi thì mới hiển thị thẻ span
                                    if (data > 0) {
                                        span.show();
                                        span.html(data + "% off");
                                    } else {
                                        span.hide();
                                    }
                                    // Tính giá sản phẩm sau khi giảm và hiển thị nó
                                    var giaSanPham = ${sanPham.gia};
                                    var soPhanTramGiam = data;
                                    var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                    giaSauGiam = Math.floor(giaSauGiam);
                                    giaSpan.hide();
                                    if (data > 0) {
                                        giaSpan.after('<p class="fw-bold gia-moi">' + giaSauGiam.toLocaleString('en-US') + ' vnđ</p>');
                                        giaSpan.after('<p class="fw-bold gia-cu " style="text-decoration: line-through;">' + giaCu + '</p>');
                                    } else {
                                        giaSpan.show();
                                    }
                                }
                            },
                            error: function () {
                                // Xử lý lỗi nếu có
                            }
                        });
                    });
                </script>

            </c:forEach>
        </div>
        <h3 class="fw-bold text-lg-start mt-4">Sản phẩm bán chạy nhất</h3>
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <c:forEach items="${listBanChay}" var="sanPham">
                <div class="col">
                    <a href="/san-pham/${sanPham.id}/${sanPham.idMauSac}" class="text-decoration-none text-dark">
                        <div class="card border-0">
                            <img src="${sanPham.anh}" class="card-img-top" alt="${sanPham.ten}"style="width: 19rem; height: 19rem;">
                            <span class="discount-percentage" id="so-phan-tram-giam_2_${sanPham.id}"></span>
                            <div class="card-body text-center">
                                <p class="text-uppercase">${sanPham.ten}</p>
                                <p class="fw-bold gia-cu" id="gia-san-pham_2_${sanPham.id}">${sanPham.gia}</p>
                                <script>
                                    var giaSanPhamElement = document.getElementById("gia-san-pham_2_${sanPham.id}");
                                    var giaSanPhamText = giaSanPhamElement.innerText;
                                    var formattedGia = parseInt(giaSanPhamText.replace(/[^\d]/g, '')).toLocaleString('en-US');
                                    giaSanPhamElement.innerText = formattedGia + " vnđ";
                                </script>
                                <p class="fw-bold gia-moi" id="gia-moi_${sanPham.id}"></p>
                            </div>
                        </div>
                    </a>
                </div>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                    $(document).ready(function () {
                        var idSanPham = '${sanPham.id}';
                        $.ajax({
                            url: "/so-phan-tram-giam/" + idSanPham,
                            method: "GET",
                            success: function (data) {
                                var span = $("#so-phan-tram-giam_2_" + idSanPham);
                                var giaSpan = $("#gia-san-pham_2_" + idSanPham);
                                var giaCu = giaSpan.html();

                                if (data != null) {
                                    // nếu tồn tại khuyến mãi thì mới hiển thị thẻ span
                                    if (data > 0) {
                                        span.show();
                                        span.html(data + "% off");
                                    } else {
                                        span.hide();
                                    }
                                    // Tính giá sản phẩm sau khi giảm và hiển thị nó
                                    var giaSanPham = ${sanPham.gia};
                                    var soPhanTramGiam = data;
                                    var giaSauGiam = giaSanPham - (giaSanPham * soPhanTramGiam / 100);
                                    giaSauGiam = Math.floor(giaSauGiam);
                                    giaSpan.hide();
                                    if (data > 0) {
                                        giaSpan.after('<p class="fw-bold gia-moi">' + giaSauGiam.toLocaleString('en-US') + ' vnđ</p>');
                                        giaSpan.after('<p class="fw-bold gia-cu " style="text-decoration: line-through;">' + giaCu + '</p>');
                                    } else {
                                        giaSpan.show();
                                    }
                                }
                            },
                            error: function () {
                                // Xử lý lỗi nếu có
                            }
                        });
                    });
                </script>

            </c:forEach>
        </div>
    </div>
</section>
<section>
    <div class="row justify-content-center col-2 offset-5 px-1 ">
        <a href="/san-pham"
           class="text-decoration-none text-dark fw-bold text-center py-3 px-5 border border-none rounded-pill">Xem
            Thêm</a>
    </div>
</section>