package controller;

import DAO.CartDAO;
import DAO.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import model.*;

import util.AsymmetricEncryptionUtil;

/**
 * Servlet handling user-related actions, including registration, login, password reset, and forgot password functionality.
 */
public class UserServlet extends HttpServlet {

    private static final Map<String, Integer> loginAttempts = new HashMap<>();
    private static final int MAX_ATTEMPTS = 5;

    /**
     * Handles HTTP POST requests for user actions such as registration, login, forgot password, and password reset.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("forgotPassword".equals(action)) {
            handleForgotPassword(request, response);
        }else if ("resetPassword".equals(action)) {
            handleResetPassword(request, response);
        }
    }

    /**
     * Handles user registration.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = null;
        try {
            password = AsymmetricEncryptionUtil.decrypt(request.getParameter("password"), AsymmetricEncryptionUtil.loadPrivateKey());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        String email = request.getParameter("email");
        String role = "customer"; // Default role is "customer"

        // Input length validation
        if (username.length() < 4 || username.length() > 20 || password.length() < 8 || email.length() > 50) {
            request.setAttribute("message", "Invalid input lengths. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Check if email is already registered
        try {
            User existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null) {
                request.setAttribute("message", "The email address is already registered. Please use another email.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error while checking email uniqueness. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setRole(role);

        try {
            userDAO.registerUser(newUser);
            response.sendRedirect("register_success.jsp"); // Redirect to register_success.jsp after successful registration
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Registration failed! Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles user login.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");

        // Limit login attempts
        Integer attempts = loginAttempts.getOrDefault(usernameOrEmail, 0);
        if (attempts >= MAX_ATTEMPTS) {
            request.setAttribute("message", "Too many failed login attempts. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.validateUser(usernameOrEmail, AsymmetricEncryptionUtil.decrypt(password, AsymmetricEncryptionUtil.loadPrivateKey()));

            if (user != null) {
                // Login successful, remove the attempt record
                loginAttempts.remove(usernameOrEmail);

                // Prevent session fixation attack: destroy old session and create a new one
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId()); // Save user ID
                session.setMaxInactiveInterval(30 * 60); // Set session timeout to 30 minutes

                // Load shopping cart from the database
                CartDAO cartDAO = new CartDAO();
                List<CartItem> cartItems = cartDAO.getCartItemsByUserId(user.getId());
                Cart cart = new Cart();
                for (CartItem item : cartItems) {
                    cart.addItem(item);
                }
                session.setAttribute("cart", cart);

                // Redirect based on user role
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp"); // Admin redirect to admin page
                } else {
                    response.sendRedirect("index.jsp"); // Regular user redirect to home page
                }
            } else {
                // Login failed, increment attempt counter
                loginAttempts.put(usernameOrEmail, attempts + 1);
                request.setAttribute("message", "Invalid username/email or password. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Login failed! Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles HTTP GET requests for user actions, such as displaying the registration page.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the forgot password action and sends a password reset link to the user's email.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);

            if (user != null) {
                // Generate and encrypt a reset token
                String resetToken = java.util.UUID.randomUUID().toString();
                String encryptedToken = resetToken;

                // Save the token or send an email
                sendResetLink(email, encryptedToken);
                request.setAttribute("message", "A reset link has been sent to your email address.");
            } else {
                request.setAttribute("message", "No account found with that email address.");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("forgot_password.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Failed to send reset link. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("forgot_password.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles password reset functionality.
     *
     * @param request the HttpServletRequest object
     * @param response the HttpServletResponse object
     * @throws ServletException if a servlet exception occurs
     * @throws IOException if an input/output exception occurs
     */
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String encryptedToken = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");

        try {
            String decryptedToken = encryptedToken;

            UserDAO userDAO = new UserDAO();
            userDAO.updatePasswordByEmail(email, AsymmetricEncryptionUtil.decrypt(newPassword, AsymmetricEncryptionUtil.loadPrivateKey()));
            request.setAttribute("message", "Password reset successful! Please login with your new password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Password reset failed. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("reset_password.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Sends a password reset link to the user's email.
     *
     * @param toEmail the recipient's email address
     * @param resetToken the reset token for password reset
     */
    private void sendResetLink(String toEmail, String resetToken) {
        String fromEmail = "no-reply@example.com";
        String host = "smtp.example.com";
        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("username", "password");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Password Reset Request");
            message.setText("To reset your password, click the following link: "
                    + "https://www.example.com/reset_password?token=" + resetToken);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
