<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Temp.OrderItem" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("res_login.jsp");
        return;
    }

    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    Double grandTotal = (Double) request.getAttribute("grandTotal");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f9f9f9; padding: 20px; background-image: url('src/restaurant.jpg');}
        .container { max-width: 700px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);}
        h1 { text-align: center; color: #28a745; }
        table { width: 100%; border-collapse: collapse; margin-top: 25px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 12px; text-align: center; }
        th { background: #f4f4f4; }
        .total { text-align: right; font-size: 1.2rem; font-weight: bold; padding-top: 15px; }
        .btn { display: inline-block; margin-top: 25px; padding: 12px 25px; background-color: #007bff; color: white; text-decoration: none; border-radius: 6px; transition: 0.3s; }
        .btn:hover { background: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h1>Order Placed Successfully!</h1>
    <p><strong>User:</strong> <%= username %></p>

    <table>
        <tr>
            <th>Item</th>
            <th>Qty</th>
            <th>Price (₹)</th>
            <th>Subtotal (₹)</th>
        </tr>
        <% if (orderItems != null && !orderItems.isEmpty()) {
               for (OrderItem oi : orderItems) { %>
            <tr>
                <td><%= oi.getName() %></td>
                <td><%= oi.getQuantity() %></td>
                <td><%= oi.getPrice() %></td>
                <td><%= oi.getTotal() %></td>
            </tr>
        <% } } else { %>
            <tr><td colspan="4">No items ordered.</td></tr>
        <% } %>
    </table>

    <p class="total">Grand Total: ₹<%= grandTotal %></p>

    <div style="text-align: center;">
        <a href="index.jsp" class="btn">Continue Shopping</a>
        <a href="viewCart.jsp" class="btn">View Cart</a>
    </div>
</div>
</body>
</html>
