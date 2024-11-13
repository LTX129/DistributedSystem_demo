package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Order;
import model.OrderDAO;

import java.io.IOException;
import java.util.List;

public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // 获取现有会话
        // 检查用户是否已经登录
        Integer userId = (Integer) session.getAttribute("userId");
        if (session == null || session.getAttribute("userId") == null) {
            // 用户未登录，重定向到登录页面
            response.sendRedirect("login.jsp");
            return;
        }


        // 从数据库获取订单数据
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId(userId);

        // 将订单数据传递给 JSP 页面
        request.setAttribute("orders", orders);
        RequestDispatcher dispatcher = request.getRequestDispatcher("all_orders.jsp");
        dispatcher.forward(request, response);
    }
}
