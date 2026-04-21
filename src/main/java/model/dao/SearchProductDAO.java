package model.dao;

import java.util.ArrayList;
import model.bean.HangHoa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import common.ValidateCommon;

public class SearchProductDAO extends BaseDAO {

    public ArrayList<HangHoa> getDsHangHoa(String searchText) {
        ArrayList<HangHoa> dsHangHoa = new ArrayList<HangHoa>();
        String sql = "SELECT * FROM HangHoa WHERE MaHH LIKE ? OR TenHH LIKE ? OR DanhMuc LIKE ? OR GiaBan = ? OR SoLuongTon LIKE ? OR MoTa LIKE ?";

        try (Connection connection = getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, "%" + searchText + "%");
            pstmt.setString(2, "%" + searchText + "%");
            pstmt.setString(3, "%" + searchText + "%");
            pstmt.setString(4, "%" + searchText + "%");
            if (ValidateCommon.isValidDigitString(searchText)) {
                pstmt.setDouble(5, Double.valueOf(searchText));
            } else {
                pstmt.setDouble(5, -1); // so am bat ky de khong match
            }
            pstmt.setString(6, "%" + searchText + "%");
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
