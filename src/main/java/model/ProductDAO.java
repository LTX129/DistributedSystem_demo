package model;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class ProductDAO {

    // 获取所有产品
    public List<Product> getAllProducts() throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "SELECT products.*, products_img.image " +
                "FROM products " +
                "JOIN products_img ON products.id = products_img.id";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<Product> products = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getBigDecimal("price"));
            product.setStock(rs.getInt("stock"));
            product.setImage(rs.getBinaryStream("image"));
            products.add(product);
        }
        rs.close();
        stmt.close();
        conn.close();
        return products;
    }

    // 根据类别获取商品列表
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT p.*, pi.image " +
                "FROM products p " +
                "LEFT JOIN products_img pi ON p.id = pi.id " +
                "WHERE p.category = ?";

        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, category); // 使用精确匹配
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategory(rs.getString("category")); // 添加类别字段
                product.setImage(rs.getBinaryStream("image"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    // 根据产品 ID 获取商品详情
    public Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT p.*, pi.image " +
                "FROM products p " +
                "LEFT JOIN products_img pi ON p.id = pi.id " +
                "WHERE p.id = ?";

        try (Connection conn = DBConnection.initializeDatabase();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategory(rs.getString("category")); // 如果有类别字段
                product.setImage(rs.getBinaryStream("image"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return product;
    }
    public List<Product> searchProducts(String query) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ?";
        try (Connection connection = DBConnection.initializeDatabase();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchQuery = "%" + query + "%";
            statement.setString(1, searchQuery);
            statement.setString(2, searchQuery);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("id"));
                    product.setName(resultSet.getString("name"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getBigDecimal("price"));
                    product.setCategory(resultSet.getString("category"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (products.isEmpty()) {
            System.out.println("No products found for search query: " + query);
        }

        return products;
    }
}
