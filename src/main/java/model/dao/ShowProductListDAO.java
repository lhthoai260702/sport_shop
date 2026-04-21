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

    public static void main(String[] args) {
        ShowProductListDAO dao = new ShowProductListDAO();
        ArrayList<HangHoa> list = dao.getDsHangHoa();
        for (HangHoa hh : list) {
            System.out.println(hh.getMaHH() + " - " + hh.getTenHH() + " - " + hh.getGiaBan());
        }
    }

}
