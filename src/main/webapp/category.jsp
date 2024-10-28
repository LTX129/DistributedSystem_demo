<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductDAO" %>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Category</title>
    <!-- 引入 Bootstrap CSS 库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 返回按钮样式 */
        .back-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            transition: opacity 0.3s ease;
        }

        .back-button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="my-4">Product Category</h2>
    <div class="row">
        <%
            // 获取请求参数中的类别
            String category = request.getParameter("category");
            if (category == null || category.isEmpty()) {
        %>
        <p>Category is not specified.</p>
        <%
        } else {
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.getProductsByCategory(category);

            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card">
                <img src="https://via.placeholder.com/150" class="card-img-top" alt="<%= product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><strong>Price: $<%= product.getPrice() %></strong></p>
                    <a href="product.jsp?id=<%= product.getId() %>" class="btn btn-primary">View Details</a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <p>No products found in this category.</p>
        <%
                }
            }
        %>
    </div>
</div>

<!-- 返回主菜单的按钮 -->
<a href="index.jsp" class="btn btn-secondary back-button">Return to Main Menu</a>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
