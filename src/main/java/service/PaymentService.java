package service;

import dao.PaymentDAO;
import model.Payments;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * Service xử lý thanh toán và tạo QR code
 */
public class PaymentService {
    
    private PaymentDAO paymentDAO;
    
    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
    }
    
    /**
     * Tạo nội dung chuyển khoản cho VietQR
     * Format: DatBan[OrderID]
     */
    public String generateTransferContent(Integer orderId, String customerName) {
        // Format đơn giản: DatBan + OrderID
        return "DatBan" + orderId;
    }
    
    /**
     * Tạo URL VietQR
     * @param bankBin Mã ngân hàng (VD: 970422 = MB Bank)
     * @param accountNo Số tài khoản
     * @param accountName Tên tài khoản
     * @param amount Số tiền
     * @param description Nội dung chuyển khoản
     * @return URL QR code
     */
    public String generateVietQRUrl(String bankBin, String accountNo, String accountName, 
                                     BigDecimal amount, String description) {
        // VietQR API format
        String template = "compact2"; // hoặc "compact", "qr_only"
        
        // Format số tiền (không có dấu phẩy, chấm)
        long amountLong = amount.longValue();
        
        // Encode description và account name
        String encodedDesc = encodeUrl(description);
        String encodedAccountName = encodeUrl(accountName);
        
        return String.format(
            "https://img.vietqr.io/image/%s-%s-%s.png?amount=%d&addInfo=%s&accountName=%s",
            bankBin, accountNo, template, amountLong, encodedDesc, encodedAccountName
        );
    }
    
    /**
     * Cập nhật trạng thái thanh toán
     */
    public boolean updatePaymentStatus(Integer paymentId, String status) {
        if ("COMPLETED".equals(status)) {
            return paymentDAO.completePayment(paymentId);
        }
        return false;
    }
    
    /**
     * Kiểm tra thanh toán đã hoàn thành chưa
     */
    public boolean isPaymentCompleted(Integer paymentId) {
        Payments payment = paymentDAO.findById(paymentId);
        return payment != null && "COMPLETED".equals(payment.getPaymentStatus());
    }
    
    /**
     * Format số tiền VND
     */
    public String formatCurrency(BigDecimal amount) {
        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return formatter.format(amount);
    }
    
    /**
     * Chuẩn hóa tiếng Việt: bỏ dấu, viết hoa
     */
    private String normalizeVietnamese(String str) {
        if (str == null || str.isEmpty()) {
            return "KHACH";
        }
        
        // Bỏ dấu tiếng Việt
        String normalized = str;
        normalized = normalized.replaceAll("[àáạảãâầấậẩẫăằắặẳẵ]", "a");
        normalized = normalized.replaceAll("[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]", "A");
        normalized = normalized.replaceAll("[èéẹẻẽêềếệểễ]", "e");
        normalized = normalized.replaceAll("[ÈÉẸẺẼÊỀẾỆỂỄ]", "E");
        normalized = normalized.replaceAll("[ìíịỉĩ]", "i");
        normalized = normalized.replaceAll("[ÌÍỊỈĨ]", "I");
        normalized = normalized.replaceAll("[òóọỏõôồốộổỗơờớợởỡ]", "o");
        normalized = normalized.replaceAll("[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]", "O");
        normalized = normalized.replaceAll("[ùúụủũưừứựửữ]", "u");
        normalized = normalized.replaceAll("[ÙÚỤỦŨƯỪỨỰỬỮ]", "U");
        normalized = normalized.replaceAll("[ỳýỵỷỹ]", "y");
        normalized = normalized.replaceAll("[ỲÝỴỶỸ]", "Y");
        normalized = normalized.replaceAll("đ", "d");
        normalized = normalized.replaceAll("Đ", "D");
        
        // Viết hoa và bỏ khoảng trắng thừa
        normalized = normalized.toUpperCase().trim().replaceAll("\\s+", " ");
        
        return normalized;
    }
    
    /**
     * Encode URL parameter
     */
    private String encodeUrl(String str) {
        if (str == null) return "";
        try {
            return java.net.URLEncoder.encode(str, "UTF-8");
        } catch (Exception e) {
            return str.replace(" ", "%20");
        }
    }
}
