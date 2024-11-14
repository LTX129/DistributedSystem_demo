<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Leave a Comment</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>Leave a Review</h2>
  <form action="CommentServlet" method="post">
    <!-- Get Product ID and User ID from request parameters -->
    <input type="hidden" name="productId" value="<%= request.getAttribute("productId") %>">
    <input type="hidden" name="userId" value="<%= request.getAttribute("userId") %>">

    <!-- Comment Text -->
    <div class="mb-3">
      <label for="commentText" class="form-label">Your Review:</label>
      <textarea class="form-control" id="commentText" name="comment" rows="4" required></textarea>
    </div>

    <!-- Rating -->
    <div class="mb-3">
      <label for="rating" class="form-label">Your Rating:</label>
      <select class="form-select" id="rating" name="rating" required>
        <option value="1">1 Star</option>
        <option value="2">2 Stars</option>
        <option value="3">3 Stars</option>
        <option value="4">4 Stars</option>
        <option value="5">5 Stars</option>
      </select>
    </div>

    <!-- Submit Button -->
    <button type="submit" class="btn btn-primary">Submit Review</button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
