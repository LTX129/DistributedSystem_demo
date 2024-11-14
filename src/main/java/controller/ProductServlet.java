package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.ProductComment;
import model.ProductCommentDAO;
import model.ProductDAO;

public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("id");
            if (productIdParam == null || productIdParam.isEmpty()) {
                response.sendRedirect("index.jsp");
                return;
            }

            int productId = Integer.parseInt(productIdParam);

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            ProductCommentDAO commentDAO = new ProductCommentDAO();
            List<ProductComment> comments = commentDAO.getCommentsByProductId(productId);

            request.setAttribute("product", product);
            request.setAttribute("comments", comments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("product.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}
