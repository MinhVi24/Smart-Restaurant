package controller;

import service.UserService;
import service.CustomerService;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserService();
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");   // → Customers.full_name
        String username = request.getParameter("username");    // → Users.username
        String email    = request.getParameter("email");       // → Users.email
        String phone    = request.getParameter("phone");       // → Customers.phone
        String password = request.getParameter("password");    // → Users.password_hash (qua BCrypt)

        try {
            // 1. Tạo tài khoản User qua Service (username + email + hash password)
            Users savedUser = userService.register(username, email, password, "CUSTOMER");

            // 2. Tạo Customer gắn với User (fullname + phone)
            customerService.createCustomer(fullname, phone, savedUser);

            // Đăng ký thành công → Chuyển hướng sang trang Đăng nhập
            response.sendRedirect(request.getContextPath() + "/login?success=true");

        } catch (IllegalArgumentException e) {
            // Trùng username hoặc email
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình tạo tài khoản. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
        }
    }
}
