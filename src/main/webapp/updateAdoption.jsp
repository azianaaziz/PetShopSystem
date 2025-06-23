<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main_list.css">
    
    <title>Update Adoption - Admin</title>
    <link rel="stylesheet" href="css/updateAdoption.css" />
</head>
<body>

<jsp:include page="navAdmin.jsp" />
<h1>Adoption Pet List</h1>

<table>
    <thead>
        <tr>
            <th>Pet ID</th>
            <th>Name</th>
            <th>Title</th>
            <th>Details</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            String jdbcURL = "jdbc:mysql://switchback.proxy.rlwy.net:49496/petshop";
            String jdbcUsername = "root";
            String jdbcPassword = "CaxLOWsGEHcaUIMpeUqtCmLucuHVTNGS";

            Connection connection = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                String sql = "SELECT * FROM pets";
                ps = connection.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String title = rs.getString("title");
                    String details = rs.getString("details");
                    String image = rs.getString("image");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= title %></td>
            <td><%= details %></td>
            <td><img src="<%= request.getContextPath() + "/" + image %>" alt="<%= title %>" width="80"></td>
            <td>
                <form action="DeletePetServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this pet?');">
                    <input type="hidden" name="id" value="<%= id %>"/>
                    <button type="submit" class="btn-delete">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
                try { if (ps != null) ps.close(); } catch (SQLException ignore) {}
                try { if (connection != null) connection.close(); } catch (SQLException ignore) {}
            }
        %>
    </tbody>
</table>

<footer>
    <p>Prepared by Group 8 | Azie-Hidayah-Nurjie-Syuhana.</p>
</footer>

</body>
</html>
