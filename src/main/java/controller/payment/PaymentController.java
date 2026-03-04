package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Reservations;
import model.Orders;
import model.Payments;
import java.io.IOException;

@WebServlet(name = "PaymentController", urlPatterns = {"/payment/qr"})
public class PaymentController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get booking result from session
        Reservations reservation = (Reservations) session.getAttribute("reservation");
        Orders order = (Orders) session.getAttribute("order");
        Payments payment = (Payments) session.getAttribute("payment");
        
        if (reservation == null || order == null || payment == null) {
            // No booking data, redirect to booking page
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }
        
        // Set attributes for JSP
        request.setAttribute("reservation", reservation);
        request.setAttribute("order", order);
        request.setAttribute("payment", payment);
        
        // Forward to payment QR page
        request.getRequestDispatcher("/views/custumer/payment/payment-qr.jsp").forward(request, response);
    }
}
