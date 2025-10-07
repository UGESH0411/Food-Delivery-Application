<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Panel - Manage Products</title>
<style>
body { font-family: Arial; background: #f5f5f5; padding: 20px; }
.header { display: flex; justify-content: space-between; align-items: center; background: #333; color: white; padding: 15px; border-radius: 5px; }
.logout-btn { background: #dc3545; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
.logout-btn:hover { background: #c82333; }
.container { margin: 30px auto; width: 90%; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 5px rgba(0,0,0,0.2); }
form { margin-bottom: 30px; }
input, textarea { padding: 8px; margin: 5px 0; border-radius: 5px; width: 100%; }
input[type=submit] { background: #28a745; color: white; font-weight: bold; border: none; cursor: pointer; }
input[type=submit]:hover { background: #218838; }
table { width: 100%; border-collapse: collapse; margin-top: 20px; }
th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
th { background: #f4b41a; color: white; }
</style>
</head>
<body>

<div class="header">
  <a href="admin_orders.jsp" class="logout-btn">View Orders</a>
    <h2>Admin Panel</h2>
  <a href="Logout" class="logout-btn">Logout</a>
</div>


<div class="container">
<h3>Add New Food Item</h3>
<form action="AdminProductServlet" method="post">
    <input type="hidden" name="action" value="add">
    <label>Food Name:</label>
    <input type="text" name="name" required>

    <label>Description:</label>
    <textarea name="description" required></textarea>

    <label>Price (₹):</label>
    <input type="number" name="price" min="1" required>

    <label>Stock:</label>
    <input type="number" name="stock" min="0" required>

    <label>Image Path:</label>
    <input type="text" name="image" placeholder="e.g. images/pizza.jpg" required>

    <input type="submit" value="Add Item">
</form>

<h3>Update Stock of Existing Items</h3>
<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Current Stock</th>
<th>Update Stock (+/-)</th>
<th>Action</th>
</tr>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");
    ps = con.prepareStatement("SELECT id, name, stock FROM products");
    rs = ps.executeQuery();
    while(rs.next()){
%>
<tr>
    <form action="AdminProductServlet" method="post">
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getInt("stock") %></td>
        <td>
            <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
            <input type="number" name="stock_change" value="0" required>
        </td>
        <td>
            <input type="hidden" name="action" value="update_stock">
            <input type="submit" value="Update Stock">
        </td>
    </form>
</tr>
<%
    }
} catch(Exception e){ e.printStackTrace(); } 
finally{
    try{ if(rs!=null) rs.close(); } catch(Exception ignore){}
    try{ if(ps!=null) ps.close(); } catch(Exception ignore){}
    try{ if(con!=null) con.close(); } catch(Exception ignore){}
}
%>
</table>
</div>
</body>
</html>
