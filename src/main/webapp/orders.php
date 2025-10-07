<?php
// Allow cross-origin requests (needed since JSP runs on Tomcat:8080 and PHP on Apache:80)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

// Database connection details
$servername = "localhost";
$username   = "root";
$password   = "6382501831u";   // ⚠️ Make sure this matches your MySQL root password
$dbname     = "Data_128";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["error" => "Connection failed: " . $conn->connect_error]);
    exit;
}

// Run SQL query
$sql = "SELECT order_id, username, total FROM orders ORDER BY order_date DESC";
$result = $conn->query($sql);

$orders = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $orders[] = [
            "id"   => $row["order_id"],
            "user" => $row["username"],
            "total"=> $row["total"]
        ];
    }
}

// Return JSON (even if empty, return [])
echo json_encode($orders, JSON_UNESCAPED_UNICODE);

$conn->close();
?>
