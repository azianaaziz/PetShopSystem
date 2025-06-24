<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="shortcut icon" type="image/x-icon" href="img/cougar-clipart-bearcat.png">
    <meta http-equiv="X-UA-Compatible" content="IE-Edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pet Shop</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/feather-icons"></script>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/master.css"/>
    <script src="https://unpkg.com/feather-icons"></script>
    <style>
        .products .row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(30rem, 1fr));
        gap: 1.5rem;
        margin-top: 4rem;
      }

      .products .product-card {
        text-align: center;
        border: 1px solid #666;
        padding: 2rem;
      }
      .products .product-icons {
        display: flex;
        justify-content: center;
        gap: 0.5rem;
      }

      .products .product-icons a {
        width: 4rem;
        height: 4rem;
        color: #fff;
        margin: 0.3rem;
        border: 1px solid #666;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .products .product-icons a:hover {
        background-color: var(--primary);
        border: 1px solid var(--primary);
      }

      .products .product-image {
        padding: 1rem 0;
      }

      .products .product-image img {
        height: 25rem;
      }

      .products .product-content h3 {
        font-size: 2rem;
      }

      .products .product-stars {
        font-size: 1.7rem;
        padding: 0.8rem;
        color: var(--primary);
      }
      .products .product-stars .star-full {
        fill: var(--primary);
      }
    </style>
</head>
<body>
<jsp:include page="nav.jsp" />

<section class="products" id="products">
    <h2><span>Best </span>Products</h2>
    <p>"Introducing our premier pet product for your furry companion's care and happiness."</p>
    <div class="row">
        <%
            String url = "jdbc:mysql://switchback.proxy.rlwy.net:49496/petshop";
            String username = "root";
            String password = "CaxLOWsGEHcaUIMpeUqtCmLucuHVTNGS";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();
                String sql = "SELECT * FROM products";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String productCode = rs.getString("product_code");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    double price = rs.getDouble("price");
                    byte[] imageBytes = rs.getBytes("image");
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

        %>
        <div class='product-card'>
            <div class='product-icons'>
                <form action="paymentMethode.jsp" method="post">
                    <input type="hidden" name="name" value="<%= name %>">
                    <input type="hidden" name="price" value="<%= price %>">
                    <input type="hidden" name="image" value="<%= base64Image %>">
                    <button type="submit" title="Buy Now" class="item-detail-button">
                        <i data-feather="shopping-bag"></i>
                    </button>
                </form>
            </div>
            <div class='product-image'>
                <img src='data:image/jpeg;base64,<%= base64Image %>' alt='<%= name %>' />
            </div>
            <div class='product-content'>
                <h3><%= name %></h3>
                <div class='product-stars'>
                    <i data-feather='star' class='star-full'></i>
                    <i data-feather='star' class='star-full'></i>
                    <i data-feather='star' class='star-full'></i>
                    <i data-feather='star' class='star-full'></i>
                    <i data-feather='star'></i>
                </div>
                <div class='product-price'>RM <%= price %></div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script>
    feather.replace(); // Important to render feather icons properly
</script>
</body>
</html>
