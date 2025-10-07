<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <title>Admin Orders</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f8f9fa;
          }
          h2, h3 {
            color: #333;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
          }
          th {
            background: #ff7043;
            color: white;
            padding: 12px;
            text-align: left;
          }
          td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
          }
          tr:hover {
            background-color: #f1f1f1;
          }
          .title{
             background-color:black;
             color:white;
             text-align:center;
             padding:10px;
             
          }
        </style>
      </head>
      <body>
        <h2 class="title">Orders Dashboard</h2>

        <h3>Orders where Price &gt; 200</h3>
        <table>
          <tr>
            <th>Order ID</th>
            <th>User</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
            <th>Date</th>
          </tr>
          <xsl:for-each select="orders/order[price &gt; 200]">
            <tr>
              <td><xsl:value-of select="order_id"/></td>
              <td><xsl:value-of select="username"/></td>
              <td><xsl:value-of select="product_id"/></td>
              <td><xsl:value-of select="quantity"/></td>
              <td> &#8377;<xsl:value-of select="price"/></td>
              <td> &#8377;<xsl:value-of select="total"/></td>
              <td><xsl:value-of select="order_date"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <h3>Orders where Quantity ≥ 2</h3>
        <table>
          <tr>
            <th>Order ID</th>
            <th>User</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
            <th>Date</th>
          </tr>
          <xsl:for-each select="orders/order[quantity &gt;= 2]">
            <tr>
              <td><xsl:value-of select="order_id"/></td>
              <td><xsl:value-of select="username"/></td>
              <td><xsl:value-of select="product_id"/></td>
              <td><xsl:value-of select="quantity"/></td>
              <td> &#8377;<xsl:value-of select="price"/></td>
              <td> &#8377;<xsl:value-of select="total"/></td>
              <td><xsl:value-of select="order_date"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <h3>Orders where Price &gt; 100 AND Quantity ≥ 2</h3>
        <table>
          <tr>
            <th>Order ID</th>
            <th>User</th>
            <th>Product ID</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
            <th>Date</th>
          </tr>
          <xsl:for-each select="orders/order[price &gt; 100 and quantity &gt;= 2]">
            <tr>
              <td><xsl:value-of select="order_id"/></td>
              <td><xsl:value-of select="username"/></td>
              <td><xsl:value-of select="product_id"/></td>
              <td><xsl:value-of select="quantity"/></td>
              <td> &#8377;<xsl:value-of select="price"/></td>
              <td> &#8377;<xsl:value-of select="total"/></td>
              <td><xsl:value-of select="order_date"/></td>
            </tr>
          </xsl:for-each>
        </table>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
