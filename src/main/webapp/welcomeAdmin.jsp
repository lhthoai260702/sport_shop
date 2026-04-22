<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>

<%
    // Kiểm tra đăng nhập ngay đầu trang, trước khi render bất kỳ HTML nào
    if (session.getAttribute("accountInfo") == null) {
        // Sử dụng mã lỗi e2 hoặc acc_locked tùy theo AppResponse bạn đã định nghĩa
        response.sendRedirect("login.jsp?error=" + AppMessage.NOT_LOGGED_IN.getCode());
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển - Hệ thống Quản trị</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-hover: #4338ca;
            --bg-color: #f3f4f6; /* Màu nền xám nhạt cho trang admin */
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --white: #ffffff;
            --danger: #ef4444;
            --danger-hover: #dc2626;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
        }

        /* --- Thanh điều hướng (Navbar) --- */
        .navbar {
            background-color: var(--white);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
            letter-spacing: 0.5px;
        }

        .navbar-user {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            font-size: 0.95rem;
        }

        .navbar-user strong {
            color: var(--primary-color);
            font-weight: 600;
        }

        .btn-logout {
            background-color: #fee2e2;
            color: var(--danger);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-logout:hover {
            background-color: var(--danger);
            color: var(--white);
        }

        /* --- Nội dung chính (Container) --- */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dashboard-card {
            background-color: var(--white);
            border-radius: 1rem;
            padding: 2.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.02);
        }

        .dashboard-card h2 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .dashboard-card p {
            color: var(--text-muted);
            margin-bottom: 2rem;
            font-size: 0.95rem;
        }

        /* --- Lưới nút chức năng (Actions) --- */
        .menu-actions {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .btn-action {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary-color);
            color: var(--white);
            text-decoration: none;
            padding: 1.25rem;
            border-radius: 0.75rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.2s;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
        }

        .btn-action:hover {
            background-color: var(--primary-hover);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3);
        }

        /* Responsive cho Mobile */
        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
                text-align: center;
            }
            .dashboard-card {
                padding: 1.5rem;
            }
        }
    </style>
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

    <%-- Nội dung chính --%>
    <div class="container">
        <div class="dashboard-card">
            <h2>Bảng điều khiển</h2>
            <p>Chọn các chức năng bên dưới để quản lý hệ thống của bạn.</p>
            
            <div class="menu-actions">
                <a href="ShowProductList" class="btn-action">
                    📦 Quản lý hàng hóa
                </a>
                </div>
        </div>
    </div>

</body>
</html>