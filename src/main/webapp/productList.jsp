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

<h2>Quản lý sản phẩm</h2>

<table border="1" cellpadding="10" cellspacing="0">
    <thead>
        <tr>
            <th>STT</th>
            <th>ID</th>
            <th>Danh mục</th>
            <th>Giá bán</th>
            <th>Số lượng</th>
            <th>Mô tả</th>
            <th>Hành động</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (dsHangHoa != null && !dsHangHoa.isEmpty()) {
                int stt = 1;
                for (HangHoa hh : dsHangHoa) {
        %>
        <tr>
            <td><%= stt++ %></td>
            <td><%= hh.getMaHH() %></td>
            <td><%= hh.getTenHH() %></td>
            <td><%= hh.getGiaBan() %></td>
            <td><%= hh.getSoLuongTon() %></td>
            <td><%= hh.getMoTa() %></td>
            <td>
                <input type="button" value="Chỉnh sửa" />
                <input type="button" value="Xóa" />
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7">Không có dữ liệu</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>