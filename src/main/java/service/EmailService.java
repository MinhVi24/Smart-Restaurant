package service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Service gửi email sử dụng Jakarta Mail (Gmail SMTP).
 * 
 * HƯỚNG DẪN CẤU HÌNH:
 * 1. Bật 2-Step Verification tại Google Account
 * 2. Tạo App Password tại: https://myaccount.google.com/apppasswords
 * 3. Cập nhật FROM_EMAIL và APP_PASSWORD bên dưới
 */
public class EmailService {

    // ===== CẤU HÌNH EMAIL - CẬP NHẬT THÔNG TIN CỦA BẠN =====
    private static final String FROM_EMAIL = "tetegaming1307@gmail.com";      // <-- Thay email của bạn
    private static final String APP_PASSWORD = "vcyc mdgw iscz egmk";        // <-- Thay App Password 16 ký tự
    // ===========================================================

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;

    /**
     * Gửi email reset mật khẩu.
     * @param toEmail Email người nhận
     * @param resetLink Link reset mật khẩu
     */
    public void sendResetPasswordEmail(String toEmail, String resetLink) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));
        props.put("mail.smtp.ssl.trust", SMTP_HOST);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Maison D'Or"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Maison D'Or - Đặt lại mật khẩu");

            String htmlContent = """
                <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; background: #1a1a1a; border-radius: 12px; overflow: hidden;">
                    <div style="background: linear-gradient(135deg, #d4af35, #b08d1e); padding: 30px; text-align: center;">
                        <h1 style="color: #1a1a1a; margin: 0; font-size: 28px; letter-spacing: 3px;">MAISON D'OR</h1>
                    </div>
                    <div style="padding: 40px 30px; color: #e0e0e0;">
                        <h2 style="color: #d4af35; margin-top: 0;">Đặt lại mật khẩu</h2>
                        <p style="line-height: 1.6;">Xin chào,</p>
                        <p style="line-height: 1.6;">Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Vui lòng nhấn vào nút bên dưới để tạo mật khẩu mới:</p>
                        <div style="text-align: center; margin: 30px 0;">
                            <a href="%s" style="background: #d4af35; color: #1a1a1a; padding: 14px 40px; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 16px; display: inline-block;">Đặt Lại Mật Khẩu</a>
                        </div>
                        <p style="line-height: 1.6; color: #999; font-size: 13px;">Link này sẽ hết hạn sau <strong>15 phút</strong>.</p>
                        <p style="line-height: 1.6; color: #999; font-size: 13px;">Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
                    </div>
                    <div style="background: #111; padding: 20px; text-align: center; color: #666; font-size: 12px;">
                        <p style="margin: 0;">© 2024 Maison D'Or. All rights reserved.</p>
                    </div>
                </div>
                """.formatted(resetLink);

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);

            System.out.println("Email reset password đã gửi tới: " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Không thể gửi email. Vui lòng thử lại sau.", e);
        }
    }

    /**
     * Gửi email thông báo đăng nhập bằng Google.
     * @param toEmail Email người nhận
     * @param userName Tên người dùng
     */
    public void sendLoginNotificationEmail(String toEmail, String userName) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));
        props.put("mail.smtp.ssl.trust", SMTP_HOST);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Maison D'Or"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Maison D'Or - Thông báo đăng nhập");

            // Lấy thời gian hiện tại
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            String loginTime = sdf.format(new java.util.Date());

            String htmlContent = """
                <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; background: #1a1a1a; border-radius: 12px; overflow: hidden;">
                    <div style="background: linear-gradient(135deg, #d4af35, #b08d1e); padding: 30px; text-align: center;">
                        <h1 style="color: #1a1a1a; margin: 0; font-size: 28px; letter-spacing: 3px;">MAISON D'OR</h1>
                    </div>
                    <div style="padding: 40px 30px; color: #e0e0e0;">
                        <h2 style="color: #d4af35; margin-top: 0;">Thông báo đăng nhập</h2>
                        <p style="line-height: 1.6;">Xin chào <strong>%s</strong>,</p>
                        <p style="line-height: 1.6;">Tài khoản của bạn vừa được đăng nhập bằng Google vào lúc:</p>
                        <div style="text-align: center; margin: 20px 0; padding: 15px; background: #232323; border-radius: 8px; border-left: 4px solid #d4af35;">
                            <p style="margin: 0; font-size: 18px; color: #d4af35; font-weight: bold;">%s</p>
                        </div>
                        <p style="line-height: 1.6; color: #999; font-size: 13px;">Nếu đây không phải bạn, vui lòng đổi mật khẩu ngay hoặc liên hệ với chúng tôi.</p>
                        <p style="line-height: 1.6; color: #999; font-size: 13px;">Nếu đây là bạn, bạn có thể bỏ qua email này.</p>
                    </div>
                    <div style="background: #111; padding: 20px; text-align: center; color: #666; font-size: 12px;">
                        <p style="margin: 0;">© 2024 Maison D'Or. All rights reserved.</p>
                    </div>
                </div>
                """.formatted(userName, loginTime);

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);

            System.out.println("Email thông báo đăng nhập đã gửi tới: " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
            // Không throw exception - việc gửi email thông báo không nên chặn đăng nhập
            System.err.println("Không thể gửi email thông báo đăng nhập tới: " + toEmail);
        }
    }
}
