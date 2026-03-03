package controller.auth;

import configs.GoogleConfig;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String accessToken = getAccessToken(code);
            JSONObject userInfo = getUserInfo(accessToken);

            String email = userInfo.optString("email");
            String name = userInfo.optString("name");

            request.getSession().setAttribute("email", email);
            request.getSession().setAttribute("name", name);
            request.getSession().setAttribute("loginType", "GOOGLE");

            response.sendRedirect(request.getContextPath() + "/");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=google_login_failed");
        }
    }

    private String getAccessToken(String code) throws IOException {

        URL url = new URL(GoogleConfig.GOOGLE_LINK_GET_TOKEN);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String params =
                "code=" + URLEncoder.encode(code, "UTF-8") +
                "&client_id=" + URLEncoder.encode(GoogleConfig.GOOGLE_CLIENT_ID, "UTF-8") +
                "&client_secret=" + URLEncoder.encode(GoogleConfig.GOOGLE_CLIENT_SECRET, "UTF-8") +
                "&redirect_uri=" + URLEncoder.encode(GoogleConfig.GOOGLE_REDIRECT_URI, "UTF-8") +
                "&grant_type=authorization_code";

        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes());
        os.flush();
        os.close();

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed to get access token");
        }

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder response = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        JSONObject json = new JSONObject(response.toString());
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

        StringBuilder response = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        return new JSONObject(response.toString());
    }
}