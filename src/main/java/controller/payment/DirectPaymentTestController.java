package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Controller để test trực tiếp Payment QR
 * Bỏ qua việc tạo reservation trong database
 */
@WebServlet(name = "DirectPaymentTestController", urlPatterns = {"/test-payment-direct"})
public class DirectPaymentTestController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            // Tạo fake customer
            Customers customer = new Customers();
            customer.setCustomerId(1);
            customer.setFullName("TRAN MINH VI");
            
            // Tạo fake table
            Tables table = new Tables();
            table.setTableId(3);
            
            // Tạo fake reservation
            Reservations reservation = new Reservations();
            reservation.setReservationId(3);
            reservation.setCustomerId(customer);
            reservation.setTableId(table);
            reservation.setReservationTime(new Date());
            reservation.setGuestCount(2);
            reservation.setStatus("PENDING");
            
            // Tạo fake order
            Orders order = new Orders();
            order.setOrderId(3);
            order.setCustomerId(customer);
            order.setTableId(table);
            order.setReservationId(reservation);
            order.setOrderTime(new Date());
            order.setTotalAmount(new BigDecimal("10000")); // Changed to 10,000đ for testing
            order.setStatus("PENDING");
            
            // Tạo fake payment
            Payments payment = new Payments();
            payment.setPaymentId(3);
            payment.setOrderId(order);
            payment.setAmount(new BigDecimal("10000")); // Changed to 10,000đ
            payment.setDepositAmount(new BigDecimal("10000")); // Changed to 10,000đ
            payment.setRemainingAmount(BigDecimal.ZERO);
            payment.setDepositPercentage(100);
            payment.setPaymentMethod("QR");
            payment.setPaymentStatus("PENDING");
            payment.setPaymentTime(new Date());
            
            // Lưu vào session
            session.setAttribute("reservation", reservation);
            session.setAttribute("order", order);
            session.setAttribute("payment", payment);
            
            System.out.println("=== TEST PAYMENT DIRECT ===");
            System.out.println("Created fake data:");
            System.out.println("Order ID: " + order.getOrderId());
            System.out.println("Payment ID: " + payment.getPaymentId());
            System.out.println("Amount: " + payment.getDepositAmount());
            System.out.println("Customer: " + customer.getFullName());
            System.out.println("Redirecting to /payment/qr...");
            
            // Redirect đến payment QR
            response.sendRedirect(request.getContextPath() + "/payment/qr");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/test-payment-flow.jsp?error=" + e.getMessage());
        }
    }
}
