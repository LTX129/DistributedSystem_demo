package model;

import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // 保存订单及其订单项
    public void saveOrder(Order order) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBConnection.initializeDatabase();
            conn.setAutoCommit(false);

            // 插入订单信息
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

                // 插入订单项信息
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

    // 根据用户 ID 获取订单
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

                // 获取订单项
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

    // 获取订单项
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

                // 获取商品信息
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
