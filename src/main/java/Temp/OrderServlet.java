package Temp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String productIdStr = request.getParameter("product_id");
        String quantityStr = request.getParameter("quantity");
        String priceStr = request.getParameter("price");

        // Check for missing fields
        if (user == null || productIdStr == null || quantityStr == null || priceStr == null) {
            response.getWriter().println("<h3>Error: Missing form fields.</h3>");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        int quantity = Integer.parseInt(quantityStr);
        double price = Double.parseDouble(priceStr);
        double total = price * quantity;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            // Check stock
            ps = con.prepareStatement("SELECT stock, name FROM products WHERE id=?");
            ps.setInt(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                int stock = rs.getInt("stock");
                String itemName = rs.getString("name");

                if (stock >= quantity) {
                    // Insert order
                    PreparedStatement insert = con.prepareStatement(
                        "INSERT INTO orders (username, product_id, quantity, price, total) VALUES (?, ?, ?, ?, ?)"
                    );
                    insert.setString(1, user);
                    insert.setInt(2, productId);
                    insert.setInt(3, quantity);
                    insert.setDouble(4, price);
                    insert.setDouble(5, total);
                    insert.executeUpdate();

                    // Update stock
                    PreparedStatement updateStock = con.prepareStatement(
                        "UPDATE products SET stock=? WHERE id=?"
                    );
                    updateStock.setInt(1, stock - quantity);
                    updateStock.setInt(2, productId);
                    updateStock.executeUpdate();

                    // Remove from cart
                    PreparedStatement deleteCart = con.prepareStatement(
                        "DELETE FROM cart WHERE username=? AND item=?"
                    );
                    deleteCart.setString(1, user);
                    deleteCart.setString(2, itemName);
                    deleteCart.executeUpdate();

                    // Forward to confirmation
                    request.setAttribute("user", user);
                    request.setAttribute("item", itemName);
                    request.setAttribute("quantity", quantity);
                    request.setAttribute("total", total);

                    RequestDispatcher rd = request.getRequestDispatcher("confirmation.jsp");
                    rd.forward(request, response);

                } else {
                    response.getWriter().println("<h3>Not enough stock. Only " + stock + " items available.</h3>");
                }
            } else {
                response.getWriter().println("<h3>Product not found.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
