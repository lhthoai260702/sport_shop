package model.bo;

import model.bean.HangHoa;
import model.dao.EditProductDAO;
import common.ValidateCommon;

public class EditProductBO {

    EditProductDAO editProductDAO = new EditProductDAO();

    public HangHoa getProductById(String proId) {
        return editProductDAO.getProductById(proId);
    }

    public String editProduct(String maHH, String tenHH, String danhMuc, String giaBanStr, String soLuongTonStr,
            String moTa) {
        String returnedString = null;

        String tempValidate = ValidateCommon.validateProduct(tenHH, danhMuc, giaBanStr, soLuongTonStr);
        if (!"No error".equals(tempValidate)) {
            return tempValidate;
        }

        returnedString = editProductDAO.editProduct(maHH, tenHH, danhMuc, giaBanStr, soLuongTonStr, moTa);
        return returnedString;
    }

}
