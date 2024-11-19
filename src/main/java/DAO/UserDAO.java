package DAO;

import model.User;
import util.CacheUtility;
import util.DBConnection;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for managing user operations such as registration, login validation, and retrieving user information.
 */
public class UserDAO {
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /**
     * Registers a new user by encrypting the password and storing the sensitive data in the database.
     *
     * @param user The user object containing the registration details.
     * @throws Exception If any error occurs during the database operation.
     */
    public void registerUser(User user) throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "INSERT INTO users (username, password, email, role, encrypted_data) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);

        String sensitiveData = "Sensitive data like payment details"; // Example sensitive data

        pstmt.setString(1, user.getUsername());
        pstmt.setString(2, passwordEncoder.encode(user.getPassword()));  // Encrypt password
        pstmt.setString(3, user.getEmail());
        pstmt.setString(4, user.getRole());
        pstmt.setString(5, sensitiveData);  // Store encrypted sensitive data
        pstmt.executeUpdate();

        CacheUtility.remove("user_" + user.getUsername());
        pstmt.close();
        conn.close();
    }

    /**
     * Retrieves user information from the database by username, and caches the result.
     *
     * @param username The username of the user to retrieve.
     * @return The user object with the retrieved details.
     * @throws Exception If any error occurs during the database operation.
     */
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

                String encryptedData = rs.getString("encrypted_data");
                if (encryptedData != null) {
                    System.out.println("Decrypted sensitive data: " + encryptedData);
                }

                CacheUtility.put(cacheKey, user);
            }

            rs.close();
            pstmt.close();
            conn.close();
        }

        return user;
    }

    /**
     * Retrieves user information from the database by email, and caches the result.
     *
     * @param email The email of the user to retrieve.
     * @return The user object with the retrieved details.
     * @throws Exception If any error occurs during the database operation.
     */
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

                CacheUtility.put(cacheKey, user);
            }

            rs.close();
            pstmt.close();
            conn.close();
        }

        return user;
    }

    /**
     * Validates the user's login credentials by checking the username/email and password.
     *
     * @param usernameOrEmail The username or email of the user to validate.
     * @param password The password to validate.
     * @return The user object if the credentials are valid, otherwise null.
     * @throws Exception If any error occurs during the database operation.
     */
    public User validateUser(String usernameOrEmail, String password) throws Exception {
        String cacheKey = "user_" + usernameOrEmail;
        User user = (User) CacheUtility.get(cacheKey);

        if (user == null) {
            Connection conn = DBConnection.initializeDatabase();
            String query = "SELECT * FROM users WHERE username = ? OR email = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, usernameOrEmail);
            pstmt.setString(2, usernameOrEmail);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                if (passwordEncoder.matches(password, rs.getString("password"))) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(rs.getString("password"));

                    CacheUtility.put(cacheKey, user);
                }
            }

            rs.close();
            pstmt.close();
            conn.close();
        } else {
            if (!passwordEncoder.matches(password, user.getPassword())) {
                return null;
            }
        }

        return user;
    }

    /**
     * Retrieves all users from the database (admin functionality).
     *
     * @return A list of all users.
     * @throws Exception If any error occurs during the database operation.
     */
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

    /**
     * Updates the password for a user based on their email address.
     *
     * @param email The email of the user whose password is to be updated.
     * @param newPassword The new password to set.
     * @throws Exception If any error occurs during the database operation.
     */
    public void updatePasswordByEmail(String email, String newPassword) throws Exception {
        Connection conn = DBConnection.initializeDatabase();
        String query = "UPDATE users SET password = ? WHERE email = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, passwordEncoder.encode(newPassword));  // Encrypt new password
        pstmt.setString(2, email);
        pstmt.executeUpdate();
        CacheUtility.remove("user_" + email);
        pstmt.close();
        conn.close();
    }
}
