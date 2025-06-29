<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navAdmin.css">
<script src="https://unpkg.com/feather-icons"></script>
<style>
    /* navAdmin.css */
    .navbar {
    width: 100%;
    position: relative;
    top: 0;
    left: 0;
    background-color: #121212;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 30px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    box-sizing: border-box;
    z-index: 1000;
    }   

    .navbar-logo {
        font-size: 24px;
        font-weight: 700;
        color: #b6895b;
        text-decoration: none;
        font-family: 'Poppins', sans-serif;
    }

    .navbar-logo span {
        color: #ffffff; /* 'Admin' part in white */
    }

    .navbar-nav {
        display: flex;
        gap: 25px;
    }

    .navbar-nav a {
        color: #f4f4f4;
        text-decoration: none;
        font-weight: 400;
        padding: 8px 16px;
        border-radius: 5px;
        transition: background 0.3s ease, color 0.3s ease;
        font-family: 'Poppins', sans-serif;
    }

    .navbar-nav a:hover {
        background-color: #b6895b;
        color: #fff;
    }

    .navbar-extra {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .hover-menu {
        position: relative;
        display: inline-block;
    }

    .hover-menu:hover .hover-menu-content,
    .hover-menu:focus-within .hover-menu-content {
        display: block; /* stays open when focus or hover */
    }

    .hover-menu-content {
        display: none;
        position: absolute;
        right: 0;
        background-color: black;
        min-width: 140px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        z-index: 999;
        border-radius: 5px;
        overflow: hidden;
    }

    .hover-menu-content a {
        color: white;
        padding: 10px 16px;
        display: block;
        text-decoration: none;
    }

    .hover-menu-content a:hover {
        background-color: #333;
    }

</style>
<nav class="navbar">
    <a href="#" class="navbar-logo">Pet<span>Shop Admin</span></a>
    <div class="navbar-nav">
        <a href="${pageContext.request.contextPath}/adminproductlist">Product List</a>
        <a href="AdminAddProduct.jsp">Add Product</a>
        <a href="updateAdoption.jsp">Update Adoption</a>
    </div>
    <div class="navbar-extra">
        <div class="hover-menu">
        <a href="#" id="user-button" tabindex="0"><i data-feather="user"></i></a>
        <div class="hover-menu-content">
            <% if (session.getAttribute("adminUsername") == null) { %>
                <a href="admin-login.jsp">Admin Login</a>
            <% } else { %>
                <a href="LogoutServlet">Logout</a>
            <% } %>
        </div>
    </div>
    </div>
</nav>

<script>feather.replace();</script>
