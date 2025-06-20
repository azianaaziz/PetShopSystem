<%@ page import="java.sql.*" %>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/adminDashboard.css">
</head>
<body>
    <div class="container">
        <h1>Welcome, Admin!</h1>

        <h2>Dashboard Overview</h2>
        <%
            int totalProducts = 0;
            int totalPets = 0;

            try {
                Connection con = DbCon.getConnection();

                // Count Products
                String productQuery = "SELECT COUNT(*) FROM products";
                PreparedStatement pst1 = con.prepareStatement(productQuery);
                ResultSet rs1 = pst1.executeQuery();
                if(rs1.next()) totalProducts = rs1.getInt(1);

                // Count Pets
                String petQuery = "SELECT COUNT(*) FROM pets";
                PreparedStatement pst2 = con.prepareStatement(petQuery);
                ResultSet rs2 = pst2.executeQuery();
                if(rs2.next()) totalPets = rs2.getInt(1);

            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>

        <div class="stats">
            <div class="card">
                <h3>Total Products</h3>
                <p><%= totalProducts %></p>
            </div>
            <div class="card">
                <h3>Total Pets</h3>
                <p><%= totalPets %></p>
            </div>
        </div>

        <h2>Quick Actions</h2>
        <div class="actions">
            <a href="AdminAddProduct.jsp">Add Product</a>
            <a href="AdminListProducts.jsp">View Products</a>
            <a href="AdminListPets.jsp">View Pets</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
</body>
</html>
