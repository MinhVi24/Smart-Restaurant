package controller.staff;

import service.StaffOrderService;
import service.StaffActionLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Orders;
import model.Users;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffOrdersController", urlPatterns = { "/staff/orders" })
public class StaffOrdersController extends HttpServlet {

    private StaffOrderService staffOrderService;

    @Override
    public void init() throws ServletException {
        staffOrderService = new StaffOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        if (status == null || status.isBlank())
            status = "OPEN";

        List<Orders> list = staffOrderService.getOrdersByStatus(status);
        // Load items cho mỗi đơn
        for (Orders o : list) {
            Orders withItems = staffOrderService.getOrderWithItems(o.getOrderId());
            if (withItems != null) {
                o.setOrderItemsCollection(withItems.getOrderItemsCollection());
            }
        }
        request.setAttribute("status", status);
        request.setAttribute("orders", list);
        request.getRequestDispatcher("/views/staff/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        if (action == null || orderIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff/orders?error=missing_params");
            return;
        }
        try {
            Integer orderId = Integer.valueOf(orderIdStr);

            if ("cancel".equalsIgnoreCase(action)) {
                boolean ok = staffOrderService.cancelOrder(orderId);
                if (ok) {
                    Users staff = (Users) request.getSession().getAttribute("loggedInUser");
                    String staffName = staff != null ? staff.getUsername() : "unknown";
                    StaffActionLog.record(staffName, "HỦY ĐƠN", "ORDER", orderId,
                            "Đơn #" + orderId + " đã bị hủy");
                }
                response.sendRedirect(request.getContextPath() + "/staff/orders?status=OPEN"
                        + (ok ? "&success=cancelled" : "&error=cancel_failed"));
                return;
            }

            response.sendRedirect(request.getContextPath() + "/staff/orders?error=unknown_action");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/orders?error=invalid_id");
        }
    }
}
