package common;

public class ValidateCommon {
    public static String validateProduct(String tenHH, String danhMuc, String giaBanStr, String soLuongTonStr) {
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

        return "No error";
    }
}
