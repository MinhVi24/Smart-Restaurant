package controller.staff;

import service.StaffPaymentService;
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

@WebServlet(name = "StaffPaymentsController", urlPatterns = { "/staff/payments" })
public class StaffPaymentsController extends HttpServlet {

    private StaffPaymentService paymentService;

    @Override
    public void init() throws ServletException {
        paymentService = new StaffPaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Orders> unpaidOrders = paymentService.getUnpaidOrders();
        request.setAttribute("unpaidOrders", unpaidOrders);
        request.getRequestDispatcher("/views/staff/payments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff/payments?error=missing_id");
            return;
        }
        try {
            Integer orderId = Integer.valueOf(orderIdStr);
            boolean ok = paymentService.confirmPayment(orderId);

            if (ok) {
                Users staff = (Users) request.getSession().getAttribute("loggedInUser");
                String staffName = staff != null ? staff.getUsername() : "unknown";
                StaffActionLog.record(staffName, "XÁC NHẬN THANH TOÁN", "ORDER", orderId,
                        "Đơn #" + orderId + " đã thanh toán");
            }

            response.sendRedirect(request.getContextPath() + "/staff/payments"
                    + (ok ? "?success=paid" : "?error=pay_failed"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/payments?error=invalid_id");
        }
    }
}
