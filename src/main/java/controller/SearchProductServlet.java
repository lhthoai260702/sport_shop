package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bean.HangHoa;
import model.bo.SearchProductBO;
import java.util.ArrayList;

@WebServlet(name = "SearchProductServlet", urlPatterns = {"/SearchProduct"})
public class SearchProductServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String searchText = request.getParameter("searchText");
        System.out.println("searchText: " + searchText);

        SearchProductBO searchProductBO = new SearchProductBO();
        ArrayList<HangHoa> dsHangHoa = searchProductBO.getDsHangHoa(searchText);
        System.out.println("dsHangHoa search: " + dsHangHoa);

        request.setAttribute("dsHangHoa", dsHangHoa);
        RequestDispatcher dispatcher = request.getRequestDispatcher("productList.jsp");
        dispatcher.forward(request, response);
    }
}
