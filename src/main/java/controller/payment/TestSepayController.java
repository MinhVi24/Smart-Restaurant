package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.SepayService;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

/**
 * Test servlet để kiểm tra kết nối Sepay
 * Truy cập: /test-sepay
 */
@WebServlet(name = "TestSepayController", urlPatterns = {"/test-sepay"})
public class TestSepayController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Sepay Connection</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; padding: 40px; background: #f5f5f5; }");
        out.println(".container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }");
        out.println("h1 { color: #333; }");
        out.println(".success { color: #4CAF50; font-weight: bold; }");
        out.println(".error { color: #f44336; font-weight: bold; }");
        out.println(".info { background: #e3f2fd; padding: 15px; border-radius: 4px; margin: 20px 0; }");
        out.println("pre { background: #f5f5f5; padding: 15px; border-radius: 4px; overflow-x: auto; }");
        out.println(".test-section { margin: 30px 0; padding: 20px; border: 1px solid #ddd; border-radius: 4px; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h1>🧪 Test Sepay API Connection</h1>");
        
        SepayService sepayService = new SepayService();
        
        // Test 1: Connection Test
        out.println("<div class='test-section'>");
        out.println("<h2>Test 1: Kiểm tra kết nối</h2>");
        boolean connected = sepayService.testConnection();
        if (connected) {
            out.println("<p class='success'>✓ Kết nối Sepay API thành công!</p>");
        } else {
            out.println("<p class='error'>✗ Không thể kết nối Sepay API</p>");
            out.println("<p>Kiểm tra:</p>");
            out.println("<ul>");
            out.println("<li>API key có đúng không?</li>");
            out.println("<li>Internet connection</li>");
            out.println("<li>Xem console log để biết chi tiết</li>");
            out.println("</ul>");
        }
        out.println("</div>");
        
        // Test 2: Check Transaction (Example)
        if (connected) {
            out.println("<div class='test-section'>");
            out.println("<h2>Test 2: Kiểm tra giao dịch mẫu</h2>");
            out.println("<p>Thử tìm giao dịch với:</p>");
            out.println("<ul>");
            out.println("<li>Nội dung: <code>THANHTOAN 123 TEST</code></li>");
            out.println("<li>Số tiền: <code>50,000 VND</code></li>");
            out.println("</ul>");
            
            boolean found = sepayService.checkTransaction(
                "THANHTOAN 123 TEST",
                new BigDecimal("50000"),
                null
            );
            
            if (found) {
                out.println("<p class='success'>✓ Tìm thấy giao dịch khớp!</p>");
            } else {
                out.println("<p class='error'>✗ Không tìm thấy giao dịch khớp</p>");
                out.println("<p><em>Đây là test mẫu, bình thường sẽ không tìm thấy.</em></p>");
            }
            out.println("</div>");
        }
        
        // Instructions
        out.println("<div class='info'>");
        out.println("<h3>📝 Hướng dẫn sử dụng:</h3>");
        out.println("<ol>");
        out.println("<li>Nếu Test 1 thành công → Sepay đã sẵn sàng</li>");
        out.println("<li>Thực hiện đặt bàn và thanh toán thật</li>");
        out.println("<li>Chuyển khoản với nội dung chính xác</li>");
        out.println("<li>Hệ thống sẽ tự động xác nhận trong 5-10 giây</li>");
        out.println("</ol>");
        out.println("</div>");
        
        // API Info
        out.println("<div class='test-section'>");
        out.println("<h2>ℹ️ Thông tin API</h2>");
        out.println("<p><strong>Endpoint:</strong> <code>https://my.sepay.vn/userapi/transactions/list</code></p>");
        out.println("<p><strong>API Key:</strong> <code>X94TM2S...MBWGCI</code> (đã ẩn)</p>");
        out.println("<p><strong>Tài liệu:</strong> <a href='https://developer.sepay.vn' target='_blank'>https://developer.sepay.vn</a></p>");
        out.println("</div>");
        
        // Console Log Note
        out.println("<div class='info'>");
        out.println("<p><strong>💡 Tip:</strong> Xem console log (Tomcat/IDE) để thấy chi tiết request/response từ Sepay API</p>");
        out.println("</div>");
        
        out.println("<p style='text-align: center; margin-top: 30px;'>");
        out.println("<a href='" + request.getContextPath() + "' style='color: #2196F3; text-decoration: none;'>← Quay lại trang chủ</a>");
        out.println("</p>");
        
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
