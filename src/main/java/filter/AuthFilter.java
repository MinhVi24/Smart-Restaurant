package filter;

import model.Users;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String loginURI = httpRequest.getContextPath() + "/login";
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // 1. Loại trừ các đường dẫn public không cần đăng nhập
        boolean isLoginRequest = path.equals("/login");
        boolean isRegisterRequest = path.equals("/register");
        boolean isPublicResource = path.startsWith("/assets/") || path.startsWith("/css/") || path.startsWith("/js/");
        
        boolean isAdminPath = path.startsWith("/views/admin/") || path.startsWith("/admin/");
        boolean isStaffPath = path.startsWith("/views/staff/") || path.startsWith("/staff/");

        boolean isCustomerRestrictedPath =
                path.startsWith("/account/")
             || path.startsWith("/orders/my")
             || path.startsWith("/bookings/history")
             || path.startsWith("/booking")
             || path.startsWith("/checkout");

        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);
        
        // Nếu user đã logged in nhưng truy cập lại /login hay /register thì đá về trang chủ
        if (loggedIn && (isLoginRequest || isRegisterRequest)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
            return;
        }

        if (isAdminPath) {
            if (!loggedIn) {
                httpResponse.sendRedirect(loginURI);
                return;
            } else {
                Users user = (Users) session.getAttribute("loggedInUser");
                if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
                    httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này.");
                    return;
                }
            }
        }
        
        if (isStaffPath) {
            if (!loggedIn) {
                httpResponse.sendRedirect(loginURI);
                return;
            } else {
                Users user = (Users) session.getAttribute("loggedInUser");
                if (!"STAFF".equalsIgnoreCase(user.getRole()) && !"ADMIN".equalsIgnoreCase(user.getRole())) {
                    httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này.");
                    return;
                }
            }
        }
        
        // Kiểm tra quyền truy cập tính năng cá nhân của Customer
        if (isCustomerRestrictedPath) {
             if (!loggedIn) {
                httpResponse.sendRedirect(loginURI);
                return;
             }
        }

        // Cho đi tiếp tục Request Pipeline
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Hủy dọn dẹp
    }
}
