package DAO;

import model.CartItem;
import model.Product;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class for interacting with the cart items in the database.
 */
public class CartDAO {

    /**
     * Adds a cart item for a user or updates the quantity if the product already exists in the cart.
     *
     * @param userId the ID of the user who is adding the cart item
     * @param productId the ID of the product being added to the cart
     * @param quantity the quantity of the product being added to the cart
     */
    public void addCartItem(int userId, int productId, int quantity) {
        String query = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves the list of cart items for a specific user.
     *
     * @param userId the ID of the user whose cart items are to be fetched
     * @return a list of {@link CartItem} objects representing the user's cart items
     */
    public List<CartItem> getCartItemsByUserId(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT * FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            ProductDAO productDAO = new ProductDAO();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                Product product = productDAO.getProductById(productId);
                int quantity = rs.getInt("quantity");
                CartItem cartItem = new CartItem(product, quantity);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    /**
     * Clears all the cart items for a specific user.
     *
     * @param userId the ID of the user whose cart is to be cleared
     */
    public void clearCart(int userId) {
        String query = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
