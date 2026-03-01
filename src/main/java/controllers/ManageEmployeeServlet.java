package controllers;

import util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/manageEmployee")
public class ManageEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empId = Integer.parseInt(request.getParameter("empId"));
        String name = request.getParameter("empName");
        double salary = Double.parseDouble(request.getParameter("salary"));

        String query = "INSERT INTO employee (emp_id, emp_name, salary) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, empId);
            pstmt.setString(2, name);
            pstmt.setDouble(3, salary);
            if (pstmt.executeUpdate() > 0) {
                response.sendRedirect("adminDashboard?success=Employee+added+successfully");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("adminDashboard?error=Failed+to+add+employee");
    }
}
