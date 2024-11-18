package DAO;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ImgDAO {
    public byte[] getLogoById(int id) {
        String query = "SELECT ico_img FROM webpage_ico WHERE ico_id = ?";
        byte[] imageBytes = null;

        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                imageBytes = rs.getBytes("ico_img"); // 从数据库获取 BLOB 数据
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageBytes;
    }
}
