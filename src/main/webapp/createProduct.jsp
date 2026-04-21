<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>
<%@ page import="model.bean.HangHoa" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("accountInfo") == null) {
        response.sendRedirect("login.jsp?error=" + AppMessage.NOT_LOGGED_IN.getCode());
        return;
    }

    ArrayList<HangHoa> dsHangHoa = (ArrayList<HangHoa>) request.getAttribute("dsHangHoa");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Hàng Hóa</title>
</head>
<body>
    <%-- Thanh điều hướng --%>
    <nav class="navbar">
        <div class="navbar-brand">HỆ THỐNG QUẢN TRỊ</div>
        <div class="navbar-user">
            <span>Xin chào, <strong><%= session.getAttribute("accountInfo") %></strong>!</span>
            <a href="logout" class="btn-logout">Đăng xuất</a>
        </div>
    </nav>

    <%-- Xử lý hiển thị lỗi JSP --%>
    <%
        String errorCode = request.getParameter("message");
        if (errorCode != null) {
            AppMessage appMsg = AppMessage.fromCode(errorCode);
            
            // Gán icon phù hợp dựa trên loại thông báo
            String iconClass = "bx bx-info-circle";
            if ("error".equals(appMsg.getType())) iconClass = "bx bx-error-circle";
            else if ("warning".equals(appMsg.getType())) iconClass = "bx bx-error";
            else if ("success".equals(appMsg.getType())) iconClass = "bx bx-check-circle";
    %>
            <div class="alert alert-<%= appMsg.getType() %>">
                <i class='<%= iconClass %>'></i>
                <span><%= appMsg.getMessage() %></span>
            </div>
    <%
        }
    %>

    <form action="CreateProduct" method="post">
        <%-- Mã hàng hoá: <input type="text" name="maHH" /> --%>
        Tên hàng hoá: <input type="text" name="tenHH" />
        Danh mục: <input type="text" name="danhMuc" />
        Giá bán: <input type="text" name="giaBan" />
        Số lượng tồn: <input type="text" name="soLuongTon" />
        Mô tả: <input type="text" name="moTa" />

        <input type="submit"  onclick="return true;" value="Thêm" />
        <input type="reset" value="Huỷ bỏ" />
    </form>

    <script>
        function validate() {
            var errorMessage = "";
            if (document.getElementsByName("tenHH")[0].value.trim() === "") {
                errorMessage += "Tên hàng hoá không được để trống.\n";
            }

            if (document.getElementsByName("danhMuc")[0].value.trim() === "") {
                errorMessage += "Danh mục không được để trống.\n";
            }

            if (document.getElementsByName("giaBan")[0].value.trim() === "") {
                errorMessage += "Giá bán không được để trống.\n";
            } else {
                const giaBan = document.getElementsByName("giaBan")[0].value.trim();
                if (isNaN(giaBan) || Number(giaBan) <= 0) {
                    errorMessage += "Giá bán phải là một số dương.\n";
                }
            }

            if (document.getElementsByName("soLuongTon")[0].value.trim() === "") {
                errorMessage += "Số lượng tồn không được để trống.\n";
            } else {
                // phai la so nguyen duong
                const soLuongTon = document.getElementsByName("soLuongTon")[0].value.trim();
                if (isNaN(soLuongTon) || !Number.isInteger(Number(soLuongTon)) || Number(soLuongTon) < 0) {
                    errorMessage += "Số lượng tồn phải là một số nguyên không âm.\n";
                }
            }

            if (errorMessage) {
                alert(errorMessage);
                return false; // Ngăn form submit nếu có lỗi
            }
            return true;
        }
    </script>
</body>
</html>