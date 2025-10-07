package Temp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String feedback = request.getParameter("feedback");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Data_128", "root", "6382501831u");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO register (name, age, gender, email, password, feedback) VALUES (?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, name);
            ps.setString(2, age);
            ps.setString(3, gender);
            ps.setString(4, email);
            ps.setString(5, password);
            ps.setString(6, feedback);

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            } else {
                out.println("<h2><font color=red> Registration Failed! Please try again.</font></h2>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2><font color=red> Error: " + e.getMessage() + "</font></h2>");
        }
    }
}
