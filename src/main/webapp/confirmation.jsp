<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - Kumar Restaurant</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .confirmation-container {
            max-width: 500px;
            margin: 60px auto;
            background: white;
            border-radius: 10px;
            padding: 30px 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .confirmation-container h1 {
            color: #28a745;
            margin-bottom: 15px;
            font-size: 2rem;
        }
        .confirmation-container p {
            font-size: 1.1rem;
            margin: 10px 0;
            color: #333;
        }
        .btn-home {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 30px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="confirmation-container">
    <h1>Order Placed Successfully!</h1>
    <p><strong>User:</strong> <%= request.getAttribute("user") %></p>
    <p><strong>Item:</strong> <%= request.getAttribute("item") %></p>
    <p><strong>Quantity:</strong> <%= request.getAttribute("quantity") %></p>
    <p><strong>Total Price:</strong> &#8377;<%= request.getAttribute("total") %></p>

    <a href="index.jsp" class="btn-home">Back to Home</a>
</div>

</body>
</html>
