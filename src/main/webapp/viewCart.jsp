<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("res_login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Cart</title>
<style>
    body { font-family: Arial, sans-serif; background-color: #f7f7f7; margin: 0; padding: 0;background-image: url('src/restaurant.jpg'); }
    .container { width: 80%; margin: 50px auto; background-color: #fff; padding: 30px; 
                 box-shadow: 0 0 15px rgba(0,0,0,0.1); border-radius: 10px; }
    h1 { text-align: center; color: #333; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    table, th, td { border: 1px solid #ddd; }
    th, td { padding: 12px; text-align: center; }
    th { background-color: #f4b41a; color: #fff; }
    tr:nth-child(even) { background-color: #f9f9f9; }
    .btn { padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; }
    .btn-buy { background-color: #28a745; color: #fff; }
    #go { background-color: #f4b41a; padding: 8px 15px; color: #fff; border: none; 
         border-radius: 5px; cursor: pointer; position: absolute; left: 150px; }
    .btn-delete { background-color: #dc3545; color: #fff; }
    .grand-total { text-align: right; font-weight: bold; font-size: 1.2em; }
    .buy-all { margin-top: 20px; text-align: right; }
    .out-of-stock { color: red; font-weight: bold; }
</style>
</head>
<body>
<div class="container">
    <h1>Your Shopping Cart</h1>
    <table>
        <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Stock Status</th>
            <th>Action</th>
        </tr>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            ps = con.prepareStatement("SELECT * FROM cart WHERE username=?");
            ps.setString(1, username);
            rs = ps.executeQuery();

            double grandTotal = 0;

            while (rs.next()) {
                String item = rs.getString("item");
                int cartQty = rs.getInt("quantity");
                double price = rs.getDouble("price");
                double total = rs.getDouble("total");

                // Fetch product id and stock
                int productId = 0;
                int availableStock = 0;
                boolean inStock = false;

                PreparedStatement psProd = con.prepareStatement("SELECT id, stock FROM products WHERE name=?");
                psProd.setString(1, item);
                ResultSet rsProd = psProd.executeQuery();

                if (rsProd.next()) {
                    productId = rsProd.getInt("id");
                    availableStock = rsProd.getInt("stock");
                    inStock = (availableStock >= cartQty);
                }
                rsProd.close();
                psProd.close();

                grandTotal += total;
        %>
        <tr>
            <td><%= item %></td>
            <td>₹<%= price %></td>
            <td><%= cartQty %></td>
            <td>₹<%= total %></td>
            <td>
                <% if (inStock) { %>
                    In Stock (Available: <%= availableStock %>)
                <% } else { %>
                    <span class="out-of-stock">Out of Stock</span>
                <% } %>
            </td>
            <td>
                <% if (inStock) { %>
                <form action="OrderServlet" method="post" style="display:inline-block;">
                    <input type="hidden" name="username" value="<%= username %>">
                    <input type="hidden" name="product_id" value="<%= productId %>">
                    <input type="hidden" name="price" value="<%= price %>">
                    Quantity: <input type="number" name="quantity" min="1" value="<%= cartQty %>" required>
                    <button type="submit">Place Order</button>
                </form>
                <% } else { %>
                    <button class="btn btn-buy" disabled>Buy Now</button>
                <% } %>

                <form method="post" action="DeleteFromCartServlet" style="display:inline-block;">
                    <input type="hidden" name="username" value="<%= username %>">
                    <input type="hidden" name="item" value="<%= item %>">
                    <input type="submit" class="btn btn-delete" value="Remove">
                </form>
            </td>
        </tr>
        <%
            } // end while
        %>
        <tr>
            <td colspan="4" class="grand-total">Grand Total:</td>
            <td colspan="2">₹<%= grandTotal %></td>
        </tr>
    </table>

    <div class="buy-all">
        <a href="index.jsp"><button id="go">Go Back</button></a>
        <form method="post" action="BuyAllServlet">
            <input type="hidden" name="username" value="<%= username %>">
            <input type="submit" class="btn btn-buy" value="Buy All">
        </form>
    </div>

<%
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch(Exception ignore) {}
            try { if (ps != null) ps.close(); } catch(Exception ignore) {}
            try { if (con != null) con.close(); } catch(Exception ignore) {}
        }
%>
</div>
</body>
</html>
