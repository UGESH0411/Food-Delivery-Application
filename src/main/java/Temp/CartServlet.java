package Temp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String item = request.getParameter("item");
        String qtyStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Null checks
        if (user == null || item == null || qtyStr == null || priceStr == null) {
            out.println("<h3>Error: Missing form fields. Check your Add to Cart form.</h3>");
            return;
        }

        try {
            int quantity = Integer.parseInt(qtyStr);
            double price = Double.parseDouble(priceStr);
            double total = price * quantity;

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            // Check stock in products table
            String checkStock = "SELECT stock FROM products WHERE name=?";
            PreparedStatement psCheck = con.prepareStatement(checkStock);
            psCheck.setString(1, item);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int availableStock = rs.getInt("stock");
                if (availableStock >= quantity) {
                    // Insert into cart
                    String sql = "INSERT INTO cart (username, item, price, quantity, total) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, user);
                    ps.setString(2, item);
                    ps.setDouble(3, price);
                    ps.setInt(4, quantity);
                    ps.setDouble(5, total);

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("viewCart.jsp");
                    } else {
                        out.println("<h3>Error adding to cart.</h3>");
                    }
                } else {
                    out.println("<h3>Only " + availableStock + " items left in stock.</h3>");
                }
            } else {
                out.println("<h3>Item not found.</h3>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
