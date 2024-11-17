package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.ProductComment;
import DAO.ProductCommentDAO;

import java.io.IOException;
import java.sql.SQLException;

public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        request.setAttribute("productId", productId);
        request.setAttribute("userId", userId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("comment.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdStr = request.getParameter("productId");
            String userIdStr = request.getParameter("userId");

            if (productIdStr == null || userIdStr == null) {
                throw new IllegalArgumentException("Product ID or User ID is missing.");
            }

            int productId = Integer.parseInt(productIdStr);
            int userId = Integer.parseInt(userIdStr);
            String comment = request.getParameter("comment");
            int rating = Integer.parseInt(request.getParameter("rating"));

            ProductComment productComment = new ProductComment();
            productComment.setProductId(productId);
            productComment.setUserId(userId);
            productComment.setComment(comment);
            productComment.setRating(rating);

            ProductCommentDAO commentDAO = new ProductCommentDAO();
            commentDAO.saveComment(productComment);

            response.sendRedirect("product.jsp?id=" + productId);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID or User ID");
            e.printStackTrace();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the comment");
            e.printStackTrace();
        }
    }
}
