<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>
<%@ page import="common.StringCommon"%>
<%@ page import="model.bean.HangHoa" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat"%>
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

    <%
        String maHH = "";
        String tenHH = "";
        String danhMuc = "";
        String giaBan = "";
        String soLuongTon = "";
        String moTa = "";

        String message = request.getParameter("message");

        if (message == null || "".equals(message)) {
            // Vào lần đầu (từ DB)
            HangHoa hangHoa = (HangHoa) request.getAttribute("hangHoa");

            if (hangHoa != null) {
                maHH = hangHoa.getMaHH();
                tenHH = hangHoa.getTenHH();
                danhMuc = hangHoa.getDanhMuc();
                giaBan = StringCommon.convertDoubleToString(hangHoa.getGiaBan());
                soLuongTon = String.valueOf(hangHoa.getSoLuongTon());
                moTa = hangHoa.getMoTa();
            }

        } else {
            // Khi submit lỗi → lấy lại dữ liệu user đã nhập
            maHH = request.getParameter("maHH") != null ? request.getParameter("maHH") : "";
            tenHH = request.getParameter("tenHH") != null ? request.getParameter("tenHH") : "";
            danhMuc = request.getParameter("danhMuc") != null ? request.getParameter("danhMuc") : "";
            giaBan = request.getParameter("giaBan") != null ? request.getParameter("giaBan") : "";
            soLuongTon = request.getParameter("soLuongTon") != null ? request.getParameter("soLuongTon") : "";
            moTa = request.getParameter("moTa") != null ? request.getParameter("moTa") : "";
        }
    %>

    <h2>CHỈNH SỬA HÀNG HÓA</h2>

    <form action="EditProduct" method="post">
        
        Mã hàng hoá:
        <input type="text" value="<%=maHH%>" disabled="disabled"/>
        <input type="hidden" name="maHH" value="<%=maHH%>" />

        <br/>

        Tên hàng hoá:
        <input type="text" name="tenHH" value="<%=tenHH%>" />

        <br/>

        Danh mục:
        <input type="text" name="danhMuc" value="<%=danhMuc%>" />

        <br/>

        Giá bán:
        <input type="text" name="giaBan" value="<%=giaBan%>" />

        <br/>

        Số lượng tồn:
        <input type="text" name="soLuongTon" value="<%=soLuongTon%>" />

        <br/>

        Mô tả:
        <input type="text" name="moTa" value="<%=moTa%>" />

        <br/><br/>

        <input type="submit" value="Cập nhật" />
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