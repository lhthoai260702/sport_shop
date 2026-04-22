package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HangHoa;
import model.bo.SearchProductBO;
import java.util.ArrayList;

@WebServlet(name = "SearchProductServlet", urlPatterns = { "/SearchProduct" })
public class SearchProductServlet extends HttpServlet {

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
        String searchText = request.getParameter("searchText");
        if (searchText != null && !"".equals(searchText)) {
            session.setAttribute("searchText", searchText);
        } else {
            searchText = (String) session.getAttribute("searchText");
        }

        SearchProductBO searchProductBO = new SearchProductBO();

        System.out.println("searchText search product: " + searchText);

        String page = request.getParameter("page");
        int pageNumber = 1; // Mẫc định là trang 1
        if (page != null && !"".equals(page)) {
            pageNumber = Integer.valueOf(page);
        }
        ArrayList<HangHoa> dsHangHoa = searchProductBO.getDsHangHoa(searchText, pageNumber);
        int totalPageNumber = searchProductBO.getTotalPageNumber(searchText);

        request.setAttribute("dsHangHoa", dsHangHoa);
        request.setAttribute("totalPageNumber", totalPageNumber);
        request.setAttribute("currentPageNumber", pageNumber);
        session.setAttribute("searchText", searchText);

        RequestDispatcher dispatcher = request.getRequestDispatcher("productList.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
    }
}
