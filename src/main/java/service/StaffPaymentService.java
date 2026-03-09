package service;

import dao.OrderDAO;
import dao.PaymentDAO;
import model.Orders;
import model.Payments;
import java.util.List;

/**
 * Service thanh toán dành cho Staff.
 * Xác nhận thanh toán: Orders → PAID, Payments → COMPLETED.
 */
public class StaffPaymentService {

    private final OrderDAO orderDAO;
    private final PaymentDAO paymentDAO;

    public StaffPaymentService() {
        this.orderDAO = new OrderDAO();
        this.paymentDAO = new PaymentDAO();
    }

    /**
     * Lấy danh sách đơn hàng OPEN (chưa thanh toán).
     */
    public List<Orders> getUnpaidOrders() {
        List<Orders> orders = orderDAO.findByStatus("OPEN");
        // Load items + payment cho mỗi đơn
        for (Orders order : orders) {
            Orders withItems = orderDAO.findWithItems(order.getOrderId());
            if (withItems != null) {
                order.setOrderItemsCollection(withItems.getOrderItemsCollection());
                order.setPayments(withItems.getPayments());
            }
        }
        return orders;
    }

    /**
     * Xác nhận thanh toán cho một đơn.
     * Order → PAID, Payment → COMPLETED (nếu có).
     */
    public boolean confirmPayment(Integer orderId) {
        // Cập nhật order status → PAID
        Orders order = orderDAO.findById(orderId);
        if (order == null || !"OPEN".equals(order.getStatus())) {
            return false;
        }
        order.setStatus("PAID");
        orderDAO.update(order);

        // Cập nhật payment_status → COMPLETED (nếu có payment)
        Payments payment = paymentDAO.findByOrder(orderId);
        if (payment != null && !"COMPLETED".equals(payment.getPaymentStatus())) {
            paymentDAO.completePayment(payment.getPaymentId());
        }

        return true;
    }
}
