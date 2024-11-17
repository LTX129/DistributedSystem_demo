package controller;

import jakarta.jws.WebMethod;
import jakarta.jws.WebService;
import model.User;
import DAO.UserDAO;
import jakarta.servlet.http.*;

@WebService(serviceName = "UserSOAPService")
public class UserSOAPService extends HttpServlet {

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
