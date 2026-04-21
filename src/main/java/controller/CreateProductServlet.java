package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bo.CreateProductBO;
import common.AppMessage;
import java.io.IOException;

@WebServlet(name = "CreateProductServlet", urlPatterns = { "/CreateProduct" })
public class CreateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        System.out.println("CreateProductServlet: doPost called");

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute("accountInfo") == null) {
            response.sendRedirect("login.jsp?message=" + AppMessage.NOT_LOGGED_IN.getCode());
            return;
        }

        // Lấy dữ liệu từ form
        // String maHH = request.getParameter("maHH");
        String tenHH = request.getParameter("tenHH");
        String danhMuc = request.getParameter("danhMuc");
        String giaBanStr = request.getParameter("giaBan");
        String soLuongTonStr = request.getParameter("soLuongTon");
        String moTa = request.getParameter("moTa");

        CreateProductBO createProductBO = new CreateProductBO();
        String returnedMessage = createProductBO.createProduct(tenHH, danhMuc, giaBanStr, soLuongTonStr, moTa);
        if ("No error".equals(returnedMessage)) {
            response.sendRedirect("showProductList?message=" + AppMessage.CREATE_SUCCESS.getCode());
        } else if ("Duplicate ID Error".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.DUPLICATE_ID.getCode());
        } else if ("Price cannot be empty".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_UNIT_PRIC_1.getCode());
        } else if ("Price cannot be negative".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_UNIT_PRICE_2.getCode());
        } else if ("Stock quantity cannot be empty".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_STOCK_QUANTITY_1.getCode());
        } else if ("Stock quantity cannot be negative".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_STOCK_QUANTITY_2.getCode());
        } else if ("Product name cannot be empty".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_PRODUCT_NAME.getCode());
        } else if ("Category cannot be empty".equals(returnedMessage)) {
            response.sendRedirect("ShowCreateProduct?message=" + AppMessage.INVALID_CATEGORY.getCode());
        } else {
            response.sendRedirect("showProductList?message=" + AppMessage.UNKNOWN_ERROR.getCode());
        }
    }
}
