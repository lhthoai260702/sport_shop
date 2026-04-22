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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Hàng Hóa - Hệ thống Quản trị</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --success: #10b981;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            color: var(--text-dark);
            /* Background Mesh Gradient đồng bộ */
            background: linear-gradient(-45deg, #c7d2fe, #fbcfe8, #fef08a, #a7f3d0);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* --- Navbar Glassmorphism --- */
        .navbar {
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.6);
            padding: 1rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-brand i { color: var(--primary); font-size: 1.5rem; }
        .navbar-user { display: flex; align-items: center; gap: 1.5rem; font-size: 0.95rem; }
        .navbar-user span { color: var(--text-muted); }
        .navbar-user strong { color: var(--primary); font-weight: 600; }

        .btn-logout {
            background-color: rgba(254, 226, 226, 0.8);
            color: var(--danger);
            border: 1px solid rgba(254, 202, 202, 0.8);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex; align-items: center; gap: 0.4rem;
        }
        .btn-logout:hover {
            background-color: var(--danger); color: #ffffff;
            transform: translateY(-2px); box-shadow: 0 4px 10px -2px rgba(239, 68, 68, 0.3);
        }

        /* --- Main Container --- */
        .container {
            max-width: 1300px;
            margin: 2rem auto;
            padding: 0 1.5rem;
            animation: slideUp 0.5s ease-out forwards;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .glass-panel {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* --- Toolbar (Search & Create) --- */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .btn-create {
            background: linear-gradient(to right, var(--primary), var(--primary-hover));
            color: white;
            border: none;
            padding: 0.75rem 1.25rem;
            border-radius: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: 0 4px 15px -3px rgba(99, 102, 241, 0.4);
        }
        .btn-create:hover { transform: translateY(-2px); box-shadow: 0 8px 20px -5px rgba(99, 102, 241, 0.5); }

        .search-form { display: flex; gap: 0.5rem; align-items: center; }
        .search-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .search-wrapper i {
            position: absolute; left: 1rem; color: var(--text-muted); font-size: 1.2rem;
        }
        .search-wrapper input {
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: 1px solid rgba(255, 255, 255, 0.8);
            background: rgba(255, 255, 255, 0.7);
            border-radius: 0.75rem;
            outline: none;
            transition: all 0.3s;
            width: 250px;
        }
        .search-wrapper input:focus { border-color: var(--primary); background: #fff; box-shadow: 0 0 0 3px rgba(99,102,241,0.2); }
        .btn-search {
            background: rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.9);
            padding: 0.75rem 1.25rem;
            border-radius: 0.75rem;
            cursor: pointer;
            font-weight: 600;
            color: var(--text-dark);
            transition: all 0.3s ease;
        }
        .btn-search:hover { background: #fff; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }

        /* --- Bảng dữ liệu --- */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            border-radius: 1rem;
            background: rgba(255, 255, 255, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.6);
        }

        table { width: 100%; border-collapse: collapse; text-align: left; white-space: nowrap; }
        th {
            background: rgba(255, 255, 255, 0.6);
            padding: 1rem;
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        td {
            padding: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            font-size: 0.95rem;
            vertical-align: middle;
        }
        tbody tr { transition: background 0.2s ease; }
        tbody tr:hover { background: rgba(255, 255, 255, 0.7); }

        /* Nút hành động trong bảng */
        .action-group { display: flex; gap: 0.5rem; }
        .action-btn {
            background: none; border: none; cursor: pointer;
            padding: 0.5rem; border-radius: 0.5rem; transition: all 0.2s;
            display: inline-flex; align-items: center; justify-content: center;
        }
        .btn-edit { color: var(--primary); background: rgba(99, 102, 241, 0.1); }
        .btn-edit:hover { background: var(--primary); color: white; }
        .btn-del { color: var(--danger); background: rgba(239, 68, 68, 0.1); }
        .btn-del:hover { background: var(--danger); color: white; }

        /* --- Phân trang (Pagination) --- */
        .pagination {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 0.4rem;
            margin-top: 1.5rem;
        }
        .page-link {
            text-decoration: none;
            padding: 0.5rem 0.8rem;
            background: rgba(255, 255, 255, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 0.5rem;
            color: var(--text-dark);
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .page-link:hover { background: #fff; transform: translateY(-1px); }
        .page-link.active {
            background: var(--primary); color: white; border-color: var(--primary);
        }

        /* Thông báo */
        .alert {
            padding: 1rem; border-radius: 1rem; margin-bottom: 1.5rem; font-size: 0.9rem; font-weight: 500;
            display: flex; align-items: center; gap: 0.75rem; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }
        .alert i { font-size: 1.25rem; }
        .alert-error { background-color: rgba(254, 242, 242, 0.9); color: #b91c1c; border: 1px solid #fca5a5; }
        .alert-warning { background-color: rgba(255, 251, 235, 0.9); color: #b45309; border: 1px solid #fcd34d; }
        .alert-success { background-color: rgba(240, 253, 244, 0.9); color: #15803d; border: 1px solid #86efac; }
    </style>
</head>
<body>

    <%-- Thanh điều hướng --%>
    <nav class="navbar">
        <div class="navbar-brand">
            <i class='bx bx-cube-alt'></i> HỆ THỐNG QUẢN TRỊ
        </div>
        <div class="navbar-user">
            <span>Xin chào, <strong><%= session.getAttribute("accountInfo") %></strong>!</span>
            <a href="logout" class="btn-logout"><i class='bx bx-log-out'></i> Đăng xuất</a>
        </div>
    </nav>

    <div class="container">
        <div class="glass-panel">
            
            <div class="page-header">
                <h2 class="page-title"><i class='bx bx-package'></i> Quản lý sản phẩm</h2>
            </div>

            <%-- Xử lý hiển thị lỗi JSP --%>
            <%
                String message = request.getParameter("message");
                if (message != null && !"null".equals(message)) {
                    AppMessage appMsg = AppMessage.fromCode(message);
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
            String searchText = session.getAttribute("searchText") != null 
                ? (String) session.getAttribute("searchText") 
                : "";
            String functionPrefix = "".equals(searchText) ? "ShowProductList" : "SearchProduct";
            %>

            <div class="toolbar">
                <a href="ShowCreateProduct" class="btn-create">
                    <i class='bx bx-plus'></i> Tạo mới
                </a>

                <form action="SearchProduct" method="post" class="search-form">
                    <div class="search-wrapper">
                        <i class='bx bx-search'></i>
                        <input type="text" name="searchText" value="<%=searchText%>" placeholder="Tìm kiếm sản phẩm...">
                    </div>
                    <button type="submit" class="btn-search">Tìm kiếm</button>
                </form>
            </div>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>ID</th>
                            <th>Tên hàng hoá</th>
                            <th>Danh mục</th>
                            <th>Giá bán</th>
                            <th>Số lượng</th>
                            <th>Mô tả</th>
                            <th style="text-align: center;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int currentPageNumber = request.getAttribute("currentPageNumber") != null ? (Integer)request.getAttribute("currentPageNumber") : 1;
                            int totalPageNumber   = request.getAttribute("totalPageNumber") != null ? (Integer)request.getAttribute("totalPageNumber") : 1;

                            if (dsHangHoa != null && !dsHangHoa.isEmpty()) {
                                int stt = (currentPageNumber - 1)*20 + 1;
                                for (HangHoa hh : dsHangHoa) {
                        %>
                        <tr>
                            <td><%= stt++ %></td>
                            <td><strong><%= hh.getMaHH() %></strong></td>
                            <td><%= hh.getTenHH() %></td>
                            <td><span style="background: rgba(99,102,241,0.1); color: var(--primary); padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.85rem;"><%= hh.getDanhMuc() %></span></td>
                            <td style="font-weight: 500;"><%= StringCommon.convertDoubleToStringWithComma(hh.getGiaBan()) %> đ</td>
                            <td><%= hh.getSoLuongTon() %></td>
                            <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis;"><%= hh.getMoTa() %></td>
                            <td>
                                <div class="action-group" style="justify-content: center;">
                                    <button class="action-btn btn-edit" title="Chỉnh sửa" onclick="location.href='ShowEditProduct?proId=<%=hh.getMaHH()%>';">
                                        <i class='bx bx-edit-alt'></i>
                                    </button>
                                    <button class="action-btn btn-del" title="Xóa" onclick="deleteProduct('<%=hh.getMaHH()%>')">
                                        <i class='bx bx-trash'></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 3rem 1rem; color: var(--text-muted);">
                                <i class='bx bx-folder-open' style="font-size: 3rem; margin-bottom: 0.5rem; display: block; color: rgba(0,0,0,0.2);"></i>
                                Không tìm thấy dữ liệu sản phẩm nào.
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <%
                int[] pageNumberList = new int[10];
                int pageQuantity = 0;

                if (totalPageNumber <= 10) {
                    for (int j = 0; j < totalPageNumber; j++) {
                        pageNumberList[j] = j + 1; pageQuantity++;
                    }
                } else if (currentPageNumber <= 4) {
                    for (int j = 0; j < 10; j++) {
                        pageNumberList[j] = j + 1; pageQuantity++;
                    }
                } else if (currentPageNumber >= (totalPageNumber - 5)) {
                    for (int j = 10; j >= 1; j--) {
                        pageNumberList[j - 1] = totalPageNumber - (10 - j); pageQuantity++;
                    }
                } else {
                    for (int j = 0; j < 10; j++) {
                        pageNumberList[j] = currentPageNumber - 3 + j; pageQuantity++;
                    }
                }
            %>

            <% if (totalPageNumber > 1) { %>
            <div class="pagination">
                <% if (currentPageNumber > 1) { %>
                    <a href="<%=functionPrefix%>?page=1" class="page-link" title="Trang đầu"><i class='bx bx-chevrons-left'></i></a>
                    <a href="<%=functionPrefix%>?page=<%= currentPageNumber - 1 %>" class="page-link" title="Trang trước"><i class='bx bx-chevron-left'></i></a>
                <% } %>

                <%
                    for (int k = 0; k < pageQuantity; k++) {
                        if (pageNumberList[k] == currentPageNumber) {
                %>
                            <a href="javascript:void(0)" class="page-link active"><%= pageNumberList[k] %></a>
                <%
                        } else {
                %>
                            <a href="<%=functionPrefix%>?page=<%= pageNumberList[k] %>" class="page-link"><%= pageNumberList[k] %></a>
                <%
                        }
                    }
                %>

                <% if (currentPageNumber < totalPageNumber) { %>
                    <a href="<%=functionPrefix%>?page=<%= currentPageNumber + 1 %>" class="page-link" title="Trang sau"><i class='bx bx-chevron-right'></i></a>
                    <a href="<%=functionPrefix%>?page=<%= totalPageNumber %>" class="page-link" title="Trang cuối"><i class='bx bx-chevrons-right'></i></a>
                <% } %>
            </div>
            <% } %>

        </div>
    </div>

    <script>
        function deleteProduct(proId) {
            // Thay thế alert thô bằng confirm, hoặc bạn có thể nâng cấp thêm SweetAlert sau này nếu muốn
            if (confirm("⚠️ Cảnh báo!\n\nBạn có chắc chắn muốn xóa sản phẩm (ID: " + proId + ") này không? Hành động này không thể hoàn tác.")) {
                window.location.href = "deleteProduct?proId=" + proId;
            }
        }
    </script>
</body>
</html>