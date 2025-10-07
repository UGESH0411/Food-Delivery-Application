<?php
$name = $age = $gender = $email = $password = $feedback = "";
$nameErr = $ageErr = $genderErr = $emailErr = $passwordErr = "";
$successMsg = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $valid = true;

    // Name validation
    if (empty($_POST["name"])) {
        $nameErr = "Name is required";
        $valid = false;
    } else {
        $name = htmlspecialchars($_POST["name"]);
    }

    // Age validation
    if (empty($_POST["age"])) {
        $ageErr = "Age is required";
        $valid = false;
    } else {
        $age = (int)$_POST["age"];
        if ($age < 1) {
            $ageErr = "Age must be at least 1";
            $valid = false;
        }
    }

    // Gender validation
    if (empty($_POST["gender"])) {
        $genderErr = "Gender is required";
        $valid = false;
    } else {
        $gender = $_POST["gender"];
    }

    // Email validation
    if (empty($_POST["email"])) {
        $emailErr = "Email is required";
        $valid = false;
    } else {
        $email = filter_var($_POST["email"], FILTER_SANITIZE_EMAIL);
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $emailErr = "Invalid email format";
            $valid = false;
        }
    }

    // Password validation
    if (empty($_POST["password"])) {
        $passwordErr = "Password is required";
        $valid = false;
    } else {
        $password = $_POST["password"];
    }

    // Feedback (optional)
    $feedback = !empty($_POST["feedback"]) ? htmlspecialchars($_POST["feedback"]) : "";

    // If all fields are valid, redirect to save page (or process here)
    if ($valid) {
        $params = http_build_query([
            'name' => $name,
            'age' => $age,
            'gender' => $gender,
            'email' => $email,
            'password' => $password,
            'feedback' => $feedback
        ]);
        header("Location: http://localhost:6102/Kumar_Restaurant/saveRegister.php?$params");
        exit();
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kumar Restaurant Registration</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: bisque; }
        h2 { text-align: center; background-color: black; color: white; padding: 10px; }
        form { width: 400px; margin: 20px auto; padding: 20px; background: #fff; border-radius: 8px; }
        table { width: 100%; }
        td { padding: 8px; }
        input, textarea { width: 100%; padding: 6px; margin: 2px 0; border-radius: 5px; border: 1px solid #ccc; }
        input[type="submit"], input[type="reset"] { width: 48%; padding: 8px; margin-top: 10px; cursor: pointer; }
        input[type="submit"] { background-color: #007bff; color: white; border: none; }
        input[type="submit"]:hover { background-color: #0056b3; }
        input[type="reset"] { background-color: #6c757d; color: white; border: none; }
        input[type="reset"]:hover { background-color: #5a6268; }
        .error { color: red; font-size: 12px; }
        .footer { background-color: black; padding: 20px; text-align: center; margin-top: 20px; }
        .footer a { color: black; background-color: white; padding: 10px; text-decoration: none; margin: 5px; }
    </style>
</head>
<body>
<h2>Kumar Restaurant Registration Form</h2>

<form method="post" action="">
    <table>
        <tr>
            <td>Name</td>
            <td>
                <input type="text" name="name" value="<?php echo $name; ?>">
                <span class="error"><?php echo $nameErr; ?></span>
            </td>
        </tr>
        <tr>
            <td>Age</td>
            <td>
                <input type="number" name="age" min="1" value="<?php echo $age; ?>">
                <span class="error"><?php echo $ageErr; ?></span>
            </td>
        </tr>
        <tr>
            <td>Gender</td>
            <td>
                <input type="radio" name="gender" value="Male" <?php if($gender=="Male") echo "checked"; ?>> Male
                <input type="radio" name="gender" value="Female" <?php if($gender=="Female") echo "checked"; ?>> Female
                <span class="error"><?php echo $genderErr; ?></span>
            </td>
        </tr>
        <tr>
            <td>Email</td>
            <td>
                <input type="email" name="email" value="<?php echo $email; ?>">
                <span class="error"><?php echo $emailErr; ?></span>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td>
                <input type="password" name="password" value="<?php echo $password; ?>">
                <span class="error"><?php echo $passwordErr; ?></span>
            </td>
        </tr>
        <tr>
            <td>Feedback</td>
            <td>
                <textarea name="feedback"><?php echo $feedback; ?></textarea>
            </td>
        </tr>
        <tr>
            <td><input type="submit" value="Submit"></td>
            <td><input type="reset" value="Reset"></td>
        </tr>
    </table>
</form>


</body>
</html>