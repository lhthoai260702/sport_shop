package controller;

import java.io.IOException;

import common.AppMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bo.EditProductBO;

@WebServlet(name = "EditProductServlet", urlPatterns = { "/EditProduct" })
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute("accountInfo") == null) {
            response.sendRedirect("login.jsp?message=" + AppMessage.NOT_LOGGED_IN.getCode());
            return;
        }

        String maHH = request.getParameter("maHH");
        String tenHH = request.getParameter("tenHH");
        String danhMuc = request.getParameter("danhMuc");
        String giaBanStr = request.getParameter("giaBan");
        String soLuongTonStr = request.getParameter("soLuongTon");
        String moTa = request.getParameter("moTa");

        EditProductBO editProductBO = new EditProductBO();
        String returnedMessage = editProductBO.editProduct(maHH, tenHH, danhMuc, giaBanStr, soLuongTonStr, moTa);
        System.out.println("Returned message from BO: " + returnedMessage);

        RequestDispatcher rd = null;
        if ("No error".equals(returnedMessage)) {
            rd = request.getRequestDispatcher("ShowProductList?message=" + AppMessage.CREATE_SUCCESS.getCode());
        } else if ("Duplicate ID Error".equals(returnedMessage)) {
            rd = request.getRequestDispatcher("ShowEditProduct?message=" + AppMessage.DUPLICATE_ID.getCode());
        } else if ("Price cannot be empty".equals(returnedMessage)) {
            rd = request
                    .getRequestDispatcher("ShowEditProduct?message=" + AppMessage.INVALID_UNIT_PRIC_1.getCode());
        } else if ("Price cannot be negative".equals(returnedMessage)
                || "Invalid price format".equals(returnedMessage)) {
            rd = request.getRequestDispatcher(
                    "ShowEditProduct?message=" + AppMessage.INVALID_UNIT_PRICE_2.getCode());
        } else if ("Stock quantity cannot be empty".equals(returnedMessage)) {
            rd = request.getRequestDispatcher(
                    "ShowEditProduct?message=" + AppMessage.INVALID_STOCK_QUANTITY_1.getCode());
        } else if ("Stock quantity cannot be negative".equals(returnedMessage)
                || "Invalid stock quantity format".equals(returnedMessage)) {
            rd = request.getRequestDispatcher(
                    "ShowEditProduct?message=" + AppMessage.INVALID_STOCK_QUANTITY_2.getCode());
        } else if ("Product name cannot be empty".equals(returnedMessage)) {
            rd = request.getRequestDispatcher(
                    "ShowEditProduct?message=" + AppMessage.INVALID_PRODUCT_NAME.getCode());
        } else if ("Category cannot be empty".equals(returnedMessage)) {
            rd = request
                    .getRequestDispatcher("ShowEditProduct?message=" + AppMessage.INVALID_CATEGORY.getCode());
        } else {
            rd = request.getRequestDispatcher("ShowEditProduct?message=" + AppMessage.UNKNOWN_ERROR.getCode());
        }

        rd.forward(request, response);
    }

}
