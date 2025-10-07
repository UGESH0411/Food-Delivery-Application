<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.parsers.*, javax.xml.transform.*, javax.xml.transform.stream.*, javax.xml.xpath.*, org.w3c.dom.*" %>
<%@ page import="java.net.*, java.io.*" %>
<%
    URL url = new URL("http://localhost:8080/FoodDelivery/OrderXMLServlet");
    InputStream xmlStream = url.openStream();

    TransformerFactory factory = TransformerFactory.newInstance();
    StreamSource xsl = new StreamSource(application.getRealPath("Orders.xsl"));
    Transformer transformer = factory.newTransformer(xsl);

    response.setContentType("text/html; charset=UTF-8");

    StringWriter sw = new StringWriter();
    transformer.transform(new StreamSource(xmlStream), new StreamResult(sw));
    String serverOrdersHtml = sw.toString();
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Food Delivery Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        body h2 {
            padding: 12px;
            color: white;
            background-color: black;
        }
        a {
            text-decoration: none;
        }
        button {
            margin: 5px;
            padding: 10px 15px;
            border: none;
            background: #007BFF;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>

    <script>
        function loadFromServlet() {
            fetch("http://localhost:8080/FoodDelivery/OrderXMLServlet")
            .then(response => response.text())
            .then(str => (new window.DOMParser()).parseFromString(str, "text/xml"))
            .then(xml => {
                let orders = xml.getElementsByTagName("order");
                let table = "<h3>Orders from Servlet</h3><table><tr><th>ID</th><th>User</th><th>Quantity</th><th>Price</th><th>Total</th></tr>";
                for (let i = 0; i < orders.length; i++) {
                    table += "<tr><td>" + orders[i].getElementsByTagName("order_id")[0].textContent +
                             "</td><td>" + orders[i].getElementsByTagName("username")[0].textContent +
                             "</td><td>" + orders[i].getElementsByTagName("quantity")[0].textContent +
                             "</td><td>₹" + orders[i].getElementsByTagName("price")[0].textContent +
                             "</td><td>₹" + orders[i].getElementsByTagName("total")[0].textContent +
                             "</td></tr>";
                }
                table += "</table>";
                document.getElementById("result").innerHTML = table;
            });
        }

        function loadFromXML() {
            fetch("http://localhost:8080/FoodDelivery/orders.xml")
            .then(response => response.text())
            .then(str => (new window.DOMParser()).parseFromString(str, "text/xml"))
            .then(xml => {
                let orders = xml.getElementsByTagName("order");
                let table = "<h3>Orders from XML File</h3><table><tr><th>ID</th><th>User</th><th>Price</th></tr>";
                for (let i = 0; i < orders.length; i++) {
                    table += "<tr><td>" + orders[i].getElementsByTagName("order_id")[0].textContent +
                             "</td><td>" + orders[i].getElementsByTagName("username")[0].textContent +
                             "</td><td>₹" + orders[i].getElementsByTagName("price")[0].textContent +
                             "</td></tr>";
                }
                table += "</table>";
                document.getElementById("result").innerHTML = table;
            });
        }

        function loadFromPHP() {
        	fetch("http://localhost/FoodPhp/orders.php")
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    document.getElementById("result").innerHTML = "<p class='error'> PHP Error: " + data.error + "</p>";
                    return;
                }
                if (data.length === 0) {
                    document.getElementById("result").innerHTML = "<p>No orders found (PHP).</p>";
                    return;
                }
                let table = "<h3>Orders from PHP</h3><table><tr><th>ID</th><th>User</th><th>Total</th></tr>";
                data.forEach(order => {
                    table += "<tr><td>" + order.id + "</td><td>" + order.user + "</td><td>₹" + order.total + "</td></tr>";
                });
                table += "</table>";
                document.getElementById("result").innerHTML = table;
            })
            .catch(err => {
                document.getElementById("result").innerHTML = "<p class='error'>Could not reach PHP server.<br>" + err + "</p>";
            });
        }
    </script>
</head>
<body>
<center>
    <h2>Food Delivery Orders (AJAX)</h2>
    <div class="nav">
        <button onclick="javascript:history.back()">Back</button>
        <button onclick="loadFromServlet()">Load from Servlet</button>
        <button onclick="loadFromXML()">Load from XML</button>
        <button onclick="loadFromPHP()">Load from PHP</button>
    </div>
    <div id="result">
        <p><i>Click a button to load orders...</i></p>
    </div>
</center>
</body>
</html>
