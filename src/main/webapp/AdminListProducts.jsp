<%-- 
    Document   : AdminListProducts
    Created on : 24 Jun 2025, 4:24:54 am
    Author     : USER
--%>

<%@page import="java.util.List"%>
<%@page import="com.petshop.model.Product"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main_list.css">
   
</head>
<body>
    <jsp:include page="navAdmin.jsp" />
    <h1>Product List</h1>
    <a href="<%=request.getContextPath()%>/admin?action=new" class="button-primary">Add New Product</a>

    <table border="1">
        <tr>
            <th>Code</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price(RM)</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <% List<Product> products = (List<Product>) request.getAttribute("products");
           if (products != null) {
               for (Product product : products) { %>
                   <tr>
                       <td><%= product.getProductCode() %></td>
                       <td><%= product.getName() %></td>
                       <td><%= product.getDescription() %></td>
                       <td><%= product.getPrice() %></td>
                       <td><img src="data:image/jpeg;base64,<%= product.getBase64Image() %>" height="50" width="50"/></td>
                       <td>
                           <a href="${pageContext.request.contextPath}/admin?action=edit&product_code=<%= product.getProductCode() %>">Edit</a>
                           | <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                                 <input type="hidden" name="action" value="delete">
                                 <input type="hidden" name="product_code" value="<%= product.getProductCode() %>">
                                 <button type="submit" onclick="return confirm('Are you sure you want to delete this product?');">Delete</button>
                             </form>
                       </td>
                   </tr>
               <% }
           } else { %>
               <tr>
                   <td colspan="6">No products found</td>
               </tr>
           <% } %>
    </table>
    <footer>
        <p>Prepared by Group 8 | Azie-Hidayah-Nurjie-Syuhana.</p>
    </footer>
</body>
</html>
