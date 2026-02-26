package controller.auth;

import dao.UserDAO;
import model.Users;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username"); // Trên giao diện User nhập SĐT vào trường username
        String password = request.getParameter("password");

        Users user = userDAO.findByUsername(username);

        // 1. Kiểm tra tài khoản có tồn tại không
        if (user == null) {
            request.setAttribute("error", "Tài khoản không tồn tại. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra tài khoản có bị khóa không
        if ("INACTIVE".equalsIgnoreCase(user.getStatus()) || "BLOCKED".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa.");
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
            return;
        }

        // 3. So khớp mật khẩu
        boolean passwordMatch = BCrypt.checkpw(password, user.getPasswordHash());

        if (passwordMatch) {
            // Đăng nhập thành công -> Lưu session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Sinh mã giỏ hàng mới hoặc các session data khác tại đây...

            // Chuyển hướng dựa trên Role
            if ("ADMIN".equalsIgnoreCase(user.getRole()) || "STAFF".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/admin/food/admin-dashboard.jsp");
            } else {
                // Khách hàng -> Về trang chủ
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            // Mật khẩu sai
            request.setAttribute("error", "Mật khẩu không chính xác.");
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
        }
    }
}
