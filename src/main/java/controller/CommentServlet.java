package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.ProductComment;
import model.ProductCommentDAO;

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
        int productId = Integer.parseInt(request.getParameter("productId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String commentText = request.getParameter("comment");
        int rating = Integer.parseInt(request.getParameter("rating"));

        ProductComment comment = new ProductComment();
        comment.setProductId(productId);
        comment.setUserId(userId);
        comment.setComment(commentText);
        comment.setRating(rating);

        ProductCommentDAO commentDAO = new ProductCommentDAO();
        try {
            commentDAO.saveComment(comment);
            response.sendRedirect("ProductServlet?id=" + productId);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Failed to submit comment. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("comment.jsp");
            dispatcher.forward(request, response);
        }
    }
}
