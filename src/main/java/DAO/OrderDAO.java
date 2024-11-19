package DAO;

import model.Order;
import model.OrderItem;
import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) class for managing orders and their items.
 */
public class OrderDAO {

    /**
     * Saves the order and its associated items to the database.
     *
     * @param order the order to be saved
     * @throws SQLException if there is an issue saving the order or its items to the database
     */
    public void saveOrder(Order order) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBConnection.initializeDatabase();
            conn.setAutoCommit(false);

            // Insert order information
            String insertOrderSQL = "INSERT INTO orders (user_id, shipping_address, payment_method) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, order.getUserId());
            pstmt.setString(2, order.getShippingAddress());
            pstmt.setString(3, order.getPaymentMethod());
            pstmt.executeUpdate();

            generatedKeys = pstmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                order.setOrderId(orderId);

                // Insert order items
                String insertOrderItemSQL = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
                for (OrderItem item : order.getItems()) {
                    try (PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSQL)) {
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, item.getProduct().getId());
                        itemStmt.setInt(3, item.getQuantity());
                        itemStmt.executeUpdate();
                    }
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    /**
     * Retrieves all orders associated with a user ID from the database.
     *
     * @param userId the ID of the user whose orders are to be retrieved
     * @return a list of orders belonging to the specified user
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM orders WHERE user_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setShippingAddress(rs.getString("shipping_address"));
                order.setPaymentMethod(rs.getString("payment_method"));

                // Get order items
                order.setItems(getOrderItemsByOrderId(order.getOrderId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orders;
    }

    /**
     * Retrieves the items associated with a specific order ID from the database.
     *
     * @param orderId the ID of the order whose items are to be retrieved
     * @return a list of order items belonging to the specified order
     */
    private List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM order_items WHERE order_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));

                // Get product information
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductById(rs.getInt("product_id"));
                item.setProduct(product);
                item.setQuantity(rs.getInt("quantity"));

                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return items;
    }
}
