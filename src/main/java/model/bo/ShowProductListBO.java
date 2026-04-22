package model.bo;

import java.util.ArrayList;

import model.bean.HangHoa;
import model.dao.ShowProductListDAO;

public class ShowProductListBO {

    ShowProductListDAO showProductListDAO = new ShowProductListDAO();

    public ArrayList<HangHoa> getDsHangHoa() {
        return showProductListDAO.getDsHangHoa();
    }

    public ArrayList<HangHoa> getDsHangHoa(int pageNumber) {
        return showProductListDAO.getDsHangHoa(pageNumber);
    }

    public int getTotalPageNumber() {
        return showProductListDAO.getTotalPageNumber();
    }

}
