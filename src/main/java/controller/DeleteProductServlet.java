package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bo.DeleteProductBO;
import common.AppMessage;

@WebServlet(name = "DeleteProductServlet", urlPatterns = { "/deleteProduct" })
public class DeleteProductServlet extends HttpServlet {
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

        String proId = request.getParameter("proId");

        DeleteProductBO deleteProductBO = new DeleteProductBO();
        deleteProductBO.deleteProduct(proId);

        response.sendRedirect("ShowProductList?message=" + AppMessage.DELETE_SUCCESS.getCode());
    }
}
