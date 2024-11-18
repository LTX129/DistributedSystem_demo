<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="model.Product" %>

<%
  String productId = request.getParameter("productId");
  String userId = request.getParameter("userId");
  String productName = request.getParameter("productName");
  String purchaseDate = request.getParameter("purchaseDate");
  String price = request.getParameter("price");

  if (productId == null || userId == null) {
    response.sendRedirect("all_orders.jsp"); // 如果参数缺失，重定向回订单页面
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Leave a Comment</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
    }
    header {
      background-color: #e2231a;
      color: white;
      padding: 20px;
    }
    header .logo img {
      width: 50px;
    }
    header .btn-login {
      color: #fff;
      margin-left: 10px;
      font-size: 0.9rem;
      padding: 5px 10px;
      border-radius: 20px;
      background-color: #fff;
      color: #e2231a;
      text-decoration: none;
      transition: all 0.3s ease-in-out;
    }
    header .btn-login:hover {
      background-color: #c91a15;
      color: #fff;
    }
    .container {
      margin: 40px auto;
      max-width: 800px;
    }
    .product-info {
      background-color: #fff;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .product-info h4 {
      margin-bottom: 15px;
    }
    .product-info p {
      margin: 5px 0;
      font-size: 1rem;
    }
    .product-info .price {
      font-size: 1.2rem;
      font-weight: bold;
      color: #e2231a;
    }
    .form-control {
      border-radius: 10px;
    }
    button {
      border-radius: 20px;
    }
  </style>
</head>
<body>
<header class="d-flex justify-content-between align-items-center">
  <div class="logo d-flex align-items-center">
    <a href="index.jsp" class="d-flex align-items-center">
      <img src="https://www.jd.com/favicon.ico" alt="logo">
      <span style="color: #ffffff; font-weight: bold; margin-left: 10px;">G3 Shopping</span>
    </a>
  </div>
  <div>
    <a href="logout.jsp" class="btn-login">Logout</a>
  </div>
</header>

<div class="container">
  <div class="product-info text-center">
    <h4>Product Information</h4>
    <img src="img/product_<%= productId %>.jpeg" class="img-fluid mb-3 rounded" alt="<%= productName %>" style="max-width: 200px; height: auto;">
    <p><strong>Product Name:</strong> <%= productName %></p>
    <p><strong>Purchase Date:</strong> <%= purchaseDate %></p>
    <p class="price"><strong>Price:</strong> $<%= price %></p>
  </div>


  <h3 class="text-center">Leave a Review</h3>
  <form action="CommentServlet" method="post">
    <!-- Hidden Fields -->
    <input type="hidden" name="productId" value="<%= productId %>">
    <input type="hidden" name="userId" value="<%= userId %>">

    <!-- Comment -->
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
    <div class="text-center">
      <button type="submit" class="btn btn-success">Submit Review</button>
    </div>
  </form>
</div>

<footer class="text-center mt-5">
  <p>G3 Shopping © 2024 All Rights Reserved</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
