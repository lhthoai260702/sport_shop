<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-gradient: linear-gradient(135deg, #ece9e6 0%, #ffffff 100%);
            --text-dark: #111827;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --input-bg: #f9fafb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Background hiện đại với các dải màu nổi bật */
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-container {
            /* Hiệu ứng kính (Glassmorphism) */
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 3rem 2.5rem;
            border-radius: 1.25rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 420px;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .brand-logo {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .brand-logo i {
            font-size: 3rem;
            color: var(--primary);
            background: #eef2ff;
            padding: 1rem;
            border-radius: 50%;
        }

        h2 {
            text-align: center;
            font-weight: 700;
            color: var(--text-dark);
            font-size: 1.75rem;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            text-align: center;
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
        }

        /* --- STYLING CHO THÔNG BÁO LỖI --- */
        .alert {
            padding: 1rem;
            border-radius: 0.75rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .alert i { font-size: 1.25rem; }
        
        .alert-error {
            background-color: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }
        
        .alert-warning {
            background-color: #fffbeb;
            color: #b45309;
            border: 1px solid #fde68a;
        }
        
        .alert-success {
            background-color: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        /* --- STYLING CHO FORM --- */
        .form-group {
            margin-bottom: 1.25rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 1.25rem;
            transition: color 0.3s ease;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem; /* Padding trái lớn hơn để chừa chỗ cho icon */
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            font-size: 1rem;
            color: var(--text-dark);
            transition: all 0.3s ease;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            background-color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        input[type="text"]:focus + i,
        input[type="password"]:focus + i,
        .input-wrapper input:focus ~ i {
            color: var(--primary);
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            width: 100%;
            padding: 0.875rem;
            border-radius: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3);
        }

        .btn-secondary {
            background-color: transparent;
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background-color: #f3f4f6;
            color: var(--text-dark);
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="brand-logo">
            <i class='bx bx-cube-alt'></i>
        </div>
        
        <h2>Đăng nhập</h2>
        <p class="subtitle">Hệ thống quản trị Cửa hàng</p>

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

        <form action="check-login" method="post">
            <div class="form-group">
                <label for="tenDangNhap">Tên đăng nhập</label>
                <div class="input-wrapper">
                    <input type="text" id="tenDangNhap" name="tenDangNhap" required placeholder="Nhập tên đăng nhập">
                    <i class='bx bx-user'></i>
                </div>
            </div>
            
            <div class="form-group">
                <label for="matKhau">Mật khẩu</label>
                <div class="input-wrapper">
                    <input type="password" id="matKhau" name="matKhau" required placeholder="Nhập mật khẩu">
                    <i class='bx bx-lock-alt'></i>
                </div>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    Đăng nhập <i class='bx bx-right-arrow-alt'></i>
                </button>
                <button type="button" class="btn btn-secondary" onclick="window.location.href='index.jsp'">
                    <i class='bx bx-home-alt'></i> Quay về trang chủ
                </button>
            </div>
        </form>
    </div>

</body>
</html>