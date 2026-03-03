package controller.auth;

import configs.GoogleConfig;
import dao.CustomerDAO;
import model.Customers;
import model.Users;
import service.CustomerService;
import service.EmailService;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;

@WebServlet("/login-google")
public class LoginGoogleHandler extends HttpServlet {

    private final UserService userService = new UserService();
    private final CustomerService customerService = new CustomerService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 1. Lấy access token từ Google
            String accessToken = getAccessToken(code, request);
            JSONObject userInfo = getUserInfo(accessToken);

            String email = userInfo.optString("email");
            String name = userInfo.optString("name");

            // 2. Đăng ký / tìm user trong DB (nếu chưa có → tạo mới)
            Users user = userService.registerGoogleUser(email, name);

            // 3. Tạo Customer nếu chưa có
            CustomerDAO customerDAO = new CustomerDAO();
            Customers customer = customerDAO.findByUserId(user.getUserId());
            if (customer == null) {
                customer = customerService.createCustomer(name, null, user);
            }

            // 4. Set session đầy đủ (giống LoginController)
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setAttribute("loginType", "GOOGLE");

            if (customer != null) {
                session.setAttribute("customerId", customer.getCustomerId());
                session.setAttribute("customerPoints", customer.getTotalPoints() != null ? customer.getTotalPoints() : 0);
                session.setAttribute("customerMembershipLevel", customer.getMembershipLevel() != null ? customer.getMembershipLevel() : "Thành viên");
            }

            // 5. Gửi email thông báo đăng nhập (chạy async để không chặn redirect)
            final String finalEmail = email;
            final String finalName = name;
            new Thread(() -> {
                emailService.sendLoginNotificationEmail(finalEmail, finalName);
            }).start();

            // 6. Redirect theo role (đồng bộ với LoginController)
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/admin/home-admin/home-admin.jsp");
            } else if ("STAFF".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/views/staff/home.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/custumer/home/home.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=google_login_failed");
        }
    }

    private String getAccessToken(String code, HttpServletRequest request) throws IOException {
        // Tạo redirect URI động
        String redirectUri = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath() + "/login-google";

        URL url = new URL(GoogleConfig.GOOGLE_LINK_GET_TOKEN);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String params =
                "code=" + URLEncoder.encode(code, "UTF-8") +
                "&client_id=" + URLEncoder.encode(GoogleConfig.GOOGLE_CLIENT_ID, "UTF-8") +
                "&client_secret=" + URLEncoder.encode(GoogleConfig.GOOGLE_CLIENT_SECRET, "UTF-8") +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8") +
                "&grant_type=authorization_code";

        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();

        if (conn.getResponseCode() != 200) {
            // Đọc error response để debug
            BufferedReader errorReader = new BufferedReader(
                    new InputStreamReader(conn.getErrorStream())
            );
            StringBuilder errorResponse = new StringBuilder();
            String errorLine;
            while ((errorLine = errorReader.readLine()) != null) {
                errorResponse.append(errorLine);
            }
            System.err.println("Google token error: " + errorResponse.toString());
            throw new RuntimeException("Failed to get access token: " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder responseStr = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            responseStr.append(line);
        }

        JSONObject json = new JSONObject(responseStr.toString());
        return json.getString("access_token");
    }

    private JSONObject getUserInfo(String accessToken) throws IOException {

        URL url = new URL(
                GoogleConfig.GOOGLE_LINK_GET_USER_INFO +
                        URLEncoder.encode(accessToken, "UTF-8")
        );

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed to get user info");
        }

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder responseStr = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            responseStr.append(line);
        }

        return new JSONObject(responseStr.toString());
    }
}
