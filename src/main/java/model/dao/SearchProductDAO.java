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

    public ArrayList<HangHoa> getDsHangHoa(String searchText, int pageNumber) {
        String sql = "SELECT * FROM ( " +
                "SELECT ROW_NUMBER() OVER (ORDER BY mahh) AS RowNum, * " +
                "FROM HangHoa " +
                "WHERE MaHH LIKE ? OR TenHH LIKE ? OR DanhMuc LIKE ? OR MoTa LIKE ? OR GiaBan = ? OR SoLuongTon = ? " +
                ") AS tempTable " +
                "WHERE RowNum > (? * (? - 1)) " +
                "AND RowNum <= (? * (? - 1)) + ? " +
                "ORDER BY mahh";

        ArrayList<HangHoa> dsHangHoa = new ArrayList<>();
        int pageSize = 20; // số bản ghi mỗi trang

        try (Connection connection = getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql)) {

            // search
            pstmt.setString(1, "%" + searchText + "%");
            pstmt.setString(2, "%" + searchText + "%");
            pstmt.setString(3, "%" + searchText + "%");
            pstmt.setString(4, "%" + searchText + "%");

            // số
            if (ValidateCommon.isValidDigitString(searchText)) {
                pstmt.setDouble(5, Double.parseDouble(searchText));
                pstmt.setInt(6, Integer.parseInt(searchText));
            } else {
                pstmt.setDouble(5, -1);
                pstmt.setInt(6, -1);
            }

            // pagination (QUAN TRỌNG)
            pstmt.setInt(7, pageSize);
            pstmt.setInt(8, pageNumber);
            pstmt.setInt(9, pageSize);
            pstmt.setInt(10, pageNumber);
            pstmt.setInt(11, pageSize);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    HangHoa item = new HangHoa();
                    item.setMaHH(rs.getString("mahh"));
                    item.setTenHH(rs.getString("tenhh"));
                    item.setDanhMuc(rs.getString("danhmuc"));
                    item.setGiaBan(rs.getDouble("giaban"));
                    item.setSoLuongTon(rs.getInt("soluongton"));
                    item.setMoTa(rs.getString("mota"));

                    dsHangHoa.add(item);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dsHangHoa;
    }

    public int getTotalPageNumber(String searchText) {
        String sql = "SELECT count(tenhh) as tongsodong FROM HangHoa WHERE MaHH LIKE ? OR TenHH LIKE ? OR danhmuc LIKE ? OR MoTa LIKE ? OR GiaBan = ? OR SoLuongTon = ?";
        int totalPageNumber = 0;
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
                if (rs.next()) {
                    totalPageNumber = rs.getInt("tongsodong");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return (int) Math.ceil(totalPageNumber / 20.0);
    }

}
