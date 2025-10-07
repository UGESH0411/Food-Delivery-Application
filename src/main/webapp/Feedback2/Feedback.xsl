<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" doctype-system="about:legacy-compat"/>

<xsl:template match="/AllFeedBack">
<html>
<head>
<meta charset="UTF-8"/>
<title>Feedback Summary (XSD)</title>
<style>
    body {
        font-family: system-ui, Segoe UI, Arial, sans-serif;
        padding: 20px;
        background: #f9fafc;
        color: #333;
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #444;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        background: #fff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        border-radius: 6px;
        overflow: hidden;
    }
    thead {
        background: #007acc;
        color: #fff;
    }
    th, td {
        padding: 10px 12px;
        text-align: left;
    }
    tbody tr:nth-child(even) {
        background: #f2f6fa;
    }
    tbody tr:hover {
        background: #e8f4ff;
        transition: background 0.2s ease-in-out;
    }
    th {
        font-weight: 600;
    }
</style>
</head>
<body>
<h2>Feedback Summary (XSD)</h2>
<table>
<thead>
<tr>
<th>OrderId</th>
<th>Customer ID</th>
<th>Name</th>
<th>Email</th>
<th>Food Quality</th>
<th>Delivery Time</th>
<th>Comments</th>
<th>Date</th>
</tr>
</thead>
<tbody>
<xsl:for-each select="FeedBack">
<tr>
<td><xsl:value-of select="OrderId"/></td>
<td><xsl:value-of select="Customer/C_id"/></td>
<td><xsl:value-of select="Customer/C_name"/></td>
<td><xsl:value-of select="Customer/mail"/></td>
<td><xsl:value-of select="Ratings/FoodQuality"/></td>
<td><xsl:value-of select="Ratings/DeliveryTime"/></td>
<td><xsl:value-of select="Comments"/></td>
<td><xsl:value-of select="Date"/></td>
</tr>
</xsl:for-each>
</tbody>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
