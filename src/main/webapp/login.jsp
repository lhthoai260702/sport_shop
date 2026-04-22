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
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --input-bg: rgba(255, 255, 255, 0.7);
            --border-color: rgba(255, 255, 255, 0.5);
            --focus-ring: rgba(99, 102, 241, 0.25);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Background Mesh Gradient mượt mà và sang trọng hơn */
            background: linear-gradient(-45deg, #c7d2fe, #fbcfe8, #fef08a, #a7f3d0);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            padding: 1rem;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-container {
            /* Authentic Glassmorphism */
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.8);
            padding: 3rem 2.5rem;
            border-radius: 1.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(255, 255, 255, 0.2) inset;
            width: 100%;
            max-width: 420px;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            opacity: 0;
            transform: translateY(30px);
        }

        @keyframes slideUp {
            to { opacity: 1; transform: translateY(0); }
        }

        .brand-logo {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .brand-logo .logo-circle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            border-radius: 20px;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
            transform: rotate(-10deg);
            transition: transform 0.3s ease;
        }
        
        .login-container:hover .logo-circle {
            transform: rotate(0deg) scale(1.05);
        }

        .brand-logo i {
            font-size: 2.5rem;
            color: #ffffff;
        }

        h2 {
            text-align: center;
            font-weight: 700;
            color: var(--text-dark);
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            letter-spacing: -0.025em;
        }

        .subtitle {
            text-align: center;
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 2rem;
            font-weight: 400;
        }

        /* --- STYLING CHO THÔNG BÁO LỖI --- */
        .alert {
            padding: 1rem;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: shake 0.5s ease-in-out;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .alert i { font-size: 1.25rem; }
        
        .alert-error {
            background-color: rgba(254, 242, 242, 0.9);
            color: #b91c1c;
            border: 1px solid #fca5a5;
        }
        
        .alert-warning {
            background-color: rgba(255, 251, 235, 0.9);
            color: #b45309;
            border: 1px solid #fcd34d;
        }
        
        .alert-success {
            background-color: rgba(240, 253, 244, 0.9);
            color: #15803d;
            border: 1px solid #86efac;
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
            display: flex;
            align-items: center;
        }

        .input-wrapper .icon-left {
            position: absolute;
            left: 1rem;
            color: #94a3b8;
            font-size: 1.25rem;
            transition: color 0.3s ease;
            z-index: 2;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.875rem 2.5rem 0.875rem 2.75rem;
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            font-size: 1rem;
            color: var(--text-dark);
            transition: all 0.3s ease;
            outline: none;
            backdrop-filter: blur(5px);
        }

        input[type="text"]::placeholder,
        input[type="password"]::placeholder {
            color: #94a3b8;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            background-color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px var(--focus-ring);
        }

        input[type="text"]:focus ~ .icon-left,
        input[type="password"]:focus ~ .icon-left {
            color: var(--primary);
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            color: #94a3b8;
            font-size: 1.25rem;
            cursor: pointer;
            transition: color 0.3s ease;
            z-index: 2;
        }

        .toggle-password:hover {
            color: var(--text-dark);
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
            border-radius: 1rem;
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
            background: linear-gradient(to right, var(--primary), var(--primary-hover));
            color: white;
            box-shadow: 0 4px 15px -3px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px -5px rgba(99, 102, 241, 0.5);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background-color: rgba(255, 255, 255, 0.5);
            color: var(--text-dark);
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="brand-logo">
            <div class="logo-circle">
                <i class='bx bx-cube-alt'></i>
            </div>
        </div>
        
        <h2>Đăng nhập</h2>
        <p class="subtitle">Hệ thống quản trị Cửa hàng</p>

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

        <form action="check-login" method="post">
            <div class="form-group">
                <label for="tenDangNhap">Tên đăng nhập</label>
                <div class="input-wrapper">
                    <i class='bx bx-user icon-left'></i>
                    <input type="text" id="tenDangNhap" name="tenDangNhap" required placeholder="Nhập tên đăng nhập">
                </div>
            </div>
            
            <div class="form-group">
                <label for="matKhau">Mật khẩu</label>
                <div class="input-wrapper">
                    <i class='bx bx-lock-alt icon-left'></i>
                    <input type="password" id="matKhau" name="matKhau" required placeholder="Nhập mật khẩu">
                    <i class='bx bx-hide toggle-password' id="togglePassword"></i>
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

    <script>
        // Script nhỏ để xử lý tính năng Hiện/Ẩn mật khẩu
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#matKhau');

        togglePassword.addEventListener('click', function (e) {
            // Đổi type của input
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            
            // Đổi icon con mắt
            this.classList.toggle('bx-show');
            this.classList.toggle('bx-hide');
        });
    </script>
</body>
</html>