package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

import java.io.IOException;


@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*"})
public class AuthFilter implements Filter {

    /** Tên attribute session lưu user đăng nhập. */
    public static final String SESSION_USER = "currentUser";

    /** Role Admin - chỉ role này mới được vào /admin/*. */
    public static final String ROLE_ADMIN = "Admin";

    /** Role Customer - bị chặn khỏi /admin/*. */
    public static final String ROLE_CUSTOMER = "Customer";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = null;
        if (session != null) {
            user = (User) session.getAttribute(SESSION_USER);
        }

        // Chưa đăng nhập -> chuyển về trang đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Chỉ Admin mới được vào /admin/*; Customer hoặc role khác -> chặn
        if (user.getRole() == null || !ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // Admin -> cho qua
        chain.doFilter(request, response);
    }
}
