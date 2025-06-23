<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Update Adoption - Admin</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/master.css" />
    <script src="https://unpkg.com/feather-icons"></script>
    <style>
        body {
            background-color: black;
            color: white;
            font-family: 'Poppins', sans-serif;
        }
        .menu-card {
            border-radius: 10%;
            margin: 20px;
            max-width: 300px;
            text-align: center;
            background-color: #222;
            padding: 10px;
        }
        .menu-card img {
            width: 100%;
            height: 200px;
            border-radius: 10%;
            object-fit: cover;
        }
        .btn-delete {
            background-color: #b63838;
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        .btn-delete:hover {
            background-color: #992626;
        }
    </style>
</head>
<body>

    <section id="shop" class="menu">
        <h2><span>Manage</span> Adoption Pets</h2>
        <div class="row">
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
            <div class="menu-card">
                <img src="<%= request.getContextPath() + "/" + image %>" alt="<%= title %>" />
                <h2>- <%= name %> -</h2>
                <h3><%= title %></h3>
                <p><%= details %></p>
                <form action="DeletePetServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this pet?');">
                    <input type="hidden" name="id" value="<%= id %>"/>
                    <button type="submit" class="btn-delete">Delete</button>
                </form>
            </div>
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
        </div>
    </section>

    <script>feather.replace();</script>
</body>
</html>
