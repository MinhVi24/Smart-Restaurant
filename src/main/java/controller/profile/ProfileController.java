package controller.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.CustomerDAO;
import dao.UserDAO;
import model.Customers;
import model.Users;
import java.io.IOException;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        userDAO = new UserDAO();
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
        
        // Load customer data
        Customers customer = customerDAO.findById(customerId);
        if (customer != null) {
            request.setAttribute("customer", customer);
        }
        
        request.getRequestDispatcher("/views/custumer/profile/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("customerId");
        
        if (customerId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form data
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        
        try {
            Customers customer = customerDAO.findById(customerId);
            if (customer != null) {
                customer.setFullName(fullName);
                customer.setPhone(phone);
                customerDAO.update(customer);
                
                request.setAttribute("success", "Cập nhật thông tin thành công!");
                request.setAttribute("customer", customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin!");
        }
        
        request.getRequestDispatcher("/views/custumer/profile/profile.jsp").forward(request, response);
    }
}
