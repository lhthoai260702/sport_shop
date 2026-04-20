package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CheckLoginDAO extends BaseDAO {

    public int getAccountRole(String tenDangNhap, String matKhau) {
        int role = 0; // Mặc định là tài khoản không hợp lệ
        String sql = "SELECT VaiTro FROM NhanVien WHERE TenDangNhap = ? AND MatKhau = ?";
        
        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, tenDangNhap);
            preparedStatement.setString(2, matKhau);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String vaiTro = resultSet.getString("VaiTro");
                    if ("admin".equalsIgnoreCase(vaiTro)) {
                        role = 1; // Admin
                    } else {
                        role = 2; // User
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }

}
