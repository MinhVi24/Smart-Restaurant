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
        
        request.setAttribute("reservation", bookingResult.getReservation());
        request.setAttribute("order", bookingResult.getOrder());
        request.setAttribute("payment", bookingResult.getPayment());
        
        request.getRequestDispatcher("/views/custumer/booking/success-booking.jsp").forward(request, response);
    }
}
