package service;

import dao.OrderDAO;
import model.Orders;
import java.util.Comparator;
import java.util.List;

/**
 * Service cho Bảng bếp — hiển thị các đơn OPEN kèm chi tiết món.
 * Sắp xếp theo thời gian order (cũ nhất trước).
 */
public class KitchenBoardService {

    private final OrderDAO orderDAO;

    public KitchenBoardService() {
        this.orderDAO = new OrderDAO();
    }

    /**
     * Lấy tất cả đơn OPEN kèm chi tiết món, sắp xếp theo thời gian cũ nhất trước.
     */
    public List<Orders> getOpenOrdersWithItems() {
        List<Orders> orders = orderDAO.findByStatus("OPEN");
        // Force load items cho mỗi đơn
        for (Orders order : orders) {
            Orders withItems = orderDAO.findWithItems(order.getOrderId());
            if (withItems != null) {
                order.setOrderItemsCollection(withItems.getOrderItemsCollection());
            }
        }
        // Sắp xếp theo thời gian order (cũ nhất trước)
        orders.sort(Comparator.comparing(o -> o.getOrderTime() != null ? o.getOrderTime().getTime() : 0L));
        return orders;
    }
}
