package servlet;

import dao.UserDAO;
import filter.AuthFilter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);

        if (user == null) {
            req.setAttribute("loginError", "Email hoặc mật khẩu không đúng");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute(AuthFilter.SESSION_USER, user);

        String target = req.getParameter("redirect");
        if (target != null && !target.isBlank()) {
            resp.sendRedirect(req.getContextPath() + target);
            return;
        }

        if (user.getRole() != null && AuthFilter.ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin-dashboard.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}

