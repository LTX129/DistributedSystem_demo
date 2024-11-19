package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.ProductComment;
import DAO.ProductCommentDAO;
import DAO.ProductDAO;

/**
 * Servlet for handling product details and comments.
 * Retrieves product information and associated comments, and forwards them to the product details page.
 */
public class ProductServlet extends HttpServlet {

    /**
     * Handles GET requests to display the details of a specific product along with user comments.
     * Redirects to the homepage if the product ID is invalid or missing.
     *
     * @param request  the {@link HttpServletRequest} object containing the client's request
     * @param response the {@link HttpServletResponse} object containing the servlet's response
     * @throws ServletException if an error occurs during request dispatching
     * @throws IOException      if an input or output error is detected
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("id");
            if (productIdParam == null || productIdParam.isEmpty()) {
                // Redirect to the homepage if no product ID is provided
                response.sendRedirect("index.jsp");
                return;
            }

            int productId = Integer.parseInt(productIdParam);

            // Retrieve product details from the database
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                // Redirect to the homepage if the product does not exist
                response.sendRedirect("index.jsp");
                return;
            }

            // Retrieve comments associated with the product
            ProductCommentDAO commentDAO = new ProductCommentDAO();
            List<ProductComment> comments = commentDAO.getCommentsByProductId(productId);

            // Pass product details and comments to the JSP page
            request.setAttribute("product", product);
            request.setAttribute("comments", comments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("product.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            // Redirect to the homepage if the product ID is not a valid number
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            // Log the error and redirect to the homepage in case of an unexpected exception
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}
