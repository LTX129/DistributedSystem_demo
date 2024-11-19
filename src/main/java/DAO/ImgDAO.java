package DAO;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object (DAO) class for interacting with the images stored in the database.
 */
public class ImgDAO {

    /**
     * Retrieves the logo image (as a byte array) from the database by its ID.
     *
     * @param id the ID of the logo image to be fetched
     * @return a byte array containing the image data, or null if the image is not found
     */
    public byte[] getLogoById(int id) {
        String query = "SELECT ico_img FROM webpage_ico WHERE ico_id = ?";
        byte[] imageBytes = null;

        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                imageBytes = rs.getBytes("ico_img"); // Retrieves the BLOB data from the database
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageBytes;
    }
}
