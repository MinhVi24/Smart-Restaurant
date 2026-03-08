package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Reservations;
import model.Orders;
import model.Payments;
import model.Customers;
import service.PaymentService;
import java.io.IOException;

@WebServlet(name = "PaymentController", urlPatterns = {"/payment/qr"})
public class PaymentController extends HttpServlet {
    
    private PaymentService paymentService;
    
    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get booking result from session
        Reservations reservation = (Reservations) session.getAttribute("reservation");
        Orders order = (Orders) session.getAttribute("order");
        Payments payment = (Payments) session.getAttribute("payment");
        
        if (reservation == null || order == null || payment == null) {
            // No booking data, redirect to booking page
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }
        
        // Thông tin ngân hàng nhận tiền (từ config)
        String bankBin = configs.PaymentConfig.getBankBin();
        String accountNo = configs.PaymentConfig.getBankAccountNo();
        String accountName = configs.PaymentConfig.getBankAccountName();
        String bankName = configs.PaymentConfig.getBankName();
        
        // Tạo nội dung chuyển khoản
        Customers customer = order.getCustomerId();
        String customerName = customer != null ? customer.getFullName() : "KHACH";
        String transferContent = paymentService.generateTransferContent(
            order.getOrderId(), 
            customerName
        );
        
        // Tạo URL VietQR
        String qrUrl = paymentService.generateVietQRUrl(
            bankBin, 
            accountNo, 
            accountName, 
            payment.getDepositAmount(), // Số tiền cần thanh toán
            transferContent
        );
        
        // Set attributes for JSP
        request.setAttribute("reservation", reservation);
        request.setAttribute("order", order);
        request.setAttribute("payment", payment);
        request.setAttribute("qrUrl", qrUrl);
        request.setAttribute("transferContent", transferContent);
        request.setAttribute("bankName", bankName);
        request.setAttribute("accountNo", accountNo);
        request.setAttribute("accountName", accountName);
        
        // Forward to payment QR page
        request.getRequestDispatcher("/views/custumer/payment/payment-qr.jsp").forward(request, response);
    }
}
