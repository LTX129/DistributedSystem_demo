package DAO;
import model.User;
import util.CacheUtility;
import util.DBConnection;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // 注册新用户，添加加密后的敏感信息
    public void registerUser(User user) throws Exception {
        // 在注册用户前，确保密钥已存在
        //ensureKeyPairGenerated();

        Connection conn = DBConnection.initializeDatabase();
        String query = "INSERT INTO users (username, password, email, role, encrypted_data) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);

        // 使用公钥加密敏感数据
        //PublicKey publicKey = AsymmetricEncryptionUtil.loadPublicKey();
        String sensitiveData = "Sensitive data like payment details"; // 示例敏感数据
        //String encryptedData = AsymmetricEncryptionUtil.encrypt(sensitiveData, publicKey);

        pstmt.setString(1, user.getUsername());
        pstmt.setString(2, passwordEncoder.encode(user.getPassword()));  // 加密密码
        pstmt.setString(3, user.getEmail());
        pstmt.setString(4, user.getRole());
        pstmt.setString(5, sensitiveData);  // 存储加密后的敏感数据
        pstmt.executeUpdate();

        // 注册成功后清除相关缓存
        CacheUtility.remove("user_" + user.getUsername());
        pstmt.close();
        conn.close();
    }
    /*
    private void ensureKeyPairGenerated() throws Exception {
        // 先尝试加载公钥，如果公钥不存在，则生成并存储密钥对
        try {
            AsymmetricEncryptionUtil.loadPublicKey();
        } catch (Exception e) {
            System.out.println("Public key not found, generating a new key pair.");
            AsymmetricEncryptionUtil.generateAndStoreKeyPair();
        }
    }

     */

    // 获取用户信息通过用户名，并解密敏感数据
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
                user.setPassword(rs.getString("password"));

                // 解密敏感数据
                String encryptedData = rs.getString("encrypted_data");
                if (encryptedData != null) {
                    //PrivateKey privateKey = AsymmetricEncryptionUtil.loadPrivateKey();
                    //String decryptedData = AsymmetricEncryptionUtil.decrypt(encryptedData, privateKey);
                    System.out.println("Decrypted sensitive data: " + encryptedData); // 示例打印解密后的数据
                }

                // 将用户信息存入缓存
                CacheUtility.put(cacheKey, user);
            }

            rs.close();
            pstmt.close();
            conn.close();
        }

        return user;
    }
    // 获取用户信息通过邮箱
    public User getUserByEmail(String email) throws Exception {
        String cacheKey = "user_email_" + email;
        User user = (User) CacheUtility.get(cacheKey);

        if (user == null) {
            Connection conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));

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
                    user.setPassword(rs.getString("password"));

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
            user.setPassword(rs.getString("password"));
            users.add(user);
        }

        rs.close();
        stmt.close();
        conn.close();
        return users;
    }

    // 根据邮箱更新用户密码
    public void updatePasswordByEmail(String email, String newPassword) throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "UPDATE users SET password = ? WHERE email = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, passwordEncoder.encode(newPassword));  // 加密新密码
        pstmt.setString(2, email);
        pstmt.executeUpdate();
        // 更新成功后清除相关缓存
        CacheUtility.remove("user_" + email);
        pstmt.close();
        conn.close();
    }
}
