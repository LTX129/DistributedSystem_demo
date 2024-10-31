package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import model.User;
import model.UserDAO;

public class UserServlet extends HttpServlet {

    private static final Map<String, Integer> loginAttempts = new HashMap<>();
    private static final int MAX_ATTEMPTS = 5;

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

    // 处理用户注册
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = "customer"; // 默认角色为普通用户

        // 输入长度校验
        if (username.length() < 4 || username.length() > 20 || password.length() < 8 || email.length() > 50) {
            request.setAttribute("message", "Invalid input lengths. Please try again.");
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
            UserDAO userDAO = new UserDAO();
            userDAO.registerUser(newUser);
            response.sendRedirect("register_success.jsp"); // 注册成功后跳转到 register_success.jsp
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Registration failed! Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        }
    }

    // 处理用户登录
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");

        // 限制登录尝试次数
        Integer attempts = loginAttempts.getOrDefault(usernameOrEmail, 0);
        if (attempts >= MAX_ATTEMPTS) {
            request.setAttribute("message", "Too many failed login attempts. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.validateUser(usernameOrEmail, password);

            if (user != null) {
                // 登录成功，移除记录
                loginAttempts.remove(usernameOrEmail);

                // 防止会话固定攻击：销毁旧会话并创建新会话
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                session = request.getSession(true);
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60); // 设置会话超时时间为 30 分钟

                // 登录成功后重定向到主页或管理员页面
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp"); // 管理员跳转到管理员页面
                } else {
                    response.sendRedirect("index.jsp"); // 普通用户跳转到主页
                }
            } else {
                // 登录失败，增加尝试次数
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }

    // 处理忘记密码请求
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);

            if (user != null) {
                // 发送重置链接到用户的电子邮件
                sendResetLink(email);
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

    // 处理密码重置
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Passwords do not match. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("reset_password.jsp?email=" + email);
            dispatcher.forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.updatePasswordByEmail(email, newPassword);
            request.setAttribute("message", "Password reset successful! Please login with your new password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Failed to reset password. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("reset_password.jsp?email=" + email);
            dispatcher.forward(request, response);
        }
    }

    // 示例发送重置链接的方法
    private void sendResetLink(String email) {
        // 配置邮件服务器属性
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.qq.com"); // SMTP 服务器地址
        props.put("mail.smtp.port", "587"); // SMTP 端口号
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // 身份验证
        final String username = "3028053662@qq.com";
        final String password = "sbvijzgjovaldghe";

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // 创建邮件消息
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("3028053662@qq.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Password Reset Request");
            message.setText("Please click the link below to reset your password:\n\n"
                    + "http://localhost:8080/demo_war/reset_password.jsp?email=" + email);

            // 发送邮件
            Transport.send(message);

            System.out.println("Reset link sent successfully.");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

}
