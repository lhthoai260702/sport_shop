package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDAO {
    private final String DB_URL = "jdbc:jtds:sqlserver://localhost:1433/QLShopTheThao;CharacterSet=UTF-8";
    private final String DB_USER = "sa";
    private final String DB_PASS = "YourStrong@Passw0rd";

    /**
     *
     * get connection to database
     *
     * @return Connection to database if connect No error
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("net.sourceforge.jtds.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            System.out.println("Connected!");
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        BaseDAO baseDAO = new BaseDAO();
        Connection connection = baseDAO.getConnection();
        if (connection != null) {
            System.out.println("Kết nối thành công!");
        } else {
            System.out.println("Kết nối thất bại!");
        }
    }
}