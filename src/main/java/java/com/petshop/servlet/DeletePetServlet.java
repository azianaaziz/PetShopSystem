package com.petshop.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeletePetServlet")
public class DeletePetServlet extends HttpServlet {
    private String jdbcURL = "jdbc:mysql://switchback.proxy.rlwy.net:49496/petshop";
    private String jdbcUsername = "root";
    private String jdbcPassword = "CaxLOWsGEHcaUIMpeUqtCmLucuHVTNGS";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int petId = Integer.parseInt(request.getParameter("id"));
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "DELETE FROM pets WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, petId);
            stmt.executeUpdate();

            stmt.close();
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("updateAdoption.jsp");
    }
}
