package service;

import dao.OrderDAO;
import model.Orders;
import java.util.List;

/**
 * Service đơn hàng dành cho Staff.
 * Controller chỉ gọi service này, không gọi DAO trực tiếp.
 */
public class StaffOrderService {

    private final OrderDAO orderDAO;

    public StaffOrderService() {
        this.orderDAO = new OrderDAO();
    }

    /**
     * Lấy danh sách đơn hàng theo trạng thái.
     * Mặc định trả OPEN nếu status null/blank.
     */
    public List<Orders> getOrdersByStatus(String status) {
        if (status == null || status.isBlank()) {
            status = "OPEN";
        }
        return orderDAO.findByStatus(status);
    }

    /**
     * Lấy đơn hàng kèm chi tiết món.
     */
    public Orders getOrderWithItems(Integer orderId) {
        return orderDAO.findWithItems(orderId);
    }

    /**
     * Hủy đơn hàng: OPEN → CANCELLED.
     */
    public boolean cancelOrder(Integer orderId) {
        Orders order = orderDAO.findById(orderId);
        if (order == null || !"OPEN".equals(order.getStatus())) {
            return false;
        }
        order.setStatus("CANCELLED");
        orderDAO.update(order);
        return true;
    }
}
