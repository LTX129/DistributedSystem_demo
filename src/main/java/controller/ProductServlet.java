package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.ProductDAO;

public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
            RequestDispatcher dispatcher = request.getRequestDispatcher("product.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
