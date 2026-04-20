package model.bo;

import java.util.ArrayList;

import model.bean.HangHoa;
import model.dao.ShowProductListDAO;

public class ShowProductListBO {

    ShowProductListDAO showProductListDAO = new ShowProductListDAO();

    public ArrayList<HangHoa> getDsHangHoa() {
        return showProductListDAO.getDsHangHoa();
    }

}
