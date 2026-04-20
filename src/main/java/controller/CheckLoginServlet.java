package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bo.CheckLoginBO;
import common.AppMessage;
import java.io.IOException;

@WebServlet(name = "CheckLoginServlet", urlPatterns = { "/check-login" })
public class CheckLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập Charset theo tài liệu
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Lấy tham số gửi lên từ View
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        CheckLoginBO checkLoginBO = new CheckLoginBO();
        int accountRole = checkLoginBO.getAccountRole(tenDangNhap, matKhau);

        HttpSession session = request.getSession();

        // Xử lý logic dựa trên vai trò tài khoản
        // 0: Tài khoản không hợp lệ, 1: Admin, 2: User
        final int INVALID_ACCOUNT = 0;
        final int ADMIN_ACCOUNT = 1;
        // final int USER_ACCOUNT = 2;

        if (accountRole == INVALID_ACCOUNT) {
            request.getRequestDispatcher("login.jsp?message=" + AppMessage.INVALID_CREDENTIALS.getCode()).forward(request,
                    response);
        } else if (accountRole == ADMIN_ACCOUNT) {
            session.setAttribute("accountInfo", tenDangNhap + "(admin)");
            request.getRequestDispatcher("welcomeAdmin.jsp").forward(request, response);
        } else {
            session.setAttribute("accountInfo", tenDangNhap + "(user)");
            request.getRequestDispatcher("welcomeEmployee.jsp").forward(request, response);
        }
    }

}
