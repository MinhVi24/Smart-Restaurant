package controller.auth;

import service.UserService;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Gọi Service xử lý logic đăng nhập
            Users user = userService.login(username, password);

            // Đăng nhập thành công -> Lưu session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            // Chuyển hướng dựa trên Role
            if ("ADMIN".equalsIgnoreCase(user.getRole()) || "STAFF".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/admin/home-admin/home-admin.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } catch (IllegalArgumentException e) {
            // Service throw lỗi -> hiển thị thông báo
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
        }
    }
}
