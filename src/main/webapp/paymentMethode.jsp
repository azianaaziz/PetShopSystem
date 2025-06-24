<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="shortcut icon" type="image/x-icon" href="img/cougar-clipart-bearcat.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pet Shop - Payment Method</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,300;0,400;0,700;1,700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/feather-icons"></script>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/master.css"/>
    <style>
        body {
            background-color: #0f0f0f;
            color: #d9d9d9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        main {
            max-width: 720px;
            margin: 0 auto 50px auto;
            padding: 0 20px 50px 20px;
        }
        h1, h2 {
            color: #fff;
        }
        p.subtitle {
            color: #c6c6c6;
            margin-bottom: 24px;
        }
        .payment-methods {
            display: flex;
            gap: 12px;
            margin-bottom: 30px;
        }
        .payment-methods button {
            padding: 10px 24px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }
        .selected {
            background-color: #c59a6d;
            color: #1b1b1b;
        }
        .unselected {
            background-color: #fff;
            color: #000;
        }
        .form-field {
            margin-bottom: 16px;
        }
        input[type="text"] {
            padding: 8px 10px;
            border-radius: 6px;
            border: none;
            width: 200px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            color: white;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .btn-container {
            margin-top: 30px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }
        .btn-prev, .btn-next {
            background-color: #c75a00;
            color: white;
            padding: 10px 28px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn-prev:hover, .btn-next:hover {
            background-color: #de7000;
        }
    </style>
</head>
<body>
<%
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String image = request.getParameter("image");
%>

<h1>Payment Page</h1>

<h2>Product You Selected:</h2>
<% if (name != null && price != null && image != null) { %>
    <table border="1">
        <tr>
            <th>Image</th>
            <th>Name</th>
            <th>Price (RM)</th>
        </tr>
        <tr>
            <td><img src="data:image/jpeg;base64,<%= image %>" width="100" /></td>
            <td><%= name %></td>
            <td>RM <%= price %></td>
        </tr>
    </table>
<% } else { %>
    <p>No product selected.</p>
<% } %>

    <!-- Payment Method Buttons -->
    <div>
        <strong>Payment Method</strong>
        <div class="payment-methods">
            <button id="btn-credit" class="selected" type="button">Credit Card</button>
            <button id="btn-paypal" class="unselected" type="button">PayPal</button>
            <button id="btn-cod" class="unselected" type="button">Cash On Delivery</button>
        </div>
    </div>

    <!-- Payment Form -->
    <form id="payment-form" autocomplete="off" novalidate>
        <div class="form-field" id="field-cardnumber">
            <label for="cardnumber"><strong>Card Number</strong></label>
            <input type="text" id="cardnumber" placeholder="1234 5678 9101 2345" maxlength="19" />
        </div>
        <div class="form-field" id="field-expired">
            <label for="expiry"><strong>Expired</strong></label>
            <input type="text" id="expiry" placeholder="MM/YY" maxlength="5" />
        </div>
        <div class="form-field" id="field-name">
            <label for="cardname"><strong>Cardholder Name</strong></label>
            <input type="text" id="cardname" placeholder="Name on Card" />
        </div>
        <div class="checkbox-field">
            <input type="checkbox" id="checked-same-address" />
            <label for="checked-same-address">Billing address same as delivery address</label>
        </div>
    </form>

    <!-- Navigation Buttons -->
    <div class="btn-container">
        <button class="btn-prev" onclick="history.back();">Previous</button>
        <button class="btn-next" onclick="alert('Payment Successful!')">Finish</button>
    </div>
</main>

<script>
    const buttons = {
        credit: document.getElementById('btn-credit'),
        paypal: document.getElementById('btn-paypal'),
        cod: document.getElementById('btn-cod'),
    };

    const fieldCard = document.getElementById('field-cardnumber');
    const fieldExp = document.getElementById('field-expired');
    const fieldName = document.getElementById('field-name');

    function selectPayment(method) {
        Object.values(buttons).forEach(btn => {
            btn.classList.remove('selected');
            btn.classList.add('unselected');
        });
        buttons[method].classList.remove('unselected');
        buttons[method].classList.add('selected');

        if (method === 'credit') {
            fieldCard.style.display = 'block';
            fieldExp.style.display = 'block';
            fieldName.style.display = 'block';
        } else {
            fieldCard.style.display = 'none';
            fieldExp.style.display = 'none';
            fieldName.style.display = 'none';
        }
    }

    buttons.credit.addEventListener('click', () => selectPayment('credit'));
    buttons.paypal.addEventListener('click', () => selectPayment('paypal'));
    buttons.cod.addEventListener('click', () => selectPayment('cod'));

    selectPayment('credit');
</script>
</body>
</html>
