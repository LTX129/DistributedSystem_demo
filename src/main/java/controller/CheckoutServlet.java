package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

import model.Cart;
import model.CartItem;
import model.Order;
import DAO.OrderDAO;
import model.OrderItem;

/**
 * Servlet implementation for handling the checkout process.
 * Processes user orders, validates input, and manages order persistence.
 */
public class CheckoutServlet extends HttpServlet {

    /**
     * Handles POST requests for the checkout process.
     * Validates the cart, collects user input for shipping and payment, creates an order,
     * and redirects the user to the appropriate page based on the outcome.
     *
     * @param request  the {@link HttpServletRequest} object containing the client's request
     * @param response the {@link HttpServletResponse} object containing the servlet's response
     * @throws ServletException if an error occurs during request processing
     * @throws IOException      if an input or output error is detected
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("message", "Your cart is empty. Please add items to your cart before checking out.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
            dispatcher.forward(request, response);
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            request.setAttribute("message", "Please provide a shipping address.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("order_confirmation.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            request.setAttribute("message", "Please select a payment method.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("order_confirmation.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setItems(new ArrayList<>());

        for (CartItem cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            order.getItems().add(orderItem);
        }

        try {
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.saveOrder(order);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Failed to place order. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("order_confirmation.jsp");
            dispatcher.forward(request, response);
            return;
        }

        session.removeAttribute("cart");

        request.setAttribute("message", "Checkout successful! Thank you for your purchase.");
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("paymentMethod", paymentMethod);

        RequestDispatcher dispatcher = request.getRequestDispatcher("checkout_success.jsp");
        dispatcher.forward(request, response);
    }
}
