<?php
$value = $_GET['query'];
$formfield = $_GET['field'];

if ($formfield == "name") {
    if (strlen($value) < 3) {
        echo "Must be 3+ letters";
    } else {
        echo "<span style='color:green'>Valid</span>";
    }
}

if ($formfield == "age") {
    if (!is_numeric($value) || $value < 1 || $value > 120) {
        echo "Invalid age";
    } else {
        echo "<span style='color:green'>Valid</span>";
    }
}

if ($formfield == "email") {
    if (!filter_var($value, FILTER_VALIDATE_EMAIL)) {
        echo "Invalid email";
    } else {
        echo "<span style='color:green'>Valid</span>";
    }
}

if ($formfield == "password") {
    if (strlen($value) < 6) {
        echo "Password too short";
    } else {
        echo "<span style='color:green'>Strong</span>";
    }
}
?>
