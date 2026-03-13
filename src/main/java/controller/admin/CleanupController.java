package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ReservationCleanupService;
import java.io.IOException;

/**
 * Admin controller to manually trigger reservation cleanup
 * URL: /admin/cleanup
 */
@WebServlet(name = "CleanupController", urlPatterns = {"/admin/cleanup"})
public class CleanupController extends HttpServlet {
    
    private ReservationCleanupService cleanupService;
    
    @Override
    public void init() throws ServletException {
        cleanupService = new ReservationCleanupService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("run".equals(action)) {
            runCleanup(request, response);
        } else {
            showCleanupPage(request, response);
        }
    }
    
    /**
     * Show cleanup status page
     */
    private void showCleanupPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int oldReservationCount = cleanupService.getOldReservationCount();
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>");
        html.append("<html><head>");
        html.append("<title>Reservation Cleanup</title>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; margin: 40px; }");
        html.append(".container { max-width: 600px; margin: 0 auto; }");
        html.append(".status { padding: 20px; background: #f0f0f0; border-radius: 5px; margin: 20px 0; }");
        html.append(".button { display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; }");
        html.append(".button:hover { background: #0056b3; }");
        html.append(".warning { color: #ff6600; font-weight: bold; }");
        html.append(".success { color: #28a745; font-weight: bold; }");
        html.append("</style>");
        html.append("</head><body>");
        html.append("<div class='container'>");
        html.append("<h1>Reservation Cleanup</h1>");
        html.append("<div class='status'>");
        html.append("<h2>Status</h2>");
        
        if (oldReservationCount > 0) {
            html.append("<p class='warning'>Found " + oldReservationCount + " old reservations that need cleanup</p>");
            html.append("<p>These are reservations from past dates that are still marked as PENDING, BOOKED, or CONFIRMED.</p>");
            html.append("<p>They may be blocking table availability for new bookings.</p>");
        } else {
            html.append("<p class='success'>No old reservations found. Database is clean!</p>");
        }
        
        html.append("</div>");
        
        if (oldReservationCount > 0) {
            html.append("<a href='?action=run' class='button'>Run Cleanup Now</a>");
        }
        
        html.append("<p><a href='../booking'>Back to Booking</a></p>");
        html.append("</div>");
        html.append("</body></html>");
        
        response.getWriter().write(html.toString());
    }
    
    /**
     * Run cleanup and show results
     */
    private void runCleanup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int cleanedCount = cleanupService.cleanupOldReservations();
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>");
        html.append("<html><head>");
        html.append("<title>Cleanup Results</title>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; margin: 40px; }");
        html.append(".container { max-width: 600px; margin: 0 auto; }");
        html.append(".result { padding: 20px; background: #d4edda; border: 1px solid #c3e6cb; border-radius: 5px; margin: 20px 0; }");
        html.append(".button { display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; margin-top: 20px; }");
        html.append("</style>");
        html.append("</head><body>");
        html.append("<div class='container'>");
        html.append("<h1>Cleanup Complete</h1>");
        html.append("<div class='result'>");
        html.append("<h2>Results</h2>");
        html.append("<p>Successfully cleaned up <strong>" + cleanedCount + "</strong> old reservations.</p>");
        html.append("<p>Tables have been released and are now available for new bookings.</p>");
        html.append("</div>");
        html.append("<a href='?' class='button'>Check Status Again</a>");
        html.append("<p><a href='../booking'>Back to Booking</a></p>");
        html.append("</div>");
        html.append("</body></html>");
        
        response.getWriter().write(html.toString());
    }
}
