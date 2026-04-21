package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CreateProductDAO extends BaseDAO {

    public String createProduct(String tenHH, String danhMuc, String giaBanStr, String soLuongTonStr, String moTa) {

        String sql = "INSERT INTO HangHoa (tenHH, danhMuc, giaBan, soLuongTon, moTa) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            double giaBan = Double.parseDouble(giaBanStr);
            int soLuongTon = Integer.parseInt(soLuongTonStr);

            preparedStatement.setString(1, tenHH);
            preparedStatement.setString(2, danhMuc);
            preparedStatement.setDouble(3, giaBan);
            preparedStatement.setInt(4, soLuongTon);
            preparedStatement.setString(5, moTa);
            int x = preparedStatement.executeUpdate();
            System.out.println("Số dòng được thêm vào: " + x);
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage();
            if (errorMessage != null && errorMessage.contains("duplicate key value")) {
                return "Duplicate ID Error";
            }
        }
        return "No error";
    }
}
