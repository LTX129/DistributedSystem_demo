<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="model.ProductComment" %>
<%@ page import="java.util.List" %>

<%
    // 获取请求参数中的商品 ID
    String productIdStr = request.getParameter("id");

    // 如果没有通过 ProductServlet 加载数据，重定向到 ProductServlet 以加载数据
    if (request.getAttribute("product") == null) {
        if (productIdStr != null && !productIdStr.isEmpty()) {
            response.sendRedirect("ProductServlet?id=" + productIdStr);
            return; // 确保 JSP 不再继续执行
        } else {
            // 没有提供商品 ID，重定向到主页面
            response.sendRedirect("index.jsp");
            return; // 确保 JSP 不再继续执行
        }
    }

    Product product = (Product) request.getAttribute("product");
    List<ProductComment> comments = (List<ProductComment>) request.getAttribute("comments");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
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
    <h2 class="my-4">Product Details</h2>
    <%
        if (product == null) {
    %>
    <p>Product not found. Please <a href="index.jsp">return to the main page</a> to continue shopping.</p>
    <%
            return;
        }
    %>
    <div class="card mb-4">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="https://via.placeholder.com/150" class="img-fluid rounded-start" alt="<%= product.getName() %>">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <p class="card-text"><strong>Price: $<%= product.getPrice() %></strong></p>
                    <form action="CartServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                        <button type="submit" class="btn btn-primary mt-3">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 商品评论部分 -->
    <div class="card">
        <div class="card-body">
            <h4>Product Reviews</h4>
            <%
                if (comments != null && !comments.isEmpty()) {
                    for (ProductComment comment : comments) {
            %>
            <div class="comment mb-3">
                <p><strong>User ID <%= comment.getUserId() %>:</strong> <%= comment.getComment() %></p>
                <p>Rating: <%= comment.getRating() %> Stars</p>
                <p><small>Posted on: <%= comment.getCreatedAt() %></small></p>
            </div>
            <hr>
            <%
                }
            } else {
            %>
            <p>No reviews yet. Be the first to review this product!</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- 返回主菜单的按钮 -->
<a href="index.jsp" class="btn btn-secondary back-button">Return to Main Menu</a>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
