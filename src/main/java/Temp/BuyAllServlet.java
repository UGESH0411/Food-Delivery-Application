package Temp;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BuyAllServlet")
public class BuyAllServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        Connection con = null;
        PreparedStatement ps = null, psInsert = null, psUpdate = null;
        ResultSet rs = null;

        List<OrderItem> orderItems = new ArrayList<>();
        double grandTotal = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            // 1️⃣ Get all cart items for the user
            ps = con.prepareStatement("SELECT * FROM cart WHERE username=?");
            ps.setString(1, username);
            rs = ps.executeQuery();

            while (rs.next()) {
                int cartId = rs.getInt("id");
                String item = rs.getString("item");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                double total = rs.getDouble("total");

                // 2️⃣ Get product_id and stock
                PreparedStatement psProduct = con.prepareStatement("SELECT id, stock FROM products WHERE name=?");
                psProduct.setString(1, item);
                ResultSet rsProduct = psProduct.executeQuery();

                if (rsProduct.next()) {
                    int productId = rsProduct.getInt("id");
                    int stock = rsProduct.getInt("stock");

                    if (stock >= quantity) {
                        // 3️⃣ Insert into orders
                        psInsert = con.prepareStatement(
                            "INSERT INTO orders (username, product_id, quantity, price, total) VALUES (?, ?, ?, ?, ?)");
                        psInsert.setString(1, username);
                        psInsert.setInt(2, productId);
                        psInsert.setInt(3, quantity);
                        psInsert.setDouble(4, price);
                        psInsert.setDouble(5, total);
                        psInsert.executeUpdate();

                        // 4️⃣ Update stock
                        psUpdate = con.prepareStatement("UPDATE products SET stock=? WHERE id=?");
                        psUpdate.setInt(1, stock - quantity);
                        psUpdate.setInt(2, productId);
                        psUpdate.executeUpdate();

                        // 5️⃣ Add to orderItems list
                        orderItems.add(new OrderItem(item, quantity, price, total));
                        grandTotal += total;

                    } else {
                        System.out.println("Item " + item + " does not have enough stock.");
                    }
                }
                rsProduct.close();
                psProduct.close();
            }

            // 6️⃣ Clear cart after order
            PreparedStatement psDelete = con.prepareStatement("DELETE FROM cart WHERE username=?");
            psDelete.setString(1, username);
            psDelete.executeUpdate();

            // 7️⃣ Forward to orderSuccess.jsp
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("grandTotal", grandTotal);
            request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (psInsert != null) psInsert.close(); } catch (Exception ignored) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
