package controller.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.BookingService;
import model.Reservations;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookingHistoryController", urlPatterns = {"/bookings/history"})
public class BookingHistoryController extends HttpServlet {
    
    private BookingService bookingService;
    
    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        
        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Load booking history
        List<Reservations> reservations = bookingService.getCustomerReservations(customerId);
        request.setAttribute("reservations", reservations);
        
        request.getRequestDispatcher("/views/custumer/booking/booking-history.jsp").forward(request, response);
    }
}
