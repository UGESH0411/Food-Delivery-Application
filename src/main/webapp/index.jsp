<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException" %>
<%
    String username = null;
    if (session != null) {
        username = (String) session.getAttribute("username");
    }
    if (username == null) {
        response.sendRedirect("res_login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

        String query = "SELECT * FROM products";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="style.css">
  <title>Kumar Restaurant</title>
  <style>
    .filter-section { text-align: center; margin: 20px; }
    .search { padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 4px; }
    select { padding: 8px; margin-left: 10px; border-radius: 4px; }
    .box { border: 1px solid #ccc; border-radius: 10px; margin: 10px; padding: 15px; display: inline-block; width: 250px; vertical-align: top; text-align: center; box-shadow: 0 0 5px rgba(0,0,0,0.1); }
    .box img { max-width: 200px; height: 150px; object-fit: cover; border-radius: 6px; }
    .pname, .pprice { margin: 5px 0; }
    .out-stock { color:red; font-weight:bold; }
  </style>
</head>
<body>
  <div class="header">
    <nav>
      <h1>Kumar Restaurant</h1>
      <ul>
        <li><a href="#">Home | </a></li>
        <li><a href="#Products">Products | </a></li>
        <li><a href="#about">About | </a></li>
        <li><a href="#contact">Contact | </a></li>
        <li><a href="viewCart.jsp">Cart | </a></li>
        <li><a href="Logout">Logout</a></li>
      </ul>
    </nav>
    <span style="color: white; margin-right: 10px;">Welcome, <%= username %>!</span>
  </div>

  <div class="filter-section">
    <input type="text" placeholder="Search..." id="searchInput" class="search">
    <select id="filterType">
      <option value="name">By Name</option>
      <option value="price">By Price</option>
    </select>
  </div>

  <div class="bg">
    <div class="Products" id="Products">
      <center>
        <%
          while (rs.next()) {
            int productId = rs.getInt("id");     
            String productName = rs.getString("name");
            String productDesc = rs.getString("description");
            String productImage = rs.getString("image");
            int price = rs.getInt("price");
            int stock = rs.getInt("stock");
        %>
        <div class="box">
          <img src="<%= productImage %>" alt="<%= productName %>">
          <p class="pname"><strong><%= productName %></strong></p>
          <p><%= productDesc %></p>
          <p class="pprice"><strong>Price:</strong> &#8377;<%= price %></p>
          <% if(stock > 0) { %>
            <p><strong>Stock:</strong> <%= stock %></p>
          <% } else { %>
            <p class="out-stock">Out of Stock</p>
          <% } %>

          <% if(stock > 0) { %>
          <!-- Order Now Form -->
          <form method="post" action="OrderServlet">
            <input type="hidden" name="username" value="<%= username %>">
            <input type="hidden" name="product_id" value="<%= productId %>">
            <input type="hidden" name="price" value="<%= price %>">
            Quantity: <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required>
            <input type="submit" value="Order Now">
          </form>

          <!-- Add to Cart Form -->
          <form method="post" action="CartServlet">
            <input type="hidden" name="username" value="<%= username %>">
            <input type="hidden" name="item" value="<%= productName %>">
            <input type="hidden" name="price" value="<%= price %>">
            Quantity: <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required>
            <input type="submit" value="Add to Cart">
          </form>
          <% } %>
        </div>
        <% } %>
      </center>
    </div>
  </div>

  <div class="review">
    <center>
      <h1>Review about Restaurant</h1><br>
      <iframe width="560" height="315" src="https://www.youtube.com/embed/bUz5vKlzmOw?si=JCmf7sExtfpqVa2K"
        title="YouTube video player" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        allowfullscreen>
      </iframe>
    </center>
  </div>

  <div class="about" id="about">
    <h1 style="text-align: center;">About Us</h1>
    <p>
      Kumar Restaurant, located in Tamil Nadu 641004, is known for its commitment to quality ingredients and delightful flavors. 
      It offers a refined ambiance with elegant decor and warm lighting, suitable for both quick bites and leisurely gatherings. 
      The restaurant prides itself on crafting each dish with authentic flavors and providing exceptional service.
    </p>
  </div>

  <div class="contact" id="contact"> 
    <center>
      <p><strong>Contact</strong></p>
      <p>+91 9876543210</p>
      <p>kumar117@gmail.com</p>
      <p style="font-style: italic;">"A restaurant is a fantasy—a kind of living fantasy in which diners are the most important members of the cast." - Warner LeRoy</p>
    </center>
  </div>

  <script>
    const searchInput = document.getElementById('searchInput');
    const filterType = document.getElementById('filterType');

    searchInput.addEventListener('keyup', function() {
      const filterValue = this.value.toLowerCase();
      const filterOption = filterType.value;
      const boxes = document.querySelectorAll('.Products .box');

      boxes.forEach(box => {
        const nameElem = box.querySelector('.pname');
        const priceElem = box.querySelector('.pprice');

        const name = nameElem ? nameElem.innerText.toLowerCase() : '';
        const priceText = priceElem ? priceElem.innerText.replace(/[^\d]/g, '') : '';

        let match = false;
        if (filterOption === "name") {
          match = name.includes(filterValue);
        } else if (filterOption === "price") {
          match = priceText.includes(filterValue.replace(/[^\d]/g, ''));
        }

        box.style.display = match ? '' : 'none';
      });
    });
  </script>

</body>
</html>

<%
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception ignore) {}
        if (ps != null) try { ps.close(); } catch(Exception ignore) {}
        if (con != null) try { con.close(); } catch(Exception ignore) {}
    }
%>
