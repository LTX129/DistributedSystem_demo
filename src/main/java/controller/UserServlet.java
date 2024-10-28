package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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
}
