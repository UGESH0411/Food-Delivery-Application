package Temp;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/OrderXMLServlet")
public class OrderXMLServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(
                "SELECT o.order_id, o.username, p.name AS product_name, o.quantity, o.price, o.total, o.order_date " +
                "FROM orders o INNER JOIN products p ON o.product_id = p.id ORDER BY o.order_date ASC");

            out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            out.println("<orders>");

            while (rs.next()) {
                out.println("  <order>");
                out.println("    <order_id>" + rs.getInt("order_id") + "</order_id>");
                out.println("    <username>" + rs.getString("username") + "</username>");
                out.println("    <product>" + rs.getString("product_name") + "</product>");
                out.println("    <quantity>" + rs.getInt("quantity") + "</quantity>");
                out.println("    <price>" + rs.getDouble("price") + "</price>");
                out.println("    <total>" + rs.getDouble("total") + "</total>");
                out.println("    <order_date>" + rs.getTimestamp("order_date") + "</order_date>");
                out.println("  </order>");
            }
            out.println("</orders>");

            con.close();
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
