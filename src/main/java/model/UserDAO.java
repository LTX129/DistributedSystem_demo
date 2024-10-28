package model;
import util.CacheUtility;
import util.DBConnection;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class UserDAO {
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // 注册新用户
    public void registerUser(User user) throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, user.getUsername());
        pstmt.setString(2, passwordEncoder.encode(user.getPassword()));  // 加密密码
        pstmt.setString(3, user.getEmail());
        pstmt.setString(4, user.getRole());
        pstmt.executeUpdate();
        // 注册成功后清除相关缓存
        CacheUtility.remove("user_" + user.getUsername());
        pstmt.close();
        conn.close();
    }

    // 获取用户信息通过用户名
    public User getUserByUsername(String username) throws Exception {
        String cacheKey = "user_" + username;
        User user = (User) CacheUtility.get(cacheKey);

        if (user == null) {
            Connection conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM users WHERE username = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                // 将用户信息存入缓存
                CacheUtility.put(cacheKey, user);
            }

            rs.close();
            pstmt.close();
            conn.close();
        }

        return user;
    }

    // 验证用户登录
    public User validateUser(String usernameOrEmail, String password) throws Exception {
        String cacheKey = "user_" + usernameOrEmail;
        User user = (User) CacheUtility.get(cacheKey);

        if (user == null) {
            // 缓存中没有用户信息，从数据库中获取
            Connection conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM users WHERE username = ? OR email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, usernameOrEmail);
            pstmt.setString(2, usernameOrEmail);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                if (passwordEncoder.matches(password, rs.getString("password"))) {  // 验证密码
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));

                    // 将用户信息存入缓存
                    CacheUtility.put(cacheKey, user);
                }
            }

            rs.close();
            pstmt.close();
            conn.close();
        } else {
            // 验证缓存中的用户密码
            if (!passwordEncoder.matches(password, user.getPassword())) {
                return null;
            }
        }

        return user;
    }
    // 获取所有用户 (管理员功能)
    public List<User> getAllUsers() throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "SELECT * FROM users";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<User> users = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            users.add(user);
        }

        rs.close();
        stmt.close();
        conn.close();
        return users;
    }
}
