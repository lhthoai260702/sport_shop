package model.bo;

import java.util.ArrayList;

import model.bean.HangHoa;
import model.dao.SearchProductDAO;

public class SearchProductBO {

    SearchProductDAO searchProductDAO = new SearchProductDAO();

    public ArrayList<HangHoa> getDsHangHoa(String searchText) {
        return searchProductDAO.getDsHangHoa(searchText);
    }

}
