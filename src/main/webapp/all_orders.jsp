<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .order-header {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .order-header h2 {
            color: #e2231a;
        }
        .order-table {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .order-table th, .order-table td {
            text-align: center;
            padding: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="order-header">
        <h2>All Orders</h2>
    </div>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");

        if (orders != null && !orders.isEmpty()) {
    %>
    <div class="order-table">
        <table class="table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Shipping Address</th>
                <th>Payment Method</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Order order : orders) {
                    for (OrderItem item : order.getItems()) {
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td>$<%= String.format("%.2f", item.getProduct().getPrice().doubleValue() * item.getQuantity()) %></td>
                <td><%= order.getShippingAddress() %></td>
                <td><%= order.getPaymentMethod() %></td>
            </tr>
            <%
                    }
                }
            %>
            <!-- all_orders.jsp -->
            <% for (Order order : orders) { %>
            <h3>Order ID: <%= order.getOrderId() %></h3>
            <ul>
                <% for (OrderItem item : order.getItems()) { %>
                <li>
                    Product: <%= item.getProduct().getName() %> - Quantity: <%= item.getQuantity() %>
                    <form action="CommentServlet" method="get">
                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                        <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">
                        <button type="submit" class="btn btn-primary">Leave a Comment</button>
                    </form>
                </li>
                <% } %>
            </ul>
            <% } %>
            </tbody>
        </table>
    </div>
    <%
    } else {
    %>
    <div class="empty-orders">
        <p>No orders found.</p>
    </div>
    <%
        }
    %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
