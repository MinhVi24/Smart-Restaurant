package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.PaymentService;
import dao.PaymentDAO;
import dao.OrderDAO;
import dao.ReservationDAO;
import model.Payments;
import model.Orders;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * TEST ONLY - Endpoint để manually confirm payment cho testing
 * KHÔNG SỬ DỤNG TRONG PRODUCTION!
 */
@WebServlet(name = "TestConfirmPaymentController", urlPatterns = {"/test/confirm-payment"})
public class TestConfirmPaymentController extends HttpServlet {
    
    private PaymentService paymentService;
    private PaymentDAO paymentDAO;
    private OrderDAO orderDAO;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
        paymentDAO = new PaymentDAO();
        orderDAO = new OrderDAO();
        reservationDAO = new ReservationDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String paymentIdStr = request.getParameter("paymentId");
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Confirm Payment</title>");
        out.println("<style>");
        out.println("body { font-family: Arial; padding: 20px; }");
        out.println(".success { color: green; }");
        out.println(".error { color: red; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>🧪 TEST: Manual Payment Confirmation</h1>");
        out.println("<p><strong>⚠️ CHỈ SỬ DỤNG CHO TESTING!</strong></p>");
        
        if (paymentIdStr == null || paymentIdStr.isEmpty()) {
            out.println("<div class='error'>");
            out.println("<p>❌ Missing paymentId parameter</p>");
            out.println("<p>Usage: /test/confirm-payment?paymentId=123</p>");
            out.println("</div>");
        } else {
            try {
                Integer paymentId = Integer.parseInt(paymentIdStr);
                
                // Get payment
                Payments payment = paymentDAO.findById(paymentId);
                
                if (payment == null) {
                    out.println("<div class='error'>");
                    out.println("<p>❌ Payment not found: " + paymentId + "</p>");
                    out.println("</div>");
                } else {
                    out.println("<h2>Payment Information</h2>");
                    out.println("<ul>");
                    out.println("<li>Payment ID: " + payment.getPaymentId() + "</li>");
                    out.println("<li>Amount: " + payment.getAmount() + "</li>");
                    out.println("<li>Deposit Amount: " + payment.getDepositAmount() + "</li>");
                    out.println("<li>Current Status: " + payment.getPaymentStatus() + "</li>");
                    out.println("</ul>");
                    
                    if ("COMPLETED".equals(payment.getPaymentStatus())) {
                        out.println("<div class='success'>");
                        out.println("<p>✅ Payment already completed!</p>");
                        out.println("</div>");
                    } else {
                        // Manually confirm payment
                        out.println("<h2>Confirming Payment...</h2>");
                        
                        boolean updated = paymentService.updatePaymentStatus(paymentId, "COMPLETED");
                        
                        if (updated) {
                            out.println("<div class='success'>");
                            out.println("<p>✅ Payment status updated to COMPLETED</p>");
                            out.println("</div>");
                            
                            // Update order status
                            Orders order = payment.getOrderId();
                            if (order != null) {
                                order.setStatus("PAID");
                                orderDAO.update(order);
                                out.println("<div class='success'>");
                                out.println("<p>✅ Order status updated to PAID</p>");
                                out.println("</div>");
                                
                                // Update reservation status
                                if (order.getReservationId() != null) {
                                    boolean reservationUpdated = reservationDAO.updateStatus(
                                        order.getReservationId().getReservationId(), 
                                        "BOOKED"
                                    );
                                    if (reservationUpdated) {
                                        out.println("<div class='success'>");
                                        out.println("<p>✅ Reservation status updated to BOOKED</p>");
                                        out.println("</div>");
                                    } else {
                                        out.println("<div class='error'>");
                                        out.println("<p>❌ Failed to update reservation status</p>");
                                        out.println("</div>");
                                    }
                                }
                            }
                            
                            out.println("<hr>");
                            out.println("<h2>✅ All Done!</h2>");
                            out.println("<p>Payment has been manually confirmed for testing.</p>");
                            out.println("<p><a href='" + request.getContextPath() + "/booking/success'>View Booking Success Page</a></p>");
                            
                        } else {
                            out.println("<div class='error'>");
                            out.println("<p>❌ Failed to update payment status</p>");
                            out.println("</div>");
                        }
                    }
                }
                
            } catch (NumberFormatException e) {
                out.println("<div class='error'>");
                out.println("<p>❌ Invalid paymentId format: " + paymentIdStr + "</p>");
                out.println("</div>");
            } catch (Exception e) {
                out.println("<div class='error'>");
                out.println("<p>❌ Error: " + e.getMessage() + "</p>");
                out.println("<pre>");
                e.printStackTrace(out);
                out.println("</pre>");
                out.println("</div>");
            }
        }
        
        out.println("</body>");
        out.println("</html>");
    }
}
