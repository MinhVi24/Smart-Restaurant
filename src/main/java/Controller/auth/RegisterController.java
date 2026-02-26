package controller.auth;

import dao.CustomerDAO;
import dao.UserDAO;
import model.Customers;
import model.Users;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Kiểm tra xem số điện thoại đã được đăng ký chưa
        if (userDAO.findByUsername(phone) != null) {
            request.setAttribute("error", "Số điện thoại này đã được đăng ký. Vui lòng đăng nhập.");
            request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
            return;
        }

        try {
            // 1. Tạo mới User (Tài khoản đăng nhập)
            Users newUser = new Users();

            // SỬA: Dùng phone thay vì email để làm username đăng nhập
            newUser.setUsername(phone);

            // Mã hóa mật khẩu bảo mật
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            newUser.setPasswordHash(hashedPassword);

            newUser.setRole("CUSTOMER");
            newUser.setStatus("ACTIVE");
            newUser.setCreatedAt(new Date());

            // Lưu User vào DB trước để sinh ID (Khóa ngoại cho bảng Customers)
            userDAO.create(newUser);

            // 2. Lấy lại User vừa tạo từ DB dựa trên số điện thoại
            // SỬA: Tìm theo phone thay vì email để đảm bảo lấy đúng ID
            Users savedUser = userDAO.findByUsername(phone);

            // 3. Tạo mới Customer (Thông tin chi tiết khách hàng)
            Customers newCustomer = new Customers();
            newCustomer.setFullName(fullname);
            newCustomer.setPhone(phone);
            newCustomer.setMembershipLevel("BRONZE");
            newCustomer.setTotalPoints(0);
            newCustomer.setCreatedAt(new Date());

            // Gắn ID của tài khoản vừa tạo vào thông tin khách hàng
            newCustomer.setUserId(savedUser);

            // Lưu Customer vào DB
            customerDAO.create(newCustomer);

            // Đăng ký thành công -> Chuyển hướng sang trang Đăng nhập
            response.sendRedirect(request.getContextPath() + "/login?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình tạo tài khoản. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/views/custumer/auth/register.jsp").forward(request, response);
        }
    }
}
