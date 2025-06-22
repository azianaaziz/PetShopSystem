<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%
    List<Cart> cartList = (List<Cart>) session.getAttribute("cart-list");
    if(cartList == null) {
        cartList = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/master.css">
    <style>
        body {
            background-image: url("img/kucing1.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-color: black;
            color: white;
            font-family: Arial, sans-serif;
        }

        .cart-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(0,0,0,0.7);
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
            color: white;
        }

        .cart-container h2 {
            text-align: center;
            color: white;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            color: white;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ccc;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        th {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }

        form {
            display: inline;
        }

        button {
            padding: 5px 10px;
            margin: 2px;
            background-color: var(--primary);
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #a6764a;
        }

        .checkout-btn {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .checkout-btn:hover {
            background-color: #a6764a;
        }

        .empty-message {
            text-align: center;
            color: white;
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <h2>Your Cart</h2>

        <% if(!cartList.isEmpty()) { %>
            <table>
                <tr>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price (RM)</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
                <% for(Cart c : cartList) { %>
                <tr>
                    <td><%= c.getName() %></td>
                    <td><%= c.getCategory() %></td>
                    <td><%= c.getPrice() %></td>
                    <td><%= c.getQuantity() %></td>
                    <td>
                        <form action="checkout-servlet" method="post">
                            <input type="hidden" name="action" value="increase">
                            <input type="hidden" name="productCode" value="<%= c.getProductCode() %>">
                            <button type="submit">+</button>
                        </form>
                        <form action="checkout-servlet" method="post">
                            <input type="hidden" name="action" value="decrease">
                            <input type="hidden" name="productCode" value="<%= c.getProductCode() %>">
                            <button type="submit">-</button>
                        </form>
                        <form action="checkout-servlet" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productCode" value="<%= c.getProductCode() %>">
                            <button type="submit">Remove</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
            <form action="checkout-servlet" method="post">
                <input type="hidden" name="action" value="checkout">
                <button type="submit" class="checkout-btn">Checkout All Items</button>
            </form>
        <% } else { %>
            <p class="empty-message">Your cart is empty.</p>
        <% } %>
    </div>
</body>
</html>
