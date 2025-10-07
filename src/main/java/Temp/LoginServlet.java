package Temp;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            String table = role.equals("admin") ? "login" : "register";
            String sql = "SELECT * FROM " + table + " WHERE name=? AND password=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                if(role.equals("admin")) {
                    session.setAttribute("admin", username);
                    response.sendRedirect("admin_manage.jsp"); 
                } else {
                    session.setAttribute("username", username);
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.getWriter().println("<script>alert('Invalid credentials'); window.location='login.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception ignore) {}
            if (ps != null) try { ps.close(); } catch(Exception ignore) {}
            if (con != null) try { con.close(); } catch(Exception ignore) {}
        }
    }
}

