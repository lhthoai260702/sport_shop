package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HangHoa;
import model.bo.EditProductBO;
import common.AppMessage;
import java.io.IOException;

@WebServlet(name = "ShowEditProductServlet", urlPatterns = { "/ShowEditProduct" })
public class ShowEditProductServlet extends HttpServlet {
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
        EditProductBO editProductBO = new EditProductBO();

        HangHoa hangHoa = editProductBO.getProductById(proId);
        request.setAttribute("hangHoa", hangHoa);

        RequestDispatcher rd = request.getRequestDispatcher("editProduct.jsp");
        rd.forward(request, response);
    }

}
