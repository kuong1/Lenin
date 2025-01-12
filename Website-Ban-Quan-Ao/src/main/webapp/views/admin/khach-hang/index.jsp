<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container mt-3">
    <h1 class="text-center">Quản Lý Khách Hàng</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <div class="row mt-3">
        <div class="col-6">
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Thêm Khách Hàng
            </button>
        </div>
    </div>

    <table class="table table-bordered mt-3 text-center">
        <thead>
        <tr>
            <th>STT</th>
            <th>Họ Tên</th>
            <th>Email</th>
            <th>Số Điện Thoại</th>
            <th>Địa Chỉ</th>
            <th>Xã/Phường</th>
            <th>Quận/Huyện</th>
            <th>Tỉnh/Thành Phố</th>
            <th>Thao Tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach varStatus="index" items="${khachHangPage.content}" var="kh">
            <tr>
                <td>${index.index + khachHangPage.number * khachHangPage.size + 1}</td>
                <td>${kh.hoVaTen}</td>
                <td>${kh.email}</td>
                <td>${kh.soDienThoai}</td>
                <td>${kh.diaChi}</td>
                <td>${kh.xaPhuong}</td>
                <td>${kh.quanHuyen}</td>
                <td>${kh.tinhThanhPho}</td>

                <td>
<%--                    <a href="/admin/khach-hang/delete/${kh.id}" class="btn btn-danger"--%>
<%--                       onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>--%>
                    <a href="#" class="btn btn-primary update-button"
                       data-bs-toggle="modal" data-bs-target="#exampleModal"
                       data-id="${kh.id}" data-hoVaTen="${kh.hoVaTen}" data-soDienThoai="${kh.soDienThoai}"
                       data-email="${kh.email}" data-diaChi="${kh.diaChi}" data-xaPhuong="${kh.xaPhuong}"
                       data-quanHuyen="${kh.quanHuyen}" data-tinhThanhPho="${kh.tinhThanhPho}">
                        Cập Nhật
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Modal Thêm và Cập Nhật -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
         data-bs-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Thêm Khách Hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form:form id="edit-form" modelAttribute="kh" method="post" action="/admin/khach-hang/store">
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="hoVaTen" class="form-label">Họ và tên</label>
                                    <form:input type="text" path="hoVaTen" id="hoVaTen" class="form-control"/>
<%--                                                required="true"/>--%>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="soDienThoai" class="form-label">Số điện thoại</label>
                                    <form:input type="tel" path="soDienThoai" id="soDienThoai" class="form-control"/>
<%--                                                required="true"/>--%>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <form:input type="email" path="email" id="email" class="form-control"/>
<%--                                                required="true"/>--%>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Tỉnh/Thành phố</label>
                                    <select id="provinceSelect" class="form-select">
                                        <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                                    </select>
                                    <form:input type="hidden" path="tinhThanhPho" id="provinceName" class="form-control" />
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="quanHuyen" class="form-label">Quận/Huyện</label>
                                    <select id="districtSelect" class="form-select">
                                        <option value="" disabled selected>Chọn quận/huyện</option>
                                    </select>
                                    <form:input type="hidden" path="quanHuyen" id="districtName" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="xaPhuong" class="form-label">Xã/Phường</label>
                                    <select id="wardSelect" class="form-select">
                                        <option value="" disabled selected>Chọn phường/xã</option>
                                    </select>
                                    <form:input type="hidden" path="xaPhuong" id="wardName" class="form-control"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="diaChi" class="form-label">Địa chỉ</label>
                                    <form:input type="text" path="diaChi" id="diaChi" class="form-control"/>
<%--                                                required="true"/>--%>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <div class="form-group">
                                    <label for="matKhau" class="form-label">Mật khẩu</label>
                                    <form:input type="password" path="matKhau" id="matKhau" class="form-control"/>
