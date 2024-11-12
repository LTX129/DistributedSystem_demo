package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Cart;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            // 如果购物车为空，重定向到购物车页面
            request.setAttribute("message", "Your cart is empty. Please add items to your cart before checking out.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 获取用户提交的订单信息
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

        // 模拟结账过程，例如清空购物车和显示成功页面
        session.removeAttribute("cart");  // 清空购物车

        // 设置结账成功的消息
        request.setAttribute("message", "Checkout successful! Thank you for your purchase.");
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("paymentMethod", paymentMethod);

        // 重定向到结账成功页面
        RequestDispatcher dispatcher = request.getRequestDispatcher("checkout_success.jsp");
        dispatcher.forward(request, response);
    }
}
