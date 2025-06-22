package cn.techtutorial.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import cn.techtutorial.model.Cart;

@WebServlet(name = "AddToCartServlet", urlPatterns = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productCode = request.getParameter("productCode");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        HttpSession session = request.getSession();
        ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");

        if (cartList == null) {
            cartList = new ArrayList<>();
            Cart cartItem = new Cart();
            cartItem.setProductCode(productCode);
            cartItem.setName(name);
            cartItem.setPrice(price);
            cartItem.setQuantity(1);
            cartList.add(cartItem);
            session.setAttribute("cart-list", cartList);
        } else {
            boolean exist = false;
            for (Cart c : cartList) {
                if (c.getProductCode().equals(productCode)) {
                    exist = true;
                    c.setQuantity(c.getQuantity() + 1);
                    break;
                }
            }
            if (!exist) {
                Cart cartItem = new Cart();
                cartItem.setProductCode(productCode);
                cartItem.setName(name);
                cartItem.setPrice(price);
                cartItem.setQuantity(1);
                cartList.add(cartItem);
            }
        }
        response.sendRedirect("products.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