<%--                                                required="true"/>--%>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success mt-3">Lưu</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Biến kiểm tra trạng thái đã chọn
            var isDistrictSelected = false;
            var isWardSelected = false;
            var isServiceSelected = false;
            // Gọi API để lấy dữ liệu tỉnh/thành phố
            $.ajax({
                url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province',
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                },
                success: function (data) {
                    if (data.code === 200) {
                        const select = document.getElementById('provinceSelect');
                        const input = document.getElementById('provinceName'); // Get the input element

                        data.data.forEach(province => {
                            const option = document.createElement('option');
                            option.value = province.ProvinceID;
                            option.text = province.ProvinceName;
                            select.appendChild(option);
                        });

                        // Set province name in the input field when a province is selected
                        $('#provinceSelect').change(function () {
                            const selectedProvinceName = $('#provinceSelect option:selected').text();
                            input.value = selectedProvinceName; // Set the value of the input field
                        });
                    }
                },
                error: function (error) {
                    console.error(error);
                }
            });

            // Gọi API để lấy dữ liệu quận/huyện khi thay đổi tỉnh/thành phố
            $('#provinceSelect').change(function () {
                isDistrictSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố
                isWardSelected = false; // Đặt lại trạng thái khi thay đổi tỉnh/thành phố

                const provinceID = $(this).val();
                $.ajax({
                    url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district',
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                    },
                    data: {
                        province_id: provinceID
                    },
                    success: function (data) {
                        if (data.code === 200) {
                            const select = document.getElementById('districtSelect');
                            const input = document.getElementById('districtName');
                            select.innerHTML = '';
                            data.data.forEach(district => {
                                const option = document.createElement('option');
                                option.value = district.DistrictID;
                                option.text = district.DistrictName;
                                select.appendChild(option);
                            });
                            $('#districtSelect').change(function () {
                                const selectedDistrictName = $('#districtSelect option:selected').text();
                                input.value = selectedDistrictName; // Set the value of the input field
                            });
                        }
                    },
                    error: function (error) {
                        console.error(error);
                    }
                });
            });

            // Gọi API để lấy dữ liệu phường/xã khi thay đổi quận/huyện
            $('#districtSelect').change(function () {
                isDistrictSelected = true; // Đánh dấu trạng thái khi đã chọn quận/huyện
                isWardSelected = false; // Đặt lại trạng thái khi thay đổi quận/huyện

                const districtID = $(this).val();
                $.ajax({
                    url: 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtID,
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        'Token': 'a76df0d2-77a1-11ee-b1d4-92b443b7a897'
                    },
                    data: {
                        district_id: districtID
                    },
                    success: function (data) {
                        if (data.code === 200) {
                            const select = document.getElementById('wardSelect');
                            const input = document.getElementById('wardName');
                            select.innerHTML = '';
                            data.data.forEach(ward => {
                                const option = document.createElement('option');
                                option.value = ward.WardCode;
                                option.text = ward.WardName;
                                select.appendChild(option);
                            })
                            $('#wardSelect').change(function () {
                                const selectedWardName = $('#wardSelect option:selected').text();
                                input.value = selectedWardName; // Set the value of the input field
                            });
                        }
                    },
                    error: function (error) {
                        console.error(error);
                    }
                });
            });


            // tính tiền
            $(document).ready(function () {
                var selectElement = $("#hinh-thuc-thanh-toan");
                var tienKhachDuaInput = $("#tien-khach-dua");
                var tongTienInput = $("#tong-tien"); // Lấy ô input của tổng tiền
                var tienThuaLabel = $("#tien-thua");


                // Sự kiện change cho hình thức thanh toán
                selectElement.on("change", function () {
                    updateTienKhachDua(); // Cập nhật tiền khách đưa khi thay đổi hình thức thanh toán
                });

                // Sự kiện blur cho tiền khách đưa
                tienKhachDuaInput.on("blur", function () {
                    updateTienThua(); // Cập nhật tiền thừa khi blur khỏi trường tiền khách đưa
                });

                // Sự kiện khi thay đổi giá trị phí vận chuyển
                $('#feeInput, #tong-tien').on('input', function () {
                    formatCurrency(this);
                    updateTotal(); // Cập nhật tổng tiền khi giá trị phí vận chuyển hoặc tổng tiền thay đổi
                });

                // Sự kiện input để ngăn chặn việc nhập chữ trong trường tiền khách đưa
                tienKhachDuaInput.on("input", function () {
                    formatCurrency(this); // Gọi hàm formatCurrency để giữ lại chỉ số và dấu phẩy
                });

                function formatCurrency(input) {
                    // Giữ lại chỉ các ký tự số và dấu phẩy
                    let inputValue = input.value.replace(/[^\d,]/g, '');

                    // Định dạng lại giá trị
                    inputValue = inputValue.replace(/,/g, '');

                    // Gán giá trị đã định dạng lại vào trường input
                    input.value = inputValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }

                function updateTotal() {
                    // Use jQuery to get the value of the feeInput
                    let feeInput = $('#feeInput');

                    // Giữ lại chỉ các ký tự số và dấu phẩy
                    let phiVanChuyen = parseFloat(feeInput.val().replace(/,/g, '')) || 0;

                    // Lấy giá trị tổng tiền từ JSP
                    let tongTien = parseFloat('${tongTien}') || 0;

                    // Thêm phí vận chuyển vào tổng tiền
                    tongTien += phiVanChuyen;

                    // Định dạng lại tổng tiền và hiển thị trên giao diện
                    let formattedTongTien = tongTien.toLocaleString('en-US');
                    tongTienInput.val(formattedTongTien);

                    // Gán giá trị phiVanChuyen cho trường phiVanChuyen ẩn để submit lên server
                    feeInput.val(phiVanChuyen);
                }

                function updateTienKhachDua() {
                    var hinhThucThanhToan = selectElement.val();
                    var tongTien = parseFloat(tongTienInput.val());

                    if (hinhThucThanhToan === "2" || hinhThucThanhToan === "3") {
                        tienKhachDuaInput.val(tongTien.toLocaleString('en-US'));
                    } else {
                        tienKhachDuaInput.val("");
                    }
                }

                function updateTienThua() {
                    var tienKhachDua = parseFloat(tienKhachDuaInput.val().replace(/[^\d]/g, '')) || 0;
                    var tongTien = parseFloat(tongTienInput.val());

                    if (tienKhachDua >= tongTien) {
                        var tienThua = tienKhachDua - tongTien;
                        tienThuaLabel.text(tienThua.toLocaleString('en-US'));
                    } else {
                        tienThuaLabel.text("0");
                        alert("Tiền khách đưa phải lớn hơn hoặc bằng tổng tiền!");
                    }
                }
            });
            <%--// api vietqr--%>
            <%--$(document).ready(function () {--%>
            <%--    var clientId = '01d6d8e1-f32f-49c2-b2ed-569c35d2d407';--%>
            <%--    var apiKey = 'd662918e-19bd-4947-8ddd-fb8a1474dfe0';--%>
            <%--    var apiUrl = 'https://api.vietqr.io/v2/generate';--%>

            <%--    // Sự kiện change trên phần tử select--%>
            <%--    $('#hinh-thuc-thanh-toan').on('change', function () {--%>
            <%--        var selectedValue = $(this).val();--%>

            <%--        // Kiểm tra giá trị được chọn và hiển thị modal tương ứng--%>
            <%--        if (selectedValue === '1') {--%>
            <%--            // Tiền mặt - không hiển thị modal--%>
            <%--            // Có thể ẩn modal nếu nó đang hiển thị--%>
            <%--            $('#qrCodeModal').modal('hide');--%>
            <%--        } else if (selectedValue === '2') {--%>
            <%--            // Chuyển khoản - hiển thị modal và gửi yêu cầu API--%>
            <%--            $('#qrCodeModal').modal('show');--%>
            <%--            sendApiRequest();--%>
            <%--        }--%>
            <%--    });--%>

            <%--    function sendApiRequest() {--%>
            <%--        // Dữ liệu để gửi lên API--%>
            <%--        let tongTien = parseFloat('${tongTien}') || 0;--%>
            <%--        const maHoaDon = '${hoaDon.ma}';--%>
            <%--        var requestData = {--%>
            <%--            "accountNo": "0866613082003",--%>
            <%--            "accountName": "PHAM LE QUYEN ANH",--%>
            <%--            "acqId": "970422",--%>
            <%--            "addInfo": "Thanh toan hoa don " + maHoaDon,--%>
            <%--            "amount": tongTien,--%>
            <%--            "template": "compact",--%>
            <%--        };--%>

            <%--        // Gửi yêu cầu API sử dụng jQuery AJAX--%>
            <%--        $.ajax({--%>
            <%--            url: apiUrl,--%>
            <%--            type: 'POST',--%>
            <%--            headers: {--%>
            <%--                'x-client-id': clientId,--%>
            <%--                'x-api-key': apiKey,--%>
            <%--                'Content-Type': 'application/json'--%>
            <%--            },--%>
            <%--            data: JSON.stringify(requestData),--%>
            <%--            success: function (response) {--%>
            <%--                $('#qrCodeModal .modal-body').html('<img src="' + response.data.qrDataURL + '" class="img-fluid" />');--%>
            <%--            },--%>
            <%--            error: function (error) {--%>
            <%--                // Xử lý lỗi nếu có--%>
            <%--                console.error('API Error:', error);--%>
            <%--            }--%>
            <%--        });--%>
            <%--    }--%>
            <%--});--%>
            // api vietqr
            $(document).ready(function () {
                // Sự kiện change trên phần tử select
                $('#hinh-thuc-thanh-toan').on('change', function () {
                    var selectedValue = $(this).val();

                    // Kiểm tra giá trị được chọn và thực hiện hành động tương ứng
                    if (selectedValue === '1') {
                        // Tiền mặt - ẩn form
                        $('#paymentForm').hide();
                    } else if (selectedValue === '2') {
                        // Chuyển khoản - hiển thị form và tự động submit form
                        $('#paymentForm').show().submit();
                    }
                });
            });
            // Lấy giá trị từ input có id="tong-tien"
            var tongTienInput = document.getElementById('tong-tien');
            var tongTienValue = tongTienInput.value;

            // Gán giá trị vào input có id="total"
            var totalInput = document.getElementById('total');
            totalInput.value = tongTienValue;
        });
    </script>

    <div class="mt-3">
        <div class="text-center">
            <c:if test="${khachHangPage.totalPages > 1}">
                <ul class="pagination">
                    <li class="page-item <c:if test="${khachHangPage.number == 0}">disabled</c:if>">
                        <a class="page-link" href="?page=1">First</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${khachHangPage.totalPages}">
                        <li class="page-item <c:if test="${khachHangPage.number + 1 == i}">active</c:if>">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${khachHangPage.number == khachHangPage.totalPages - 1}">disabled</c:if>">
                        <a class="page-link" href="?page=${khachHangPage.totalPages - 1}">Last</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>

