package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteProductDAO extends BaseDAO {

    public Object deleteProduct(String proId) {
        String sql = "DELETE FROM HANGHOA WHERE MaHH = ?";
        try (Connection connection = getConnection();
                PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, proId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
