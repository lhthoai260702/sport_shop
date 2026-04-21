package model.bo;

import model.dao.CreateProductDAO;
import common.ValidateCommon;

public class CreateProductBO {

    CreateProductDAO createProductDAO = new CreateProductDAO();

    public String createProduct(String tenHH, String danhMuc, String giaBanStr,
            String soLuongTonStr, String moTa) {
        String resultMessage = null;

        // validate dữ liệu đầu vào
        String tempValidate = ValidateCommon.validateProduct(tenHH, danhMuc, giaBanStr, soLuongTonStr);
        if (!"No error".equals(tempValidate)) {
            return tempValidate;
        }

        for (int i = 0; i < 10; i++) {

            String returnedMessage = createProductDAO.createProduct(tenHH, danhMuc,
                    giaBanStr, soLuongTonStr, moTa);
            if ("Duplicate ID Error".equals(returnedMessage)) {
                resultMessage = "Duplicate ID Error";
                continue;
            } else if ("No error".equals(returnedMessage)) {
                resultMessage = "No error";
                break;
            } else {
                resultMessage = "error";
                break;
            }
        }
        return resultMessage;
    }

}