</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".update-button").click(function () {
        let id = $(this).data("id");

        // Thực hiện yêu cầu AJAX để lấy dữ liệu khách hàng dựa trên id
        $.ajax({
            url: "/admin/khach-hang/get/" + id,
            type: "GET",
            success: function (data) {
                // Đặt giá trị cho các trường trong modal bằng dữ liệu từ yêu cầu AJAX
                $("#hoVaTen").val(data.hoVaTen);
                $("#soDienThoai").val(data.soDienThoai);
                $("#email").val(data.email);
                $("#diaChi").val(data.diaChi);
                $("#xaPhuong").val(data.xaPhuong);
                $("#quanHuyen").val(data.quanHuyen);
                $("#tinhThanhPho").val(data.tinhThanhPho);
                $("#matKhau").val(data.matKhau);

                // Đặt action của form trong modal (action cập nhật với ID của khách hàng)
                $("#edit-form").attr("action", "/admin/khach-hang/update/" + id);
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
                var matKhauInput = document.querySelector("#matKhau");

                // Đặt tiêu đề modal thành "Cập Nhật Khách Hàng"
                modalTitle.textContent = "Cập Nhật Khách Hàng";

                // Vô hiệu hoá ô input mật khẩu
                matKhauInput.setAttribute("disabled", "disabled");
            });
        });
        clickClose.addEventListener("click", function () {
            var modalTitle = document.querySelector(".modal-title");
            var matKhauInput = document.querySelector("#matKhau");

            // Đặt tiêu đề modal thành "Thêm Khách Hàng"
            modalTitle.textContent = "Thêm Khách Hàng";

            // Bỏ vô hiệu hoá ô input mật khẩu
            matKhauInput.removeAttribute("disabled");
            // reset form
            $("#edit-form").trigger("reset");
            $("#edit-form").attr("action", "/admin/khach-hang/store");

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
