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
import java.util.logging.Logger;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserService userService = new UserService();
    private static final Logger logger = Logger.getLogger(LoginController.class.getName());

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

            if (returnUrl != null && !returnUrl.isBlank()) {
                String role = user.getRole() != null ? user.getRole().toUpperCase() : "";
                String path = returnUrl;
                if (path.startsWith(request.getContextPath())) {
                    path = path.substring(request.getContextPath().length());
                }
                boolean allowed = false;
                if ("ADMIN".equals(role)) {
                    allowed = true;
                } else if ("STAFF".equals(role)) {
                    allowed = path.startsWith("/views/staff/") || path.startsWith("/staff/");
                } else {
                    allowed = !(path.startsWith("/views/admin/") || path.startsWith("/admin/") || path.startsWith("/views/staff/") || path.startsWith("/staff/"));
                }
                logger.info(String.format("login role=%s returnUrl=%s allowed=%s", role, returnUrl, allowed));
                if (allowed) {
                    logger.info(String.format("redirect -> %s", returnUrl));
                    response.sendRedirect(returnUrl);
                    return;
                }
            }

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                logger.info("redirect -> /views/admin/home-admin/home-admin.jsp");
                response.sendRedirect(request.getContextPath() + "/views/admin/home-admin/home-admin.jsp");
            } else if ("STAFF".equalsIgnoreCase(user.getRole())) {
                logger.info("redirect -> /views/staff/home.jsp");
                response.sendRedirect(request.getContextPath() + "/views/staff/home.jsp");
            } else {
                logger.info("redirect -> /views/custumer/home/home.jsp");
                response.sendRedirect(request.getContextPath() + "/views/custumer/home/home.jsp");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/custumer/auth/login.jsp").forward(request, response);
        }
    }
}
