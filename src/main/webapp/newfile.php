<?php
// Initialize variables
$name = $email = "";
$message = "";

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = htmlspecialchars($_POST["name"]);
    $email = htmlspecialchars($_POST["email"]);
    
    if (!empty($name) && !empty($email)) {
        $message = "✅ Thank you, <b>$name</b>. We received your email: <b>$email</b>";
    } else {
        $message = "⚠️ Please fill in all fields!";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Simple PHP Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background: #007bff;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .message {
            margin-top: 15px;
            text-align: center;
            color: #444;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Simple Form</h2>
        <form method="post" action="">
            <input type="text" name="name" placeholder="Enter your name" value="<?php echo $name; ?>" required>
            <input type="email" name="email" placeholder="Enter your email" value="<?php echo $email; ?>" required>
            <input type="submit" value="Submit">
        </form>
        <div class="message"><?php echo $message; ?></div>
    </div>
</body>
</html>
