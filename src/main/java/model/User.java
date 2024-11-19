package model;

/**
 * Represents a user with attributes such as username, password, email, and role.
 * The role can either be 'customer' or 'admin'.
 */
public class User {
    private int id;
    private String username;
    private String password;
    private String email;
    private String role;  // 'customer' or 'admin'

    /**
     * Retrieves the user ID.
     *
     * @return The ID of the user.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the user ID.
     *
     * @param id The ID to set for the user.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Retrieves the username of the user.
     *
     * @return The username of the user.
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the username of the user.
     *
     * @param username The username to set for the user.
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Retrieves the password of the user.
     *
     * @return The password of the user.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the password of the user.
     *
     * @param password The password to set for the user.
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Retrieves the email address of the user.
     *
     * @return The email address of the user.
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the email address of the user.
     *
     * @param email The email address to set for the user.
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Retrieves the role of the user.
     *
     * @return The role of the user ('customer' or 'admin').
     */
    public String getRole() {
        return role;
    }

    /**
     * Sets the role of the user.
     *
     * @param role The role to set for the user ('customer' or 'admin').
     */
    public void setRole(String role) {
        this.role = role;
    }
}
