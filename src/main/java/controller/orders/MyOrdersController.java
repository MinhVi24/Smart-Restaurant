package controller.orders;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.OrderDAO;
import model.Orders;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyOrdersController", urlPatterns = {"/orders/my"})
public class MyOrdersController extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
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
        
        // Load customer orders
        List<Orders> orders = orderDAO.findByCustomer(customerId);
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/views/custumer/orders/my-orders.jsp").forward(request, response);
    }
}
