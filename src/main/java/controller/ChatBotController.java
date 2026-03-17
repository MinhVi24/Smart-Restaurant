package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "ChatBotController", urlPatterns = {"/api/chat"})
public class ChatBotController extends HttpServlet {

    private static final String OPENROUTER_API_KEY = "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";
    private static final String OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions";

    // System prompt describing the restaurant
    private static final String SYSTEM_PROMPT =
        "Bạn là trợ lý AI thân thiện của nhà hàng VESPER - Fine Dining Experience, một nhà hàng ẩm thực cao cấp phong cách Pháp.\n\n" +
        "THÔNG TIN NHÀ HÀNG:\n" +
        "- Tên: VESPER Fine Dining Experience\n" +
        "- Phong cách: Ẩm thực Pháp cao cấp, Michelin-inspired\n" +
        "- Không gian: Sky Lounge (tầng 45, view toàn cảnh thành phố) và Private Dining (phòng VIP riêng tư)\n\n" +
        "THỰC ĐƠN CHÍNH:\n" +
        "🥩 MÓN BÍT TẾT:\n" +
        "- Wagyu A5 Miyazaki (Nhật Bản, BMS 11-12): 2.500.000đ/100g - Signature dish\n" +
        "- Thăn Lưng Black Angus Ribeye (USDA Prime, dry-aged 45 ngày): 1.200.000đ\n" +
        "- Thăn Nội Tenderloin Chateaubriand (Úc, Grass-fed): 1.450.000đ\n" +
        "- Tomahawk Dát Vàng 24K (Wagyu F1, Úc): 4.500.000đ\n" +
        "- Thăn Ngoại Striploin New York Strip (Canada): 950.000đ\n\n" +
        "🦞 MÓN ĐẶC BIỆT:\n" +
        "- Bò Wagyu Thượng Hạng (A5 Nhật, nướng đá núi lửa, sốt Truffle đen): 2.500.000đ\n" +
        "- Tôm Hùm Alaska Sốt Bơ (phong cách Pháp, bơ tỏi, rượu vang trắng): 3.200.000đ\n" +
        "- Gan Ngỗng Áp Chảo (sốt việt quất): 1.800.000đ\n\n" +
        "🥗 MÓN ĂN KÈM:\n" +
        "- Khoai tây nghiền Truffle (nấm Truffle đen, bơ Pháp): 180.000đ\n" +
        "- Măng tây nướng than hoa (Parmesan, dầu oliu chanh): 150.000đ\n" +
        "- Rau chân vịt xào kem (kem tươi, tỏi phi): 140.000đ\n\n" +
        "🍷 SỐT ĐẶC TRƯNG (miễn phí khi gọi bít tết):\n" +
        "- Sốt Vang Đỏ (Red Wine Jus)\n" +
        "- Sốt Tiêu Đen Phú Quốc\n" +
        "- Sốt Nấm Wild Mushroom\n" +
        "- Sốt Phô Mai Xanh Blue Cheese\n\n" +
        "🍸 ĐỒ UỐNG:\n" +
        "- Rượu vang đỏ: Cabernet Sauvignon 2015 (gợi ý với Wagyu)\n" +
        "- Cocktail đặc trưng của nhà hàng\n" +
        "- Nước khoáng Perrier, Evian\n\n" +
        "DỊCH VỤ:\n" +
        "- Đặt bàn online qua website (chọn bàn trên sơ đồ 3D)\n" +
        "- Thanh toán qua VietQR / chuyển khoản ngân hàng\n" +
        "- Phục vụ tận bàn, riêng tư tuyệt đối\n\n" +
        "HƯỚNG DẪN TRẢ LỜI:\n" +
        "- Luôn thân thiện, lịch sự, nhiệt tình như một nhân viên phục vụ cao cấp\n" +
        "- Gợi ý món ăn phù hợp với sở thích và ngân sách của khách\n" +
        "- Khi khách hỏi về món ăn, hãy mô tả hấp dẫn và gợi ý thêm món kèm hoặc đồ uống phù hợp\n" +
        "- Hướng dẫn khách đặt bàn tại /booking hoặc xem thực đơn tại /menu\n" +
        "- Trả lời bằng tiếng Việt trừ khi khách hỏi bằng tiếng Anh\n" +
        "- Giữ câu trả lời ngắn gọn, súc tích (tối đa 3-4 câu mỗi lần)\n" +
        "- Dùng emoji phù hợp để tạo cảm giác thân thiện";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Read request body
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
        }
        String requestBody = sb.toString();

        // Extract user message from JSON (simple parse)
        String userMessage = extractJsonString(requestBody, "message");
        String conversationHistory = extractJsonString(requestBody, "history");

        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.getWriter().write("{\"error\":\"Empty message\"}");
            return;
        }

        // Build messages array for OpenRouter
        StringBuilder messages = new StringBuilder("[");
        messages.append("{\"role\":\"system\",\"content\":").append(jsonEscape(SYSTEM_PROMPT)).append("}");

        // Add conversation history if present
        if (conversationHistory != null && !conversationHistory.isEmpty() && !conversationHistory.equals("[]")) {
            // history is already a JSON array string, insert its contents
            String historyContent = conversationHistory.trim();
            if (historyContent.startsWith("[") && historyContent.endsWith("]")) {
                String inner = historyContent.substring(1, historyContent.length() - 1).trim();
                if (!inner.isEmpty()) {
                    messages.append(",").append(inner);
                }
            }
        }

        messages.append(",{\"role\":\"user\",\"content\":").append(jsonEscape(userMessage)).append("}]");

        // Build OpenRouter request
        String payload = "{" +
            "\"model\":\"openai/gpt-4o-mini\"," +
            "\"messages\":" + messages.toString() + "," +
            "\"max_tokens\":400," +
            "\"temperature\":0.7" +
            "}";

        // Call OpenRouter API
        URL url = new URL(OPENROUTER_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + OPENROUTER_API_KEY);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("HTTP-Referer", "https://vesper-restaurant.com");
        conn.setRequestProperty("X-Title", "VESPER Restaurant Chatbot");
        conn.setDoOutput(true);
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(30000);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(payload.getBytes(StandardCharsets.UTF_8));
        }

        int statusCode = conn.getResponseCode();
        InputStream is = (statusCode >= 200 && statusCode < 300) ? conn.getInputStream() : conn.getErrorStream();

        StringBuilder apiResponse = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) apiResponse.append(line);
        }

        if (statusCode >= 200 && statusCode < 300) {
            // Extract content from OpenRouter response
            String content = extractChoiceContent(apiResponse.toString());
            response.getWriter().write("{\"reply\":" + jsonEscape(content) + "}");
        } else {
            response.getWriter().write("{\"error\":\"API error " + statusCode + "\"}");
        }
    }

    /** Extract a top-level string value from a simple JSON object */
    private String extractJsonString(String json, String key) {
        if (json == null) return null;
        String search = "\"" + key + "\"";
        int idx = json.indexOf(search);
        if (idx < 0) return null;
        int colon = json.indexOf(':', idx + search.length());
        if (colon < 0) return null;
        int start = colon + 1;
        while (start < json.length() && json.charAt(start) == ' ') start++;
        if (start >= json.length()) return null;
        char first = json.charAt(start);
        if (first == '"') {
            // String value
            StringBuilder result = new StringBuilder();
            int i = start + 1;
            while (i < json.length()) {
                char c = json.charAt(i);
                if (c == '\\' && i + 1 < json.length()) {
                    char next = json.charAt(i + 1);
                    switch (next) {
                        case '"': result.append('"'); break;
                        case '\\': result.append('\\'); break;
                        case 'n': result.append('\n'); break;
                        case 'r': result.append('\r'); break;
                        case 't': result.append('\t'); break;
                        default: result.append(next);
                    }
                    i += 2;
                } else if (c == '"') {
                    break;
                } else {
                    result.append(c);
                    i++;
                }
            }
            return result.toString();
        } else if (first == '[') {
            // Array value - find matching bracket
            int depth = 0;
            int i = start;
            while (i < json.length()) {
                char c = json.charAt(i);
                if (c == '[') depth++;
                else if (c == ']') { depth--; if (depth == 0) return json.substring(start, i + 1); }
                i++;
            }
        }
        return null;
    }

    /** Extract the assistant reply content from OpenRouter response */
    private String extractChoiceContent(String json) {
        // Look for "content":"..." in choices[0].message
        int contentIdx = json.indexOf("\"content\"");
        if (contentIdx < 0) return "Xin lỗi, tôi không thể trả lời lúc này. Vui lòng thử lại!";
        int colon = json.indexOf(':', contentIdx + 9);
        if (colon < 0) return "Xin lỗi, có lỗi xảy ra.";
        int start = colon + 1;
        while (start < json.length() && json.charAt(start) == ' ') start++;
        if (start >= json.length() || json.charAt(start) != '"') return "Xin lỗi, có lỗi xảy ra.";

        StringBuilder result = new StringBuilder();
        int i = start + 1;
        while (i < json.length()) {
            char c = json.charAt(i);
            if (c == '\\' && i + 1 < json.length()) {
                char next = json.charAt(i + 1);
                switch (next) {
                    case '"': result.append('"'); break;
                    case '\\': result.append('\\'); break;
                    case 'n': result.append('\n'); break;
                    case 'r': result.append('\r'); break;
                    case 't': result.append('\t'); break;
                    default: result.append(next);
                }
                i += 2;
            } else if (c == '"') {
                break;
            } else {
                result.append(c);
                i++;
            }
        }
        return result.toString();
    }

    /** Wrap a Java string as a JSON string literal */
    private String jsonEscape(String s) {
        if (s == null) return "null";
        StringBuilder sb = new StringBuilder("\"");
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"': sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (c < 0x20) sb.append(String.format("\\u%04x", (int) c));
                    else sb.append(c);
            }
        }
        sb.append("\"");
        return sb.toString();
    }
}
