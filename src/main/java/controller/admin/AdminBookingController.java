package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.BookingService;
import model.Tables;
import model.Users;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBookingController", urlPatterns = {"/admin/bookings"})
public class AdminBookingController extends HttpServlet {
    
    private BookingService bookingService;
    
    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("loggedInUser");
        
        // Check if user is admin or staff
        if (user == null || (!"ADMIN".equals(user.getRole()) && !"STAFF".equals(user.getRole()))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "dashboard";
        }
        
        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "updateStatus":
                updateTableStatus(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateTableStatus(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }
    
    /**
     * Show admin booking dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String area = request.getParameter("area");
        
        List<Tables> tables;
        
        if (area != null && !area.isEmpty()) {
            tables = bookingService.getAvailableTablesByArea(area);
        } else {
            // Get ALL tables (not just available) for admin
            tables = bookingService.getAllTables();
        }
        
        request.setAttribute("tables", tables);
        request.getRequestDispatcher("/views/admin/booking/admin-booking-dashboard.jsp").forward(request, response);
    }
    
    /**
     * Update table status (Admin only)
     */
    private void updateTableStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tableIdStr = request.getParameter("tableId");
        String status = request.getParameter("status");
        
        if (tableIdStr == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings?error=missing_params");
            return;
        }
        
        try {
            Integer tableId = Integer.parseInt(tableIdStr);
            
            // Update table status
            boolean success = bookingService.updateTableStatus(tableId, status);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/bookings?success=status_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/bookings?error=update_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings?error=invalid_params");
        }
    }
}
