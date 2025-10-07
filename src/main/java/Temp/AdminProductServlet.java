package Temp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminProductServlet")
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u")) {

                if ("add".equals(action)) {
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    int price = Integer.parseInt(request.getParameter("price"));
                    int stock = Integer.parseInt(request.getParameter("stock"));
                    String image = request.getParameter("image"); // just path

                    String sql = "INSERT INTO products (name, description, price, stock, image) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setString(1, name);
                        ps.setString(2, description);
                        ps.setInt(3, price);
                        ps.setInt(4, stock);
                        ps.setString(5, image);

                        int rows = ps.executeUpdate();
                        if (rows > 0)
                            response.sendRedirect("admin_manage.jsp?msg=success");
                        else
                            response.sendRedirect("admin_manage.jsp?msg=failed");
                    }

                } else if ("update_stock".equals(action)) {
                    int productId = Integer.parseInt(request.getParameter("product_id"));
                    int stockChange = Integer.parseInt(request.getParameter("stock_change"));

                    String sql = "UPDATE products SET stock = stock + ? WHERE id = ?";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        ps.setInt(1, stockChange);
                        ps.setInt(2, productId);
                        ps.executeUpdate();
                        response.sendRedirect("admin_manage.jsp?msg=stock_updated");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_manage.jsp?msg=error");
        }
    }
}
