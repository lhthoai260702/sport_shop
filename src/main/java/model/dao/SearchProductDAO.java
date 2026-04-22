package model.dao;

import java.util.ArrayList;
import model.bean.HangHoa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import common.ValidateCommon;

public class SearchProductDAO extends BaseDAO {

    public ArrayList<HangHoa> getDsHangHoa(String searchText) {
        ArrayList<HangHoa> dsHangHoa = new ArrayList<HangHoa>();
        String sql = "SELECT * FROM HangHoa WHERE MaHH LIKE ? OR TenHH LIKE ? OR DanhMuc LIKE ? OR MoTa LIKE ? OR GiaBan = ? OR SoLuongTon = ?";
        try (Connection connection = getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchText + "%");
            pstmt.setString(2, "%" + searchText + "%");
            pstmt.setString(3, "%" + searchText + "%");
            pstmt.setString(4, "%" + searchText + "%");
            if (ValidateCommon.isValidDigitString(searchText)) {
                pstmt.setDouble(5, Double.parseDouble(searchText));
                pstmt.setInt(6, Integer.parseInt(searchText));
            } else {
                pstmt.setDouble(5, -1);
                pstmt.setInt(6, -1);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                HangHoa hangHoa = null;
                while (rs.next()) {
                    hangHoa = new HangHoa();
                    hangHoa.setMaHH(rs.getString("MaHH"));
                    hangHoa.setTenHH(rs.getString("TenHH"));
                    hangHoa.setDanhMuc(rs.getString("DanhMuc"));
                    hangHoa.setGiaBan(rs.getDouble("GiaBan"));
                    hangHoa.setSoLuongTon(rs.getInt("SoLuongTon"));
                    hangHoa.setMoTa(rs.getString("MoTa"));
                    dsHangHoa.add(hangHoa);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dsHangHoa;
    }

}
