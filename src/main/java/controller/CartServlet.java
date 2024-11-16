package controller;

import model.CartDAO;
import model.Cart;
import model.CartItem;
import model.Product;
import model.ProductDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null) {
                cart.removeItem(productId);
                session.setAttribute("cart", cart);
                cartDAO.clearCart(userId);
                for (CartItem item : cart.getItems()) {
                    cartDAO.addCartItem(userId, item.getProduct().getId(), item.getQuantity());
                }
            }

            // 重定向回购物车页面
            response.sendRedirect("cart.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "This method is not supported for the requested action.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        int userId = (int) session.getAttribute("userId");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                CartItem item = new CartItem(product, quantity);
                cart.addItem(item);
                cartDAO.addCartItem(userId, productId, quantity);
            }
        } else if ("update".equals(action)) {
            for (CartItem item : cart.getItems()) {
                int newQuantity = Integer.parseInt(request.getParameter("quantity_" + item.getProduct().getId()));
                item.setQuantity(newQuantity);
            }
            cartDAO.clearCart(userId);
            for (CartItem item : cart.getItems()) {
                cartDAO.addCartItem(userId, item.getProduct().getId(), item.getQuantity());
            }
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeItem(productId);
            cartDAO.clearCart(userId);
            for (CartItem item : cart.getItems()) {
                cartDAO.addCartItem(userId, item.getProduct().getId(), item.getQuantity());
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }
}
