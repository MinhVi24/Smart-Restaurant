package controller.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.BookingService;
import model.Tables;
import model.Customers;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BookingController", urlPatterns = {"/booking"})
public class BookingController extends HttpServlet {
    
    private BookingService bookingService;
    
    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                showBookingPage(request, response);
                break;
            case "menu":
                showMenuSelection(request, response);
                break;
            case "filterTables":
                filterTablesAjax(request, response);
                break;
            default:
                showBookingPage(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("selectTable".equals(action)) {
            selectTable(request, response);
        } else if ("saveCart".equals(action)) {
            saveCart(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/booking");
        }
    }
    
    /**
     * Show booking page with available tables
     */
    private void showBookingPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load ALL tables (we'll filter on frontend based on date/time)
        List<Tables> tables = bookingService.getAllTables();
        
        request.setAttribute("tables", tables);
        request.getRequestDispatcher("/views/custumer/booking/booking.jsp").forward(request, response);
    }
    
    /**
     * AJAX endpoint to filter tables by date/time/capacity
     */
    private void filterTablesAjax(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dateStr = request.getParameter("date");
        String timeStr = request.getParameter("time");
        String guestCountStr = request.getParameter("guestCount");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            if (dateStr == null || timeStr == null || guestCountStr == null) {
                response.getWriter().write("{\"success\":false,\"error\":\"Missing parameters\"}");
                return;
            }
            
            // Parse date and time
            String dateTimeStr = dateStr + " " + timeStr + ":00";
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date reservationTime = sdf.parse(dateTimeStr);
            int guestCount = Integer.parseInt(guestCountStr);
            
            // Get available tables for this date/time
            List<Tables> availableTables = bookingService.getAvailableTablesForDateTime(reservationTime, guestCount);
            
            // Build JSON response with available table IDs
            StringBuilder json = new StringBuilder("{\"success\":true,\"availableTableIds\":[");
            for (int i = 0; i < availableTables.size(); i++) {
                if (i > 0) json.append(",");
                json.append(availableTables.get(i).getTableId());
            }
            json.append("]}");
            
            response.getWriter().write(json.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }
    
    /**
     * Select table and store in session
     */
    private void selectTable(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tableIdStr = request.getParameter("tableId");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String guestCountStr = request.getParameter("guestCount");
        
        if (tableIdStr == null || date == null || time == null || guestCountStr == null) {
            response.sendRedirect(request.getContextPath() + "/booking?error=missing_params");
            return;
        }
        
        try {
            Integer tableId = Integer.parseInt(tableIdStr);
            int guestCount = Integer.parseInt(guestCountStr);
            
            // Store booking info in session
            HttpSession session = request.getSession();
            session.setAttribute("selectedTableId", tableId);
            session.setAttribute("bookingDate", date);
            session.setAttribute("bookingTime", time);
            session.setAttribute("guestCount", guestCount);
            
            // Redirect to menu selection
            response.sendRedirect(request.getContextPath() + "/booking?action=menu");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/booking?error=invalid_params");
        }
    }
    
    /**
     * Show menu selection page
     */
    private void showMenuSelection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer tableId = (Integer) session.getAttribute("selectedTableId");
        
        if (tableId == null) {
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }
        
        // Load menu items
        List<model.MenuItems> menuItems = bookingService.getAvailableMenuItems();
        request.setAttribute("menuItems", menuItems);
        
        request.getRequestDispatcher("/views/custumer/booking/menu-booking.jsp").forward(request, response);
    }
    
    /**
     * Save cart to session via AJAX
     */
    private void saveCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String cartDataJson = request.getParameter("cartData");
        
        if (cartDataJson != null && !cartDataJson.isEmpty()) {
            try {
                // Parse JSON: {"1":2,"3":1} -> Map<Integer, Integer>
                java.util.Map<Integer, Integer> cart = new java.util.HashMap<>();
                
                cartDataJson = cartDataJson.trim();
                if (cartDataJson.startsWith("{") && cartDataJson.endsWith("}")) {
                    cartDataJson = cartDataJson.substring(1, cartDataJson.length() - 1);
                    
                    if (!cartDataJson.isEmpty()) {
                        String[] pairs = cartDataJson.split(",");
                        for (String pair : pairs) {
                            String[] keyValue = pair.split(":");
                            if (keyValue.length == 2) {
                                Integer menuItemId = Integer.parseInt(keyValue[0].replace("\"", "").trim());
                                Integer quantity = Integer.parseInt(keyValue[1].trim());
                                cart.put(menuItemId, quantity);
                            }
                        }
                    }
                }
                
                // Save to session
                HttpSession session = request.getSession();
                session.setAttribute("cart", cart);
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":true}");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
            }
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"error\":\"No cart data\"}");
        }
    }
}
