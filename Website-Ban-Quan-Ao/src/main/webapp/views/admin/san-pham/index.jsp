<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
    .image-input {
        display: none;
    }

    .image-preview-container {
        position: relative;
        width: 100px;
        height: 100px;
        margin: 10px;
        border: 1px dashed #ccc;
        text-align: center;
        cursor: pointer; /* Sử dụng con trỏ kiểu tay khi di chuột vào */
    }

    .image-preview {
        max-width: 100%;
        max-height: 100%;
        display: none;
    }

    .image-placeholder {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 36px;
        color: #333;
    }

    /* Ẩn label khi đã chọn ảnh */
    .image-input-label.selected {
        display: none;
    }
</style>


<div class="container mt-3">
    <h1 class="text-center">Quản Lý Sản Phẩm</h1>

    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
        Thêm sản phẩm
    </button>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success mt-2">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger mt-2">${errorMessage}</div>
    </c:if>

    <div class="row">
        <div>
            <table class="table table-bordered mt-3 text-center">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Ngày Tạo</th>
                    <th>Ảnh Hiển Thị</th>
                    <th>Loại</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="index" items="${sanPhamPage.content}" var="sp">
                    <tr>
                        <td>${index.index + sanPhamPage.number * sanPhamPage.size + 1}</td>
                        <td>${sp.ten}</td>
                        <td>${sp.ngayTao}</td>
                        <td>
                            <img src="${sp.anh}" alt="" width="100px" height="100px">
                        </td>
                        <td>${sp.tenLoai}</td>
                        <td>
                            <a href="#" class="btn btn-primary update-button"
                               data-bs-toggle="modal" data-bs-target="#exampleModal"
                               data-id="${sp.id}"
                               data-ten="${sp.ten}"
                               data-ngayTao="${sp.ngayTao}"
                               data-anh="${sp.anh}"
                               data-tenLoai="${sp.tenLoai}"
                            >
                                Cập Nhật
                            </a>
<%--                            <a href="/admin/san-pham/delete/${sp.id}" class="btn btn-danger"--%>
<%--                               onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>


    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="sp" method="post" action="/admin/san-pham/store" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="ten" class="form-label">Tên Sản Phẩm</label>
                                    <form:input type="text" path="ten" id="ten" class="form-control"
                                                required="true"/>
                                    <form:errors path="ten" cssClass="text-danger"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label class="form-label">Loại</label>
                                    <form:select class="form-select" path="idLoai" id="idLoai">
                                        <c:forEach items="${listLoai}" var="loai">
                                            <option value="${loai.id}">${loai.ten}</option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>
                        </div>

                        <div class="mt-3 text-center">
                            <label class="form-label">Ảnh sản phẩm</label>
                            <div class="text-center">
                                <label for="imageInput" class="image-preview-container">
                                    <img id="imageDisplay" class="image-preview" src="" alt="Image">
                                    <span class="image-placeholder" id="placeholder1">+</span>
                                </label>
                                <form:input path="anh" type="file" id="imageInput" class="image-input" accept="image/*"
                                       onchange="displayImage()"/>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success mt-3 col-2 offset-5">Lưu</button>
                    </form:form>
                    <script>
                        document.addEventListener('DOMContentLoaded', function() {
                            const form = document.getElementById('edit-form');
                            const tenInput = document.getElementById('ten');
                            const idLoaiSelect = document.getElementById('idLoai');
                            const imageInput = document.getElementById('imageInput');

                            form.addEventListener('submit', function(event) {
                                // Check if the "Tên Sản Phẩm" input is empty
                                if (tenInput.value.trim() === '') {
                                    event.preventDefault();
                                    alert('Vui lòng nhập Tên Sản Phẩm.');
                                    return;
                                }

                                // Check if the "Loại" select is not selected
                                if (idLoaiSelect.value === '') {
                                    event.preventDefault();
                                    alert('Vui lòng chọn Loại.');
                                    return;
                                }

                                // Check if the "Ảnh sản phẩm" input is empty (optional, based on your requirements)
                                if (imageInput.value.trim() === '') {
                                    event.preventDefault();
                                    alert('Vui lòng chọn Ảnh sản phẩm.');
                                    return;
                                }
                            });
                        });
                    </script>

                </div>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${sanPhamPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${sanPhamPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${sanPhamPage.totalPages}">
                        <li class="page-item <c:if test="${sanPhamPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${sanPhamPage.number == sanPhamPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${sanPhamPage.totalPages - 1}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>
</div>


<!-- Bao gồm các tập lệnh Spring form và các tập lệnh khác -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/san-pham/get/" + id,
            type: "GET",
            success: function (data) {
                $("#ten").val(data.ten);
                $("#ngayTao").val(data.ngayTao);
                $("#anh").val(data.anh);
                $("#idLoai").val(data.idLoai);
                $("#imageDisplay").attr("src", data.anh);
                $("#placeholder1").hide();
                $("#imageDisplay").show();


                $("#edit-form").attr("action", "/admin/san-pham/update/" + id);
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
        var updateButtons = document.querySelectorAll(".update-button");
        var clickClose = document.querySelector(".btn-close");

        updateButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                var modalTitle = document.querySelector(".modal-title");

                modalTitle.textContent = "Cập Nhật Sản Phẩm";

            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");

            modalTitle.textContent = "Thêm Sản Phẩm";

            $("#edit-form").trigger("reset");
            // reset input ảnh
            $("#imageDisplay").attr("src", "");
            $("#edit-form").attr("action", "/admin/san-pham/store");

        });
    });

    function displayImage() {
        var input = document.getElementById('imageInput');
        var imageDisplay = document.getElementById('imageDisplay');
        var placeholder = document.getElementById('placeholder1'); // Đã thêm id vào placeholder

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                imageDisplay.src = e.target.result;
                imageDisplay.style.display = 'block';
                placeholder.style.display = 'none';
                // Chuyển đổi ảnh thành base64 và hiển thị nó
                convertToBase64(input.files[0], function (base64Image) {
                    // Lưu base64Image vào một biến hoặc gửi nó điều kiện cần thiết
                });
            };
            console.log(input.files[0]);

            reader.readAsDataURL(input.files[0]);
        } else {
            imageDisplay.src = ''; // Xóa ảnh nếu không có tệp được chọn
            imageDisplay.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    function convertToBase64(file, callback) {
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
            var base64Image = reader.result.split(',')[1];
            callback(base64Image);
        };
        reader.onerror = function (error) {
            console.error('Error reading file: ', error);
        };
    }

</script>
</body>
</html>
