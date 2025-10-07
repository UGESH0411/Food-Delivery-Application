<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background-image: url('src/restaurant.jpg');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
        }
        .header {
            background-color: black;
            padding: 15px;
            text-align: center;
            border-radius: 0 0 10px 10px;
        }
        .header h1 { color: white; font-size: 24px; }
        .login-container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            width: 450px;
            margin: 80px auto;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.3);
        }
        .login-container h2 { text-align: center; margin-bottom: 20px; color: black; }
        .login-container label { display: block; margin-top: 10px; font-weight: bold; }
        .login-container input[type="text"],
        .login-container input[type="password"],
        .login-container select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid black;
            border-radius: 5px;
        }
        .login-container input[type="submit"],
        .login-container input[type="reset"] {
            width: 48%;
            padding: 10px;
            margin-top: 15px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }
        .login-container input[type="submit"]:hover,
        .login-container input[type="reset"]:hover { background-color: #333; }
    </style>
</head>
<body>

<div class="header">
    <h1>Kumar Restaurant Login</h1>
</div>

<div class="login-container">
    <h2>Login</h2>
    <form action="LoginServlet" method="post">
        <label for="txtName">Username:</label>
        <input type="text" name="username" id="txtName" required>

        <label for="txtPwd">Password:</label>
        <input type="password" name="password" id="txtPwd" required>

        <label for="role">Login as:</label>
        <select name="role" id="role" required>
            <option value="customer">Customer</option>
            <option value="admin">Admin</option>
        </select>

        <div style="display: flex; justify-content: space-between;">
            <input type="submit" value="Login">
            <input type="reset" value="Reset">
        </div>
    </form>
    <div style="text-align: center; margin-top: 20px;">
        <p>Don't have an account? 
            <a href="register.jsp" style="color: blue; font-weight: bold;">Register here</a>
        </p>
    </div>
</div>

</body>
</html>
