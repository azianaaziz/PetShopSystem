package com.petshop.servlet;

import com.petshop.model.PaymentDAO;
import com.petshop.model.PaymentModel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine which form submitted this POST request
        String cardNumber = request.getParameter("cardnumber");
        String productCode = request.getParameter("productCode");

        HttpSession session = request.getSession();

        if (productCode != null) {
            // User clicked the shopping bag icon on products.jsp
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String image = request.getParameter("image");

            // Store product details in session to show on paymentMethode.jsp
            session.setAttribute("productCode", productCode);
            session.setAttribute("name", name);
            session.setAttribute("price", price);
            session.setAttribute("image", image);

            // Redirect to Payment Methode page
            response.sendRedirect("paymentMethode.jsp");
        } else if (cardNumber != null) {
            // User submitted the payment form from paymentMethode.jsp
            String expiry = request.getParameter("expiry");
            String cardName = request.getParameter("cardname");
            boolean sameAddress = request.getParameter("checked-same-address") != null;

            // Save payment details
            PaymentModel payment = new PaymentModel(cardNumber, expiry, cardName, sameAddress);
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.savePayment(payment);

            // Optionally clear product details after payment
            session.removeAttribute("productCode");
            session.removeAttribute("name");
            session.removeAttribute("price");
            session.removeAttribute("image");

            // Redirect to success page
            response.sendRedirect("PaymentSuccess.jsp");
        } else {
            // Invalid access - redirect to home or error page
            response.sendRedirect("products.jsp");
        }
    }
}
