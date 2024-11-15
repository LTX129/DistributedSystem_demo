<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String username = org.apache.commons.text.StringEscapeUtils.escapeHtml4(request.getParameter("username")); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart</title>
    <!-- 引入 Bootstrap CSS 库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .cart-header {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cart-header h2 {
            color: #e2231a;
            margin: 0;
        }
        .cart-table {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
        }
        .cart-table th, .cart-table td {
            text-align: center;
            padding: 15px;
        }
        .cart-table th {
            background-color: #f5f5f5;
        }
        .cart-table img {
            width: 80px;
            height: auto;
        }
        .cart-actions a {
            color: #e2231a;
            text-decoration: none;
        }
        .cart-actions a:hover {
            text-decoration: underline;
        }
        .total-price {
            font-size: 24px;
            text-align: right;
            margin-top: 20px;
        }
        .btn-checkout, .btn-continue-shopping {
            background-color: #e2231a;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            text-align: right;
            display: inline-block;
            margin-top: 20px;
            float: right;
        }
        .btn-checkout:hover, .btn-continue-shopping:hover {
            background-color: #c81e14;
        }
        .btn-continue-shopping {
            margin-top: 10px;
        }
        .empty-cart {
            text-align: center;
            color: #666;
            margin-top: 50px;
        }
        .empty-cart a {
            color: #e2231a;
            text-decoration: none;
        }
        .empty-cart a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="cart-header">
        <h2>Your Shopping Cart</h2>
        <div>
            <input type="text" class="form-control d-inline-block" style="width: 300px;" placeholder="Search for products...">
            <button class="btn btn-danger">搜索</button>
        </div>
    </div>

    <%
        // 获取购物车对象（从 session 中获取）
        Cart cart = (Cart) session.getAttribute("cart");
        double totalPrice = 0.0;

        if (cart != null && !cart.getItems().isEmpty()) {
            java.util.List<CartItem> cartItems = cart.getItems();
    %>
    <form action="CartServlet" method="post">
        <div class="cart-table">
            <table class="table">
                <thead>
                <tr>
                    <th>Product Image</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (CartItem item : cartItems) {
                        double itemTotal = item.getProduct().getPrice().doubleValue() * item.getQuantity();
                        totalPrice += itemTotal;
                %>
                <tr>
                    <td><img src="https://via.placeholder.com/80" alt="<%= item.getProduct().getName() %>"></td>
                    <td><%= item.getProduct().getName() %></td>
                    <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                    <td>
                        <input type="number" name="quantity_<%= item.getProduct().getId() %>" value="<%= item.getQuantity() %>" min="1" class="form-control" style="width: 80px; text-align: center;">
                    </td>
                    <td>$<%= String.format("%.2f", itemTotal) %></td>
                    <td class="cart-actions">
                        <a href="CartServlet?action=remove&productId=<%= item.getProduct().getId() %>" class="btn btn-danger">Remove</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div class="total-price">
                <strong>Total Price: $<%= String.format("%.2f", totalPrice) %></strong>
            </div>

            <input type="hidden" name="action" value="update">
            <input type="submit" class="btn btn-secondary" value="Update Cart">
        </div>
    </form>

    <form action="order_confirmation.jsp" method="get">
        <button class="btn-checkout">Proceed to Checkout</button>
    </form>

    <a href="index.jsp" class="btn-continue-shopping">Continue Shopping</a>

    <%
    } else {
    %>
    <div class="empty-cart">
        <img src="https://img.icons8.com/ios-filled/100/empty-box.png" alt="Empty Cart">
        <p>Your cart is empty.</p>
        <a href="index.jsp">Continue Shopping</a>
    </div>
    <%
        }
    %>
</div>

<!-- 引入 Bootstrap JS 库 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
