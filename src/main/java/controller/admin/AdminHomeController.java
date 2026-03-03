package controller.admin;

import dao.MenuItemDAO;
import dao.OrderDAO;
import dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MenuItems;
import model.Orders;
import model.Reservations;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/home")
public class AdminHomeController extends HttpServlet {
    
    private MenuItemDAO menuItemDAO;
    private OrderDAO orderDAO;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        menuItemDAO = new MenuItemDAO();
        orderDAO = new OrderDAO();
        reservationDAO = new ReservationDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get today's revenue
            LocalDate today = LocalDate.now();
            Double todayRevenue = orderDAO.getTodayRevenue(today);
            request.setAttribute("todayRevenue", todayRevenue != null ? todayRevenue : 0.0);
            
            // Get top selling items
            List<Map<String, Object>> topItems = menuItemDAO.getTopSellingItems(3);
            request.setAttribute("topItems", topItems);
            
            // Get reservation stats
            int reservedCount = reservationDAO.getReservationCountByStatus("CONFIRMED");
            int occupiedCount = reservationDAO.getReservationCountByStatus("SEATED");
            int availableCount = 30 - reservedCount - occupiedCount; // Total 30 tables
            
            request.setAttribute("reservedCount", reservedCount);
            request.setAttribute("occupiedCount", occupiedCount);
            request.setAttribute("availableCount", availableCount);
            
            // Get low stock items
            List<MenuItems> lowStockItems = menuItemDAO.getLowStockItems(3);
            request.setAttribute("lowStockItems", lowStockItems);
            
            // Get predicted customers (AI prediction - mock for now)
            request.setAttribute("predictedCustomers", 128);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải dữ liệu: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/views/admin/home-admin/home-admin.jsp").forward(request, response);
    }
}
