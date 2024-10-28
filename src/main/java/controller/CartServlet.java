package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

import model.Product;
import model.CartItem;
import model.Cart;
import model.ProductDAO;

public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // 获取请求中的操作类型
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // 获取添加的商品信息
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // 从数据库获取商品信息
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                CartItem item = new CartItem(product, quantity);
                cart.addItem(item);
            }
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeItem(productId);
        } else if ("update".equals(action)) {
            for (CartItem item : cart.getItems()) {
                int newQuantity = Integer.parseInt(request.getParameter("quantity_" + item.getProduct().getId()));
                item.setQuantity(newQuantity);
            }
        }

        // 将购物车存回 session
        session.setAttribute("cart", cart);

        // 重定向回购物车页面
        response.sendRedirect("cart.jsp");
    }

    // 模拟从数据库中获取商品
    private Product getProductFromDatabase(int productId) {
        // 这里模拟获取商品，可以替换为实际的数据库操作
        Product product = new Product();
        product.setId(productId);
        product.setName("Sample Product");
        product.setPrice(new BigDecimal("19.99"));
        return product;
    }
}
