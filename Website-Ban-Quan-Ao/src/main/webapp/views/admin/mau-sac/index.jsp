<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-3">
    <h1 class="text-center">Quản Lý Màu Sắc</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <div class="row mt-3">
        <div class="col-9">
            <table class="table table-bordered mt-3 text-center">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên Màu</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach varStatus="index" items="${mauSacPage.content}" var="ms">
                    <tr>
                        <td>${index.index + mauSacPage.number * mauSacPage.size + 1}</td>
                        <td>${ms.ten}</td>
                        <td>
                            <a href="#" class="btn btn-primary update-button"
                               data-bs-toggle="modal" data-bs-target="#exampleModal"
                               data-id="${ms.id}" data-ten="${ms.ten}">
                                Cập Nhật
                            </a>
<%--                            <a href="/admin/mau-sac/delete/${ms.id}" class="btn btn-danger"--%>
<%--                               onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-3 mt-4">
            <form:form id="edit-form" modelAttribute="ms" method="post" action="/admin/mau-sac/store">
                <div class="form-group text-center">
                    <label for="ten" class="form-label">Tên Màu</label>
                    <form:input type="text" path="ten" id="ten" class="form-control"/>
                    <button type="submit" class="btn btn-success mt-3">Lưu</button>
                </div>
            </form:form>
        </div>
    </div>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${mauSacPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${mauSacPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${mauSacPage.totalPages}">
                        <li class="page-item <c:if test="${mauSacPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${mauSacPage.number == mauSacPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${mauSacPage.totalPages - 1}">Last</a>
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
            url: "/admin/mau-sac/get/" + id,
            type: "GET",
            success: function (data) {
                $("#ten").val(data.ten);

                $("#edit-form").attr("action", "/admin/mau-sac/update/" + id);
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

                modalTitle.textContent = "Cập Nhật Màu Sắc";

            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");

            modalTitle.textContent = "Thêm Màu Sắc";

            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/mau-sac/store");

        });
    });
    $(document).ready(function () {
        hideErrorMessage();
        hideErrorMessage2();
    });

    function hideErrorMessage() {
        // Sử dụng jQuery để ẩn thông báo sau 5 giây
        setTimeout(function () {
            $('.alert-danger').fadeOut('slow');
        }, 1000);
    }

    function hideErrorMessage2() {
        // Sử dụng jQuery để ẩn thông báo sau 5 giây
        setTimeout(function () {
            $('.alert-success').fadeOut('slow');
        }, 1000);
    }
</script>
</body>
</html>
