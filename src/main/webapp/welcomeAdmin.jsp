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
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --text-dark: #1e293b;
            --text-muted: #64748b;
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
            min-height: 100vh;
            color: var(--text-dark);
            /* Background Mesh Gradient đồng bộ với trang Đăng nhập */
            background: linear-gradient(-45deg, #c7d2fe, #fbcfe8, #fef08a, #a7f3d0);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* --- Thanh điều hướng (Navbar) - Glassmorphism --- */
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
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-brand i {
            color: var(--primary);
            font-size: 1.5rem;
        }

        .navbar-user {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            font-size: 0.95rem;
        }

        .navbar-user span {
            color: var(--text-muted);
        }

        .navbar-user strong {
            color: var(--primary);
            font-weight: 600;
        }

        .btn-logout {
            background-color: rgba(254, 226, 226, 0.8);
            color: var(--danger);
            border: 1px solid rgba(254, 202, 202, 0.8);
            text-decoration: none;
            padding: 0.6rem 1.2rem;
            border-radius: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .btn-logout:hover {
            background-color: var(--danger);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px -2px rgba(239, 68, 68, 0.3);
        }

        /* --- Nội dung chính (Container) --- */
        .container {
            max-width: 1200px;
            margin: 3rem auto;
            padding: 0 1.5rem;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            opacity: 0;
            transform: translateY(30px);
        }

        @keyframes slideUp {
            to { opacity: 1; transform: translateY(0); }
        }

        .dashboard-card {
            /* Authentic Glassmorphism đồng bộ */
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 1.5rem;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.2) inset;
        }

        .dashboard-card h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            letter-spacing: -0.025em;
        }

        .dashboard-card p {
            color: var(--text-muted);
            margin-bottom: 2.5rem;
            font-size: 1rem;
        }

        /* --- Lưới nút chức năng (Actions) --- */
        .menu-actions {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .btn-action {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: rgba(255, 255, 255, 0.7);
            color: var(--text-dark);
            text-decoration: none;
            padding: 1.5rem;
            border-radius: 1rem;
            font-weight: 600;
            font-size: 1.05rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        .btn-action i {
            font-size: 1.8rem;
            color: var(--primary);
            background: rgba(99, 102, 241, 0.1);
            padding: 0.75rem;
            border-radius: 0.75rem;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            background: linear-gradient(to right, var(--primary), var(--primary-hover));
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
            border-color: transparent;
        }

        .btn-action:hover i {
            color: white;
            background: rgba(255, 255, 255, 0.2);
        }

        /* Responsive cho Mobile */
        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1.25rem;
                text-align: center;
            }
            .dashboard-card {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

    <%-- Thanh điều hướng --%>
    <nav class="navbar">
        <div class="navbar-brand">
            <i class='bx bx-cube-alt'></i> CỬA HÀNG ADMIN
        </div>
        <div class="navbar-user">
            <span>Xin chào, <strong><%= session.getAttribute("accountInfo") %></strong>!</span>
            <a href="logout" class="btn-logout">
                <i class='bx bx-log-out'></i> Đăng xuất
            </a>
        </div>
    </nav>

    <%-- Nội dung chính --%>
    <div class="container">
        <div class="dashboard-card">
            <h2>Bảng điều khiển</h2>
            <p>Chọn các chức năng bên dưới để quản lý hệ thống của bạn.</p>
            
            <div class="menu-actions">
                <a href="ShowProductList" class="btn-action">
                    <i class='bx bx-package'></i>
                    Quản lý hàng hóa
                </a>
                
                </div>
        </div>
    </div>

</body>
</html>