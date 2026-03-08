package controller.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.BookingService;
import java.io.IOException;

@WebServlet(name = "BookingSuccessController", urlPatterns = {"/booking/success"})
public class BookingSuccessController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        BookingService.BookingResult bookingResult = 
            (BookingService.BookingResult) session.getAttribute("bookingResult");
        
        if (bookingResult == null) {
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }
        
        // IMPORTANT: Query lại payment từ database để lấy status mới nhất
        // Vì payment status có thể đã được update từ PENDING -> COMPLETED
        dao.PaymentDAO paymentDAO = new dao.PaymentDAO();
        model.Payments latestPayment = paymentDAO.findById(bookingResult.getPayment().getPaymentId());
        
        if (latestPayment != null) {
            System.out.println("[BookingSuccess] Payment status updated: " + 
                bookingResult.getPayment().getPaymentStatus() + " -> " + latestPayment.getPaymentStatus());
        }
        
        request.setAttribute("reservation", bookingResult.getReservation());
        request.setAttribute("order", bookingResult.getOrder());
        request.setAttribute("payment", latestPayment != null ? latestPayment : bookingResult.getPayment());
        
        // Clear all booking session data after showing success
        session.removeAttribute("bookingResult");
        session.removeAttribute("reservation");
        session.removeAttribute("order");
        session.removeAttribute("payment");
        session.removeAttribute("selectedTableId");
        session.removeAttribute("bookingDate");
        session.removeAttribute("bookingTime");
        session.removeAttribute("guestCount");
        session.removeAttribute("cart");
        
        request.getRequestDispatcher("/views/custumer/booking/success-booking.jsp").forward(request, response);
    }
}
