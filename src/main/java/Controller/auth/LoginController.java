package controller.auth;

import configs.GoogleConfig;
import service.UserService;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Tạo Google OAuth URL động
        String redirectUri = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath() + "/login-google";

        String googleLoginUrl = "https://accounts.google.com/o/oauth2/auth"
                + "?client_id=" + URLEncoder.encode(GoogleConfig.GOOGLE_CLIENT_ID, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8)
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode("email profile", StandardCharsets.UTF_8);

        request.setAttribute("googleLoginUrl", googleLoginUrl);

        // Truyền returnUrl (nếu có) để sau đăng nhập quay lại đúng trang (ví dụ: /checkout)
        String returnUrl = request.getParameter("returnUrl");
        if (returnUrl != null && !returnUrl.isBlank()) {
            request.setAttribute("returnUrl", returnUrl);
        }

        request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String returnUrl = request.getParameter("returnUrl");

        try {
            Users user = userService.login(username, password);

            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Store customerId and customer info for booking system
            if ("CUSTOMER".equalsIgnoreCase(user.getRole())) {
                dao.CustomerDAO customerDAO = new dao.CustomerDAO();
                model.Customers customer = customerDAO.findByUserId(user.getUserId());
                if (customer != null) {
                    session.setAttribute("customerId", customer.getCustomerId());
                    session.setAttribute("customerPoints", customer.getTotalPoints() != null ? customer.getTotalPoints() : 0);
                    session.setAttribute("customerMembershipLevel", customer.getMembershipLevel() != null ? customer.getMembershipLevel() : "Thành viên");
                }
            }

            // Nếu có returnUrl hợp lệ -> ưu tiên redirect về đó
            if (returnUrl != null && !returnUrl.isBlank()) {
                response.sendRedirect(returnUrl);
                return;
            }

            // Ngược lại: chuyển hướng dựa trên Role
            if ("ADMIN".equalsIgnoreCase(user.getRole()) || "STAFF".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/admin/home-admin/home-admin.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
        }
    }
}
