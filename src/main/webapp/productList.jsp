<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>
<%@ page import="model.bean.HangHoa" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="common.StringCommon"%>

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

    <input type="button" onclick="location.href='ShowCreateProduct'" value="Tạo mới" />

    <form action="SearchProduct" method="post">
        <input type="text" name="searchText" />
        <input type="submit" value="Search" />
    </form>

    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
            <tr>
                <th>STT</th>
                <th>ID</th>
                <th>Tên hàng hoá</th>
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
                <td><%= hh.getDanhMuc() %></td>
                <td><%= StringCommon.convertDoubleToStringWithComma(hh.getGiaBan()) %></td>
                <td><%= hh.getSoLuongTon() %></td>
                <td><%= hh.getMoTa() %></td>
                <td>
                    <input type="button" onclick="location.href='ShowEditProduct?proId=<%=hh.getMaHH()%>';" value="Chỉnh sửa" />
                    <input type="button" onclick="deleteProduct('<%=hh.getMaHH()%>')" value="Xóa" />
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

    <script>
        function deleteProduct(proId) {
            if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
                window.location.href = "deleteProduct?proId=" + proId;
            }
        }
    </script>
</body>
</html>