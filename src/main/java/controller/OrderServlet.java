package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Order;
import DAO.OrderDAO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for managing user orders.
 * Handles retrieving and displaying all orders for a logged-in user.
 */
public class OrderServlet extends HttpServlet {

    /**
     * Handles GET requests to retrieve and display all orders for the currently logged-in user.
     * If the user is not logged in, they are redirected to the login page.
     *
     * @param request  the {@link HttpServletRequest} object containing the client's request
     * @param response the {@link HttpServletResponse} object containing the servlet's response
     * @throws ServletException if an error occurs during request dispatching
     * @throws IOException      if an input or output error is detected
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // 获取现有会话

        Integer userId = (Integer) session.getAttribute("userId");
        if (session == null || session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve the user's orders from the database
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId(userId);

        // Pass the order data to the JSP page
        request.setAttribute("orders", orders);
        RequestDispatcher dispatcher = request.getRequestDispatcher("all_orders.jsp");
        dispatcher.forward(request, response);
    }
}
