package controller;

import jakarta.jws.WebMethod;
import jakarta.jws.WebService;
import model.User;
import DAO.UserDAO;
import jakarta.servlet.http.*;

/**
 * SOAP Web Service for user-related actions such as user registration and validation.
 */
@WebService(serviceName = "UserSOAPService")
public class UserSOAPService extends HttpServlet {

    /**
     * Registers a new user.
     *
     * @param username the username of the user to be registered
     * @param password the password of the user to be registered
     * @param email the email of the user to be registered
     * @param role the role of the user (e.g., "admin", "customer")
     * @return a message indicating the result of the registration attempt
     */
    @WebMethod
    public String registerUser(String username, String password, String email, String role) {
        try {
            UserDAO userDAO = new UserDAO();
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setEmail(email);
            newUser.setRole(role);

            userDAO.registerUser(newUser);
            return "User registered successfully";
        } catch (Exception e) {
            e.printStackTrace();
            return "Registration failed: " + e.getMessage();
        }
    }

    /**
     * Validates a user's login credentials.
     *
     * @param usernameOrEmail the username or email of the user to be validated
     * @param password the password of the user to be validated
     * @return true if the user credentials are valid, false otherwise
     */
    @WebMethod
    public boolean validateUser(String usernameOrEmail, String password) {
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.validateUser(usernameOrEmail, password);
            return user != null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
