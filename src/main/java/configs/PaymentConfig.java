package configs;

/**
 * Cấu hình thanh toán
 * Nên load từ environment variables hoặc config file
 */
public class PaymentConfig {
    
    // Thông tin ngân hàng nhận tiền
    // Thông tin từ Sepay của bạn
    public static final String BANK_BIN = "970423"; // TPBank
    public static final String BANK_ACCOUNT_NO = "07318937999"; 
    public static final String BANK_ACCOUNT_NAME = "TRANMINHVI"; // Viết hoa, không dấu
    public static final String BANK_NAME = "TPBANK";
    
    // Cấu hình VietQR
    public static final String VIETQR_TEMPLATE = "compact2"; // compact, compact2, qr_only
    
    // Cấu hình kiểm tra thanh toán
    public static final int PAYMENT_CHECK_INTERVAL = 5000; // 5 giây (milliseconds)
    public static final int PAYMENT_TIMEOUT = 600000; // 10 phút (milliseconds)
    public static final int MANUAL_CONFIRM_DELAY = 120000; // 2 phút (milliseconds)
    
    // Prefix nội dung chuyển khoản
    public static final String TRANSFER_CONTENT_PREFIX = "THANHTOAN";
    
    /**
     * Load config từ environment variables (production)
     * Nếu không có env var, dùng giá trị mặc định
     */
    public static String getBankBin() {
        String envValue = System.getenv("BANK_BIN");
        return envValue != null ? envValue : BANK_BIN;
    }
    
    public static String getBankAccountNo() {
        String envValue = System.getenv("BANK_ACCOUNT_NO");
        return envValue != null ? envValue : BANK_ACCOUNT_NO;
    }
    
    public static String getBankAccountName() {
        String envValue = System.getenv("BANK_ACCOUNT_NAME");
        return envValue != null ? envValue : BANK_ACCOUNT_NAME;
    }
    
    public static String getBankName() {
        String envValue = System.getenv("BANK_NAME");
        return envValue != null ? envValue : BANK_NAME;
    }
}
