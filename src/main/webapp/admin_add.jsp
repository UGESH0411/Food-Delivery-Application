<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Food Item</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f5f5f5;
      padding: 20px;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #333;
      color: white;
      padding: 15px;
      border-radius: 5px;
    }
    .header h2 {
      margin: 0;
    }
    .logout-btn {
      background: #dc3545;
      color: white;
      padding: 8px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      text-decoration: none;
    }
    .logout-btn:hover {
      background: #c82333;
    }
    .form-container {
      width: 400px;
      margin: 30px auto;
      background: white;
      padding: 50px;
      border-radius: 8px;
      box-shadow: 0 0 5px rgba(0,0,0,0.2);
    }
    input, textarea {
      width: 100%;
      padding: 10px;
      margin: 8px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    input[type=submit] {
      background: #28a745;
      color: white;
      cursor: pointer;
      font-weight: bold;
    }
    input[type=submit]:hover {
      background: #218838;
    }
  </style>
</head>
<body>
  <div class="header">
    <h2>Admin Panel - Add Food Item</h2>
    <a href="LogoutServlet" class="logout-btn">Logout</a>
  </div>

  <div class="form-container">
    <h2>Add New Food Item</h2>
    <form action="AddProductServlet" method="post" enctype="multipart/form-data">
      <label>Food Name:</label>
      <input type="text" name="name" required>

      <label>Description:</label>
      <textarea name="description" required></textarea>

      <label>Price (₹):</label>
      <input type="number" name="price" min="1" required>

      <label>Upload Image:</label>
      <input type="file" name="image" accept="image/*" required>

      <input type="submit" value="Add Item">
    </form>
  </div>
</body>
</html>
