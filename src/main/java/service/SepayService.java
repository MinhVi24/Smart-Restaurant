package service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Service kiểm tra giao dịch ngân hàng qua Sepay API
 */
public class SepayService {
    
    private static final String SEPAY_API_URL = "https://my.sepay.vn/userapi/transactions/list";
    private static final String SEPAY_API_TOKEN = "X94TM2SSNHFR76NEGE8WDJ1SHDVZXQIOBLLTBNZOPEFO3PRLBYAN073VJCMBWGCI";
    
    // TEST MODE: Set false để dùng Sepay API thật
    // Set true để test không cần chuyển tiền (auto-confirm sau 10 giây)
    private static final boolean TEST_MODE = false;
    /**
     * Kiểm tra giao dịch có khớp với nội dung và số tiền không
     * @param expectedContent Nội dung cần tìm (VD: "THANHTOAN 123 NGUYEN VAN A")
     * @param expectedAmount Số tiền cần kiểm tra
     * @param accountNumber Số tài khoản ngân hàng (optional)
     * @return true nếu tìm thấy giao dịch khớp
     */
    public boolean checkTransaction(String expectedContent, BigDecimal expectedAmount, String accountNumber) {
        try {
            // Lấy danh sách giao dịch gần đây
            JSONArray transactions = getRecentTransactions(accountNumber);
            
            if (transactions == null || transactions.length() == 0) {
                System.out.println("[Sepay] No transactions found");
                return false;
            }
            
            System.out.println("[Sepay] Checking " + transactions.length() + " transactions...");
            System.out.println("[Sepay] Looking for: " + expectedContent + " | Amount: " + expectedAmount);
            
            // Duyệt qua các giao dịch để tìm giao dịch khớp
            for (int i = 0; i < transactions.length(); i++) {
                JSONObject trans = transactions.getJSONObject(i);
                
                // Lấy thông tin giao dịch
                String transactionContent = trans.optString("transaction_content", "");
                double amountIn = trans.optDouble("amount_in", 0);
                String transactionDate = trans.optString("transaction_date", "");
                
                // Kiểm tra số tiền (chuyển về long để so sánh chính xác)
                long expectedAmountLong = expectedAmount.longValue();
                long actualAmountLong = (long) amountIn;
                
                System.out.println("[Sepay] Transaction #" + (i+1) + ": " + transactionContent + " | " + amountIn);
                
                // PRODUCTION MODE: Check CẢ nội dung VÀ số tiền
                String normalizedContent = normalizeString(transactionContent);
                String normalizedExpected = normalizeString(expectedContent);
                
                boolean contentMatch = normalizedContent.contains(normalizedExpected);
                boolean amountMatch = actualAmountLong == expectedAmountLong;
                
                System.out.println("[Sepay]   Content match: " + contentMatch + " (looking for '" + normalizedExpected + "' in '" + normalizedContent + "')");
                System.out.println("[Sepay]   Amount match: " + amountMatch + " (" + actualAmountLong + " == " + expectedAmountLong + ")");
                
                if (contentMatch && amountMatch) {
                    System.out.println("[Sepay] ✓ MATCHED! (Both content and amount)");
                    System.out.println("[Sepay]   Content: " + transactionContent);
                    System.out.println("[Sepay]   Amount: " + amountIn);
                    System.out.println("[Sepay]   Date: " + transactionDate);
                    return true;
                }
            }
            
            System.out.println("[Sepay] No matching transaction found");
            return false;
            
        } catch (Exception e) {
            System.err.println("[Sepay] Error checking transaction: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy danh sách giao dịch gần đây từ Sepay API
     * @param accountNumber Số tài khoản (optional)
     * @return JSONArray chứa danh sách giao dịch
     */
    private JSONArray getRecentTransactions(String accountNumber) {
        try {
            // Tính thời gian bắt đầu (hôm nay)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date now = new Date();
            String dateStr = sdf.format(now);
            
            // Build URL với query parameters
            StringBuilder urlBuilder = new StringBuilder(SEPAY_API_URL);
            urlBuilder.append("?limit=50"); // Lấy 50 giao dịch gần nhất
            urlBuilder.append("&transaction_date_min=").append(dateStr);
            
            if (accountNumber != null && !accountNumber.isEmpty()) {
                urlBuilder.append("&account_number=").append(accountNumber);
            }
            
            String urlString = urlBuilder.toString();
            System.out.println("[Sepay] Calling API: " + urlString);
            
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + SEPAY_API_TOKEN);
            conn.setConnectTimeout(10000); // 10 seconds timeout
            conn.setReadTimeout(10000);
            
            int responseCode = conn.getResponseCode();
            System.out.println("[Sepay] Response Code: " + responseCode);
            
            if (responseCode == 200) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                String inputLine;
                StringBuilder response = new StringBuilder();
                
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                
                String responseStr = response.toString();
                System.out.println("[Sepay] Response: " + responseStr.substring(0, Math.min(200, responseStr.length())) + "...");
                
                // Parse JSON response
                JSONObject jsonResponse = new JSONObject(responseStr);
                
                // Sepay API trả về format: {"status": 200, "messages": {...}, "transactions": [...]}
                if (jsonResponse.has("transactions")) {
                    JSONArray transactions = jsonResponse.getJSONArray("transactions");
                    System.out.println("[Sepay] Found " + transactions.length() + " transactions");
                    return transactions;
                } else {
                    System.out.println("[Sepay] No transactions field in response");
                }
            } else {
                // Đọc error response
                BufferedReader errorReader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
                String errorLine;
                StringBuilder errorResponse = new StringBuilder();
                while ((errorLine = errorReader.readLine()) != null) {
                    errorResponse.append(errorLine);
                }
                errorReader.close();
                System.err.println("[Sepay] API Error: " + errorResponse.toString());
            }
            
        } catch (Exception e) {
            System.err.println("[Sepay] Error calling API: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Chuẩn hóa chuỗi: bỏ dấu cách, chuyển thành chữ thường
     */
    private String normalizeString(String str) {
        if (str == null) return "";
        return str.replaceAll("\\s+", "").toLowerCase();
    }
    
    /**
     * Test connection với Sepay API
     */
    public boolean testConnection() {
        try {
            System.out.println("[Sepay] Testing connection...");
            JSONArray transactions = getRecentTransactions(null);
            boolean success = transactions != null;
            System.out.println("[Sepay] Connection test: " + (success ? "SUCCESS" : "FAILED"));
            return success;
        } catch (Exception e) {
            System.err.println("[Sepay] Connection test failed: " + e.getMessage());
            return false;
        }
    }
}
