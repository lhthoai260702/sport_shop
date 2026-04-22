package model.dao;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.bean.HangHoa;

public class ShowProductListDAO extends BaseDAO {

    public ArrayList<HangHoa> getDsHangHoa() {
        ArrayList<HangHoa> dsHangHoa = new ArrayList<HangHoa>();
        String sql = "SELECT * FROM HangHoa";

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            HangHoa item = null;
            while (resultSet.next()) {
                item = new HangHoa();
                item.setMaHH(resultSet.getString("MaHH"));
                item.setTenHH(resultSet.getString("TenHH"));
                item.setDanhMuc(resultSet.getString("DanhMuc"));
                item.setGiaBan(resultSet.getDouble("GiaBan"));
                item.setSoLuongTon(resultSet.getInt("SoLuongTon"));
                item.setMoTa(resultSet.getString("MoTa"));
                dsHangHoa.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dsHangHoa;
    }

    public ArrayList<HangHoa> getDsHangHoa(int pageNumber) {
        ArrayList<HangHoa> tempList = new ArrayList<HangHoa>();
        ArrayList<HangHoa> returnedList = new ArrayList<HangHoa>();
        
        String sql = "SELECT maHH, tenHH, danhMuc, giaBan, soLuongTon, moTa FROM HangHoa ORDER BY maHH";

        int itemNumber = 0;

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery()) {
            HangHoa item = null;
            while (resultSet.next() && itemNumber < pageNumber * 20) {
                itemNumber++;
                item = new HangHoa();
                item.setMaHH(resultSet.getString("maHH"));
                item.setTenHH(resultSet.getString("tenHH"));
                item.setDanhMuc(resultSet.getString("danhMuc"));
                item.setGiaBan(resultSet.getDouble("giaBan"));
                item.setSoLuongTon(resultSet.getInt("soLuongTon"));
                item.setMoTa(resultSet.getString("moTa"));
                tempList.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int pageQuantity = (int)Math.ceil(tempList.size() / 20.0);
        if (pageNumber > pageQuantity || pageNumber < 1) {
            return returnedList;
        } else {
            for (int i = (pageNumber - 1) * 20; (i < pageNumber * 20) && (i < tempList.size()); i++) {
                returnedList.add(tempList.get(i));
            }
        }
        return returnedList;
    }

    public int getTotalPageNumber() {
        String sql = "SELECT count(mahh) as tongsodong FROM HangHoa";
        int totalPageNumber = 0;

        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                totalPageNumber = resultSet.getInt("tongsodong");
                return (int)Math.ceil(totalPageNumber / 20.0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
