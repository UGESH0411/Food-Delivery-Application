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

<!-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        * { text-decoration: none; box-sizing: border-box; }
        body { background-color: bisque; font-family: Arial, sans-serif; margin: 0; padding: 0; }
        h1 { color: black; }
        td { padding: 10px; }
        input, textarea { padding: 10px; font-size: small; }   /* ✅ removed width:100% */
        .footer { background-color: black; padding: 20px; text-align: center; }
        .footer a { color: black; background-color: white; padding: 10px; text-decoration: none; margin: 5px; border-radius: 5px; }
        .form-msg { font-size: 12px; margin-top: 4px; }
        .form-msg.error { color: red; }
        .form-msg.success { color: green; }
        .message { font-weight: bold; margin: 10px 0; }
        .message.error { color: red; }
        .message.success { color: green; }
        table { }
        input[type=submit] { background-color: black; color: white; cursor: pointer; border: none; border-radius: 5px; padding: 10px 20px; }
        input[type=submit]:hover { background-color: darkred; }
    </style>
    <script>
      
        function validate(field, query) {
            var msg = document.getElementById(field);

            if (field === "name") {
                if (query.length < 3) {
                    msg.className = "form-msg error";
                    msg.innerText = "Name must be at least 3 characters.";
                    return;
                }
            }

            if (field === "password") {
                if (query.length < 6) {
                    msg.className = "form-msg error";
                    msg.innerText = "Password too short (min 6 chars).";
                    return;
                }
                if (!/[A-Z]/.test(query) || !/[0-9]/.test(query)) {
                    msg.className = "form-msg error";
                    msg.innerText = "Password must contain 1 uppercase & 1 number.";
                    return;
                }
            }

            if (field === "email") {
                var re = /^[\w.-]+@([\w-]+\.)+[A-Za-z]{2,}$/;
                if (!re.test(query)) {
                    msg.className = "form-msg error";
                    msg.innerText = "Invalid email format.";
                    return;
                }
            }

            
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        var res = JSON.parse(xhr.responseText);
                        if (res.valid) {
                            msg.className = "form-msg success";
                            msg.innerText = res.message;
                        } else {
                            msg.className = "form-msg error";
                            msg.innerText = res.message;
                        }
                    } catch (e) {
                        msg.className = "form-msg error";
                        msg.innerText = "Server error.";
                    }
                }
            };
            xhr.open("GET", "ValidationServlet?field=" + encodeURIComponent(field) + "&query=" + encodeURIComponent(query), true);
            xhr.send();
        }

        
        function submitForm(e) {
            e.preventDefault();
            var name = document.getElementById("name1").value.trim();
            var age = document.getElementById("age1").value.trim();
            var email = document.getElementById("email1").value.trim();
            var password = document.getElementById("password1").value.trim();

        
            if (!name || !age || !email || !password) {
                alert("Please fill all required fields.");
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "RegisterServlet", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    try {
                        var res = JSON.parse(xhr.responseText);
                        let msgBox = document.querySelector(".message");
                        if (!msgBox) {
                            msgBox = document.createElement("p");
                            msgBox.className = "message";
                            document.getElementById("registerForm").before(msgBox);
                        }
                        if (res.status === "success") {
                            msgBox.className = "message success";
                            msgBox.innerHTML = res.message + " <a href='login.jsp'>Login here</a>";
                            document.getElementById("registerForm").reset();
                            document.getElementById("name").innerText = "";
                            document.getElementById("age").innerText = "";
                            document.getElementById("email").innerText = "";
                            document.getElementById("password").innerText = "";
                        } else {
                            msgBox.className = "message error";
                            msgBox.innerText = res.message;
                        }
                    } catch (e) {
                        alert("Server error. Try again later.");
                    }
                }
            };
            xhr.send(
                "name=" + encodeURIComponent(name) +
                "&age=" + encodeURIComponent(age) +
                "&email=" + encodeURIComponent(email) +
                "&password=" + encodeURIComponent(password)
            );
        }
    </script>
</head>
<body>
    <center>
        <h1 style="background-color: black;color: white;padding: 10px">Register Form</h1>
        <header class="head">
            <h1>Kumar Restaurant</h1>
            <h5>A restaurant is a fantasy—a kind of living fantasy in which diners are the most important members of the cast.</h5>
            <p>
                Kumar Restaurant, located in Tamil Nadu 641004, is known for its commitment to quality ingredients and delightful flavors.
                It offers a refined ambiance with elegant decor and warm lighting, suitable for both quick bites and leisurely gatherings.
            </p>
        </header>

        <form id="registerForm" method="post" onsubmit="submitForm(event)">
            <table>
                <tr>
                    <td>Name</td>
                    <td><input id="name1" name="name" onblur="validate('name', this.value)" type="text"></td>
                    <td><div id="name" class="form-msg"></div></td>
                </tr>
                <tr>
                    <td>Age</td>
                    <td><input id="age1" name="age" type="number"></td>
                    <td><div id="age" class="form-msg"></div></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td>
                        <input type="radio" name="gender" value="Male"> Male
                        <input type="radio" name="gender" value="Female"> Female
                    </td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><input id="email1" name="email" onblur="validate('email', this.value)" type="text"></td>
                    <td><div id="email" class="form-msg"></div></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input id="password1" name="password" onblur="validate('password', this.value)" type="password"></td>
                    <td><div id="password" class="form-msg"></div></td>
                </tr>
                <tr>
                    <td>Feedback</td>
                    <td><textarea name="feedback" placeholder="Enter your feedback"></textarea></td>
                </tr>
            </table>
            <input type="submit" value="Submit">
        </form>
    </center>

    <div class="footer">
        <a href="index.jsp">Home</a>
        <a href="index.jsp#about">About</a>
        <a href="index.jsp#contact">Contact</a>
    </div>
</body>
</html>
 -->
