package controller;

import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Kiểm tra token hợp lệ
        ForgotPasswordController.TokenInfo tokenInfo = ForgotPasswordController.resetTokens.get(token);

        if (tokenInfo == null || tokenInfo.isExpired()) {
            // Token không tồn tại hoặc đã hết hạn
            ForgotPasswordController.resetTokens.remove(token);
            request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn. Vui lòng yêu cầu lại.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        // Token hợp lệ → hiển thị form nhập mật khẩu mới
        request.setAttribute("token", token);
        request.getRequestDispatcher("/views/custumer/auth/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate
        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ForgotPasswordController.TokenInfo tokenInfo = ForgotPasswordController.resetTokens.get(token);

        if (tokenInfo == null || tokenInfo.isExpired()) {
            ForgotPasswordController.resetTokens.remove(token);
            request.setAttribute("error", "Link đặt lại mật khẩu đã hết hạn. Vui lòng yêu cầu lại.");
            request.getRequestDispatcher("/views/custumer/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        if (newPassword == null || newPassword.trim().length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/views/custumer/auth/reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/views/custumer/auth/reset-password.jsp").forward(request, response);
            return;
        }

        try {
            // Cập nhật mật khẩu mới
            userService.updatePassword(tokenInfo.email, newPassword);

            // Xóa token đã sử dụng
            ForgotPasswordController.resetTokens.remove(token);

            // Redirect tới login với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/login?reset=success");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/views/custumer/auth/reset-password.jsp").forward(request, response);
        }
    }
}
