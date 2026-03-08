package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.PaymentService;
import dao.PaymentDAO;
import dao.OrderDAO;
import model.Payments;
import model.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

/**
 * API để xác nhận thanh toán thủ công
 */
@WebServlet(name = "PaymentConfirmController", urlPatterns = {"/api/payment/confirm"})
public class PaymentConfirmController extends HttpServlet {
    
    private PaymentService paymentService;
    private PaymentDAO paymentDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
        paymentDAO = new PaymentDAO();
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String paymentIdStr = request.getParameter("paymentId");
        String confirmationType = request.getParameter("type"); // "manual" or "auto"
        
        JSONObject jsonResponse = new JSONObject();
        
        try {
            if (paymentIdStr == null || paymentIdStr.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing paymentId");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                Integer paymentId = Integer.parseInt(paymentIdStr);
                
                // Cập nhật trạng thái thanh toán
                boolean updated = paymentService.updatePaymentStatus(paymentId, "COMPLETED");
                
                if (updated) {
                    // Cập nhật trạng thái đơn hàng
                    Payments payment = paymentDAO.findById(paymentId);
                    if (payment != null && payment.getOrderId() != null) {
                        Orders order = payment.getOrderId();
                        order.setStatus("CONFIRMED");
                        orderDAO.update(order);
                    }
                    
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Payment confirmed successfully");
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to confirm payment");
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Server error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
