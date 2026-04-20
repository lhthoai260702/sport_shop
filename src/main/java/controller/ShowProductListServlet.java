package controller;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HangHoa;
import model.bo.ShowProductListBO;
import common.AppMessage;

@WebServlet(name = "ShowProductListServlet", urlPatterns = { "/showProductList" })
public class ShowProductListServlet extends HttpServlet {

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

        String message = request.getParameter("message");
        System.out.println("Message: " + message);

        HttpSession session = request.getSession();

        if (session.getAttribute("accountInfo") == null) {
            response.sendRedirect("login.jsp?error=" + AppMessage.NOT_LOGGED_IN.getCode());
        } else {
            ShowProductListBO showProductListBO = new ShowProductListBO();
            ArrayList<HangHoa> dsHangHoa = showProductListBO.getDsHangHoa();

            request.setAttribute("dsHangHoa", dsHangHoa);
            RequestDispatcher dispatcher = request.getRequestDispatcher("productList.jsp?message=" + message);
            dispatcher.forward(request, response);
        }
    }
}
