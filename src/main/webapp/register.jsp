<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        * { text-decoration: none; }
        body { background-color: bisque; font-family: Arial; }
        h1 { color: black; }
        td { padding: 10px; }
        input, textarea { padding: 10px; font-size: small; }
        .footer { background-color: black; padding: 20px; text-align: center; }
        .footer a { color: black; background-color: white; padding: 10px; text-decoration: none; margin: 5px; }
    </style>
</head>
<body>
    <center>
        <h1 style="background-color: black;color: white;padding: 10px">Register Form</h1>
         <center>
    <header class="head">
      <h1>Kumar Restaurant</h1>
      <h5>A restaurant is a fantasy—a kind of living fantasy in which diners are the most important members of the cast.</h5>
      <p>
        Kumar Restaurant, located in Tamil Nadu 641004, is known for its commitment to quality ingredients and delightful flavors. It offers a refined ambiance with elegant decor and warm lighting, suitable for both quick bites and leisurely gatherings. The restaurant prides itself on crafting each dish with authentic flavors and providing exceptional service. Kumar Restaurant also emphasizes that they are open at convenient hours to accommodate various dining needs.
      </p>
    </header>
  </center>
        <form id="registerForm">
    <table>
        <tr>
            <td>Name</td>
            <td><input type="text" name="name" required></td>
        </tr>
        <tr>
            <td>Age</td>
            <td><input type="number" name="age" min="1" required></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td>
                <input type="radio" name="gender" value="Male" required> Male
                <input type="radio" name="gender" value="Female"> Female
            </td>
        </tr>
        <tr>
            <td>Email</td>
            <td><input type="email" name="email" required></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password" required></td>
        </tr>
        <tr>
            <td>Feedback</td>
            <td><textarea name="feedback" placeholder="Enter your feedback"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <button type="button" onclick="validateAndRegister()">Submit</button>
                <input type="reset" value="Reset">
            </td>
        </tr>
    </table>
</form>

<div id="result"></div>

<script>
function validateAndRegister() {
    let formData = new FormData(document.getElementById("registerForm"));

    fetch("http://localhost/FoodPhp/validate_register.php", {
        method: "POST",
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "error") {
            document.getElementById("result").innerHTML =
                "<p style='color:red; font-weight:bold;'>" + data.message + "</p>";
        } else {
            document.getElementById("result").innerHTML =
                "<p style='color:green; font-weight:bold;'>" + data.message + "</p>";
            document.getElementById("registerForm").reset();
        }
    })
    .catch(err => {
        document.getElementById("result").innerHTML =
            "<p style='color:red;'>Server Error: " + err + "</p>";
    });
}
</script>