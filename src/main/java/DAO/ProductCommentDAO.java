package DAO;

import model.ProductComment;
import util.DBConnection;

import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class for managing product comments in the database.
 */
public class ProductCommentDAO {

    /**
     * Saves a product comment to the database.
     *
     * @param comment the product comment to be saved
     * @throws SQLException if there is an issue saving the comment to the database
     */
    public void saveComment(ProductComment comment) throws SQLException {
        String sql = "INSERT INTO product_comments (product_id, user_id, comment, rating) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, comment.getProductId());
            pstmt.setInt(2, comment.getUserId());
            pstmt.setString(3, comment.getComment());
            pstmt.setInt(4, comment.getRating());
            pstmt.executeUpdate();
        }
    }

    /**
     * Retrieves all comments for a specific product from the database.
     *
     * @param productId the ID of the product whose comments are to be retrieved
     * @return a list of comments associated with the specified product
     */
    public List<ProductComment> getCommentsByProductId(int productId) {
        List<ProductComment> comments = new ArrayList<>();
        String sql = "SELECT * FROM product_comments WHERE product_id = ?";
        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductComment comment = new ProductComment();
                comment.setId(rs.getInt("id"));
                comment.setProductId(rs.getInt("product_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setComment(rs.getString("comment"));
                comment.setRating(rs.getInt("rating"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
