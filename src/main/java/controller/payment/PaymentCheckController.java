package controller.payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.PaymentService;
import service.SepayService;
import dao.PaymentDAO;
import dao.OrderDAO;
import model.Payments;
import model.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

/**
 * API endpoint để kiểm tra trạng thái thanh toán
 * Frontend sẽ gọi API này mỗi 5 giây để kiểm tra
 * API này sẽ tự động kiểm tra giao dịch qua Sepay
 */
@WebServlet(name = "PaymentCheckController", urlPatterns = {"/payment/check"})
public class PaymentCheckController extends HttpServlet {
    
    private PaymentService paymentService;
    private SepayService sepayService;
    private PaymentDAO paymentDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
        sepayService = new SepayService();
        paymentDAO = new PaymentDAO();
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String paymentIdStr = request.getParameter("paymentId");
        
        JSONObject jsonResponse = new JSONObject();
        
        try {
            if (paymentIdStr == null || paymentIdStr.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Missing paymentId");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                Integer paymentId = Integer.parseInt(paymentIdStr);
                
                // Lấy thông tin payment
                Payments payment = paymentDAO.findById(paymentId);
                
                System.out.println("[PaymentCheck] ========================================");
                System.out.println("[PaymentCheck] Payment ID: " + paymentId);
                
                if (payment == null) {
                    System.out.println("[PaymentCheck] ERROR: Payment not found!");
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Payment not found");
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                } else {
                    System.out.println("[PaymentCheck] Payment Status: " + payment.getPaymentStatus());
                    System.out.println("[PaymentCheck] Deposit Amount: " + payment.getDepositAmount());
                    
                    // Kiểm tra xem đã completed chưa
                    boolean isCompleted = "COMPLETED".equals(payment.getPaymentStatus());
                    System.out.println("[PaymentCheck] Is Completed: " + isCompleted);
                    
                    if (!isCompleted) {
                        // Chưa completed -> Kiểm tra giao dịch qua Sepay
                        Orders order = payment.getOrderId();
                        if (order != null && order.getCustomerId() != null) {
                            String customerName = order.getCustomerId().getFullName();
                            String transferContent = paymentService.generateTransferContent(
                                order.getOrderId(), 
                                customerName
                            );
                            
                            System.out.println("[PaymentCheck] Checking Sepay for payment #" + paymentId);
                            System.out.println("[PaymentCheck] Expected content: " + transferContent);
                            System.out.println("[PaymentCheck] Expected amount: " + payment.getDepositAmount());
                            
                            // Kiểm tra giao dịch qua Sepay
                            boolean transactionFound = sepayService.checkTransaction(
                                transferContent,
                                payment.getDepositAmount(),
                                null // Không filter theo account number
                            );
                            
                            if (transactionFound) {
                                // Tìm thấy giao dịch -> Tự động xác nhận
                                System.out.println("[PaymentCheck] ✓ Transaction found! Auto-confirming...");
                                
                                boolean updated = paymentService.updatePaymentStatus(paymentId, "COMPLETED");
                                
                                if (updated) {
                                    // Cập nhật order status (PAID = đã thanh toán)
                                    order.setStatus("PAID");
                                    orderDAO.update(order);
                                    
                                    // Cập nhật reservation status từ PENDING -> BOOKED
                                    if (order.getReservationId() != null) {
                                        dao.ReservationDAO reservationDAO = new dao.ReservationDAO();
                                        boolean reservationUpdated = reservationDAO.updateStatus(
                                            order.getReservationId().getReservationId(), 
                                            "BOOKED"
                                        );
                                        if (reservationUpdated) {
                                            System.out.println("[PaymentCheck] ✓ Reservation status updated to BOOKED");
                                            
                                            // Cập nhật table status từ RESERVED -> OCCUPIED
                                            if (order.getReservationId().getTableId() != null) {
                                                dao.TableDAO tableDAO = new dao.TableDAO();
                                                tableDAO.updateStatus(
                                                    order.getReservationId().getTableId().getTableId(),
                                                    "OCCUPIED"
                                                );
                                                System.out.println("[PaymentCheck] ✓ Table status updated to OCCUPIED");
                                            }
                                        } else {
                                            System.err.println("[PaymentCheck] Failed to update reservation status");
                                        }
                                    }
                                    
                                    isCompleted = true;
                                    System.out.println("[PaymentCheck] ✓ Payment confirmed successfully!");
                                } else {
                                    System.err.println("[PaymentCheck] Failed to update payment status");
                                }
                            } else {
                                System.out.println("[PaymentCheck] Transaction not found yet");
                            }
                        }
                    }
                    
                    jsonResponse.put("success", true);
                    jsonResponse.put("completed", isCompleted);
                    jsonResponse.put("status", isCompleted ? "COMPLETED" : "PENDING");
                    
                    if (isCompleted) {
                        jsonResponse.put("message", "Payment completed successfully");
                    } else {
                        jsonResponse.put("message", "Payment pending");
                    }
                    
                    response.setStatus(HttpServletResponse.SC_OK);
                }
            }
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid paymentId format");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
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
