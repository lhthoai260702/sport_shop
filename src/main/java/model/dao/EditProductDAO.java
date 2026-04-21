package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.bean.HangHoa;

public class EditProductDAO extends BaseDAO {

    public HangHoa getProductById(String proId) {
        String sql = "SELECT * FROM HANGHOA WHERE MaHH = ?";
        HangHoa hangHoa = new HangHoa();
        try (Connection connection = getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql);) {
            pstmt.setString(1, proId);
            try (ResultSet rs = pstmt.executeQuery();) {
                if (rs.next()) {
                    hangHoa.setMaHH(rs.getString("MaHH"));
                    hangHoa.setTenHH(rs.getString("TenHH"));
                    hangHoa.setDanhMuc(rs.getString("DanhMuc"));
                    hangHoa.setGiaBan(rs.getDouble("GiaBan"));
                    hangHoa.setSoLuongTon(rs.getInt("SoLuongTon"));
                    hangHoa.setMoTa(rs.getString("MoTa"));
                    return hangHoa;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String editProduct(String maHH, String tenHH, String danhMuc, String giaBanStr, String soLuongTonStr,
            String moTa) {

        String sql = "UPDATE HANGHOA SET TenHH = ?, DanhMuc = ?, GiaBan = ?, SoLuongTon = ?, MoTa = ? WHERE MaHH = ?";
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, tenHH);
            preparedStatement.setString(2, danhMuc);
            preparedStatement.setDouble(3, Double.parseDouble(giaBanStr));
            preparedStatement.setInt(4, Integer.parseInt(soLuongTonStr));
            preparedStatement.setString(5, moTa);
            preparedStatement.setString(6, maHH);
            int x = preparedStatement.executeUpdate();
            System.out.println("Số dòng được thêm vào: " + x);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "No error";
    }
}
