<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.AppMessage" %>
<%@ page import="common.StringCommon"%>
<%@ page import="model.bean.HangHoa" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("accountInfo") == null) {
        response.sendRedirect("login.jsp?error=" + AppMessage.NOT_LOGGED_IN.getCode());
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Hàng Hóa - Hệ thống Quản trị</title>
    
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
            color: var(--text-dark);
            background: linear-gradient(-45deg, #c7d2fe, #fbcfe8, #fef08a, #a7f3d0);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* --- Navbar --- */
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

        .navbar-brand { font-size: 1.25rem; font-weight: 700; display: flex; align-items: center; gap: 0.5rem; }
        .navbar-brand i { color: var(--primary); font-size: 1.5rem; }
        .navbar-user { display: flex; align-items: center; gap: 1.5rem; font-size: 0.95rem; }
        .navbar-user span { color: var(--text-muted); }
        .navbar-user strong { color: var(--primary); font-weight: 600; }

        .btn-logout {
            background-color: rgba(254, 226, 226, 0.8); color: var(--danger);
            border: 1px solid rgba(254, 202, 202, 0.8); text-decoration: none;
            padding: 0.5rem 1rem; border-radius: 0.75rem; font-weight: 600;
            transition: all 0.3s ease; display: flex; align-items: center; gap: 0.4rem;
        }
        .btn-logout:hover {
            background-color: var(--danger); color: #ffffff; transform: translateY(-2px);
        }

        /* --- Container --- */
        .container {
            max-width: 800px;
            margin: 3rem auto;
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
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        }

        .page-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .page-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        /* --- Alerts --- */
        .alert {
            padding: 1rem; border-radius: 1rem; margin-bottom: 1.5rem; font-size: 0.9rem; font-weight: 500;
            display: flex; align-items: center; gap: 0.75rem; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }
        .alert i { font-size: 1.25rem; }
        .alert-error { background-color: rgba(254, 242, 242, 0.9); color: #b91c1c; border: 1px solid #fca5a5; }
        .alert-warning { background-color: rgba(255, 251, 235, 0.9); color: #b45309; border: 1px solid #fcd34d; }
        .alert-success { background-color: rgba(240, 253, 244, 0.9); color: #15803d; border: 1px solid #86efac; }

        /* --- Form --- */
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        .form-group.full-width { grid-column: span 2; }

        label { display: block; margin-bottom: 0.5rem; font-size: 0.9rem; font-weight: 600; color: var(--text-dark); }

        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 0.875rem 1rem;
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.75rem;
            font-size: 1rem;
            color: var(--text-dark);
            transition: all 0.3s ease;
            outline: none;
            font-family: inherit;
        }

        input:focus, textarea:focus {
            background-color: #ffffff; border-color: var(--primary); box-shadow: 0 0 0 4px var(--focus-ring);
        }

        textarea { resize: vertical; min-height: 100px; }

        /* Trạng thái disabled cho Mã Hàng Hóa */
        input:disabled {
            background-color: rgba(241, 245, 249, 0.7);
            color: var(--text-muted);
            cursor: not-allowed;
            border-style: dashed;
        }

        /* --- Buttons --- */
        .button-group {
            display: flex; gap: 1rem; margin-top: 2.5rem; justify-content: flex-end; padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.05);
        }

        .btn {
            padding: 0.875rem 1.5rem; border-radius: 0.75rem; font-size: 1rem; font-weight: 600; cursor: pointer;
            transition: all 0.3s ease; border: none; display: inline-flex; align-items: center; gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(to right, #3b82f6, #2563eb); color: white;
            box-shadow: 0 4px 15px -3px rgba(59, 130, 246, 0.4);
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 25px -5px rgba(59, 130, 246, 0.5); }

        .btn-secondary { background-color: rgba(255, 255, 255, 0.5); color: var(--text-dark); border: 1px solid rgba(255, 255, 255, 0.8); }
        .btn-secondary:hover { background-color: rgba(255, 255, 255, 0.9); }

        .btn-outline { background: transparent; color: var(--text-muted); border: 1px solid transparent; text-decoration: none; }
        .btn-outline:hover { color: var(--text-dark); background: rgba(0,0,0,0.05); border-radius: 0.75rem; }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-group.full-width { grid-column: span 1; }
            .button-group { flex-direction: column-reverse; }
            .btn { width: 100%; justify-content: center; }
        }
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
                <h2 class="page-title"><i class='bx bx-edit'></i> Chỉnh Sửa Hàng Hóa</h2>
                <p class="page-subtitle">Cập nhật thông tin chi tiết của sản phẩm</p>
            </div>

            <%-- Khai báo dữ liệu và Xử lý hiển thị lỗi JSP (Đã fix lỗi khai báo biến trùng) --%>
            <%
                String maHH = "";
                String tenHH = "";
                String danhMuc = "";
                String giaBan = "";
                String soLuongTon = "";
                String moTa = "";

                String msgParam = request.getParameter("message");
                
                // 1. Hiển thị thông báo nếu có
                if (msgParam != null && !"null".equals(msgParam)) {
                    AppMessage appMsg = AppMessage.fromCode(msgParam);
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

                // 2. Load dữ liệu vào Form
                if (msgParam == null || "".equals(msgParam)) {
                    // Vào lần đầu (từ DB)
                    HangHoa hangHoa = (HangHoa) request.getAttribute("hangHoa");
                    if (hangHoa != null) {
                        maHH = hangHoa.getMaHH();
                        tenHH = hangHoa.getTenHH();
                        danhMuc = hangHoa.getDanhMuc();
                        giaBan = StringCommon.convertDoubleToString(hangHoa.getGiaBan());
                        soLuongTon = String.valueOf(hangHoa.getSoLuongTon());
                        moTa = hangHoa.getMoTa() != null ? hangHoa.getMoTa() : ""; // Tránh null pointer cho textarea
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

            <%-- Form với validate JavaScript --%>
            <form action="EditProduct" method="post" onsubmit="return validate();">
                
                <div class="form-grid">
                    <div class="form-group full-width">
                        <label>Mã hàng hoá (Không thể thay đổi)</label>
                        <input type="text" value="<%= maHH %>" disabled="disabled" title="Mã hàng hoá là định danh duy nhất không thể sửa" />
                        <input type="hidden" name="maHH" value="<%= maHH %>" />
                    </div>

                    <div class="form-group full-width">
                        <label for="tenHH">Tên hàng hoá <span style="color: red;">*</span></label>
                        <input type="text" id="tenHH" name="tenHH" value="<%= tenHH %>" />
                    </div>

                    <div class="form-group">
                        <label for="danhMuc">Danh mục <span style="color: red;">*</span></label>
                        <input type="text" id="danhMuc" name="danhMuc" value="<%= danhMuc %>" />
                    </div>

                    <div class="form-group">
                        <label for="giaBan">Giá bán (VNĐ) <span style="color: red;">*</span></label>
                        <input type="text" id="giaBan" name="giaBan" value="<%= giaBan %>" />
                    </div>

                    <div class="form-group">
                        <label for="soLuongTon">Số lượng tồn kho <span style="color: red;">*</span></label>
                        <input type="text" id="soLuongTon" name="soLuongTon" value="<%= soLuongTon %>" />
                    </div>

                    <div class="form-group full-width">
                        <label for="moTa">Mô tả sản phẩm</label>
                        <textarea id="moTa" name="moTa"><%= moTa %></textarea>
                    </div>
                </div>

                <div class="button-group">
                    <a href="ShowProductList" class="btn btn-outline">
                        <i class='bx bx-arrow-back'></i> Quay lại
                    </a>
                    <button type="reset" class="btn btn-secondary">
                        <i class='bx bx-refresh'></i> Khôi phục gốc
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class='bx bx-save'></i> Cập nhật thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validate() {
            var errorMessage = "";
            
            if (document.getElementsByName("tenHH")[0].value.trim() === "") {
                errorMessage += "• Tên hàng hoá không được để trống.\n";
            }

            if (document.getElementsByName("danhMuc")[0].value.trim() === "") {
                errorMessage += "• Danh mục không được để trống.\n";
            }

            if (document.getElementsByName("giaBan")[0].value.trim() === "") {
                errorMessage += "• Giá bán không được để trống.\n";
            } else {
                const giaBan = document.getElementsByName("giaBan")[0].value.trim();
                if (isNaN(giaBan) || Number(giaBan) <= 0) {
                    errorMessage += "• Giá bán phải là một số dương hợp lệ.\n";
                }
            }

            if (document.getElementsByName("soLuongTon")[0].value.trim() === "") {
                errorMessage += "• Số lượng tồn không được để trống.\n";
            } else {
                const soLuongTon = document.getElementsByName("soLuongTon")[0].value.trim();
                if (isNaN(soLuongTon) || !Number.isInteger(Number(soLuongTon)) || Number(soLuongTon) < 0) {
                    errorMessage += "• Số lượng tồn phải là một số nguyên không âm.\n";
                }
            }

            if (errorMessage) {
                alert("Vui lòng kiểm tra lại thông tin:\n\n" + errorMessage);
                return false; 
            }
            return true;
        }
    </script>
</body>
</html>