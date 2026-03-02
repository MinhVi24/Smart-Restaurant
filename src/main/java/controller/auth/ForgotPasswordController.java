package controller;

import service.UserService;
import service.EmailService;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private final UserService userService = new UserService();
    private final EmailService emailService = new EmailService();

    // Lưu token reset trong memory: token → {email, expiryTime}
    // Dùng static để ResetPasswordController cũng truy cập được
    public static final Map<String, TokenInfo> resetTokens = new ConcurrentHashMap<>();

    public static class TokenInfo {
        public String email;
        public long expiryTime;

        public TokenInfo(String email, long expiryTime) {
            this.email = email;
            this.expiryTime = expiryTime;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() > expiryTime;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        // Tìm user theo email
        Users user = userService.findByEmail(email.trim());

        if (user == null) {
            request.setAttribute("error", "Email này chưa được đăng ký trong hệ thống.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        try {
            // Tạo token ngẫu nhiên
            String token = UUID.randomUUID().toString();

            // Lưu token với thời hạn 15 phút
            long expiryTime = System.currentTimeMillis() + (15 * 60 * 1000);
            resetTokens.put(token, new TokenInfo(email.trim(), expiryTime));

            // Tạo reset link
            String resetLink = request.getScheme() + "://" +
                    request.getServerName() + ":" + request.getServerPort() +
                    request.getContextPath() + "/reset-password?token=" + token;

            // Gửi email
            emailService.sendResetPasswordEmail(email.trim(), resetLink);

            request.setAttribute("success", "Đã gửi link đặt lại mật khẩu tới email của bạn. Vui lòng kiểm tra hộp thư.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
        }
    }
}
