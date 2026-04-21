package model.bo;

import model.dao.CreateProductDAO;

public class CreateProductBO {

    CreateProductDAO createProductDAO = new CreateProductDAO();

    public String createProduct(String tenHH, String danhMuc, String giaBanStr,
            String soLuongTonStr, String moTa) {
        String resultMessage = null;

        // validate dữ liệu đầu vào
        if (tenHH == null || tenHH.trim().isEmpty()) {
            return "Product name cannot be empty";
        }
        if (danhMuc == null || danhMuc.trim().isEmpty()) {
            return "Category cannot be empty";
        }

        if (giaBanStr == null || giaBanStr.trim().isEmpty()) {
            return "Price cannot be empty";
        } else {
            try {
                double giaBan = Double.parseDouble(giaBanStr);
                if (giaBan < 0) {
                    return "Price cannot be negative";
                }
            } catch (NumberFormatException e) {
                return "Invalid price format";
            }
        }

        if (soLuongTonStr == null || soLuongTonStr.trim().isEmpty()) {
            return "Stock quantity cannot be empty";
        } else {
            int soLuongTon;
            try {
                soLuongTon = Integer.parseInt(soLuongTonStr);
                if (soLuongTon < 0) {
                    return "Stock quantity cannot be negative";
                }
            } catch (NumberFormatException e) {
                return "Invalid stock quantity format";
            }
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
