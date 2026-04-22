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
        String message = request.getParameter("message");
        if (message != null && !"null".equals(message)) {
            AppMessage appMsg = AppMessage.fromCode(message);
            
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

    <%
    String searchText = session.getAttribute("searchText") != null 
        ? (String) session.getAttribute("searchText") 
        : "";

    String functionPrefix = "".equals(searchText) ? "ShowProductList" : "SearchProduct";
    %>

    <form action="SearchProduct" method="post">
        <input type="text" name="searchText" value="<%=searchText%>" />
        <input type="submit" value="Search" />
    </form>


<%
    int currentPageNumber = (Integer)request.getAttribute("currentPageNumber");
    int totalPageNumber   = (Integer)request.getAttribute("totalPageNumber");

    int[] pageNumberList = new int[10];
    int pageQuantity = 0;

    // Trường hợp tổng page <= 10
    if (totalPageNumber <= 10) {
        for (int j = 0; j < totalPageNumber; j++) {
            pageNumberList[j] = j + 1;
            pageQuantity++;
        }
    }

    // Trường hợp > 10 và đang ở đầu
    if (totalPageNumber > 10 && currentPageNumber <= 4) {
        for (int j = 0; j < 10; j++) {
            pageNumberList[j] = j + 1;
            pageQuantity++;
        }
    }

    // Trường hợp > 10 và đang ở cuối
    if (totalPageNumber > 10 && currentPageNumber >= (totalPageNumber - 5)) {
        for (int j = 10; j >= 1; j--) {
            pageNumberList[j - 1] = totalPageNumber - (10 - j);
            pageQuantity++;
        }
    }

    // Trường hợp ở giữa
    if (totalPageNumber > 10 
        && currentPageNumber >= 5 
        && currentPageNumber <= (totalPageNumber - 5)) {
        
        for (int j = 0; j < 10; j++) {
            pageNumberList[j] = currentPageNumber - 3 + j;
            pageQuantity++;
        }
    }
%>

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
                    int stt = (currentPageNumber - 1)*20 + 1;
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

<% if (currentPageNumber > 1) { %>
    <a href="<%=functionPrefix%>?page=1">First</a>
    <a href="<%=functionPrefix%>?page=<%= currentPageNumber - 1 %>">Previous</a>
<% } %>

<%
    // Render pagination
    for (int k = 0; k < pageQuantity; k++) {
        if (pageNumberList[k] == currentPageNumber) {
%>
            <a href="<%=functionPrefix%>?page=<%= pageNumberList[k] %>">
                <b><%= pageNumberList[k] %></b>
            </a>
<%
        } else {
%>
            <a href="<%=functionPrefix%>?page=<%= pageNumberList[k] %>">
                <%= pageNumberList[k] %>
            </a>
<%
        }
    }
%>

<% if (currentPageNumber < totalPageNumber) { %>
    <a href="<%=functionPrefix%>?page=<%= currentPageNumber + 1 %>">Next</a>
    <a href="<%=functionPrefix%>?page=<%= currentPageNumber %>">Last</a>
<% } %>

    <script>
        function deleteProduct(proId) {
            if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
                window.location.href = "deleteProduct?proId=" + proId;
            }
        }
    </script>
</body>
</html>