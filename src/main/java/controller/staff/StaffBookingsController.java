package controller.staff;

import service.BookingService;
import service.StaffActionLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reservations;
import model.Users;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffBookingsController", urlPatterns = { "/staff/bookings" })
public class StaffBookingsController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        if (status == null || status.isBlank())
            status = "BOOKED";

        List<Reservations> list = bookingService.getReservationsByStatus(status);
        request.setAttribute("status", status);
        request.setAttribute("reservations", list);
        request.getRequestDispatcher("/views/staff/bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if (action == null || idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff/bookings?error=missing_params");
            return;
        }

        try {
            Integer id = Integer.valueOf(idStr);
            Users staff = (Users) request.getSession().getAttribute("loggedInUser");
            Integer staffUserId = staff != null ? staff.getUserId() : null;

            if ("confirm".equalsIgnoreCase(action)) {
                boolean ok = bookingService.confirmReservation(id, staffUserId);
                if (ok) {
                    String staffName = staff != null ? staff.getUsername() : "unknown";
                    StaffActionLog.record(staffName, "XÁC NHẬN ĐẶT BÀN", "RESERVATION", id,
                            "Đặt bàn #" + id + " đã xác nhận");
                }
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED"
                        + (ok ? "&success=confirmed" : "&error=confirm_failed"));
                return;
            }

            if ("cancel".equalsIgnoreCase(action)) {
                String reason = request.getParameter("reason");
                if (reason == null || reason.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED&error=need_reason");
                    return;
                }
                boolean ok = bookingService.cancelReservationWithReason(id, reason, staffUserId);
                if (ok) {
                    String staffName = staff != null ? staff.getUsername() : "unknown";
                    StaffActionLog.record(staffName, "HỦY ĐẶT BÀN", "RESERVATION", id, "Lý do: " + reason);
                }
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED"
                        + (ok ? "&success=cancelled" : "&error=cancel_failed"));
                return;
            }

            if ("no_show".equalsIgnoreCase(action)) {
                boolean ok = bookingService.markNoShow(id, staffUserId);
                if (ok) {
                    String staffName = staff != null ? staff.getUsername() : "unknown";
                    StaffActionLog.record(staffName, "KHÁCH KHÔNG ĐẾN", "RESERVATION", id,
                            "Đặt bàn #" + id + " - khách không đến");
                }
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED"
                        + (ok ? "&success=no_show" : "&error=no_show_failed"));
                return;
            }

            if ("update".equalsIgnoreCase(action)) {
                String newTime = request.getParameter("reservationTime");
                String newTableIdStr = request.getParameter("tableId");
                String result = bookingService.updateReservation(id, newTime, newTableIdStr, staffUserId);

                if ("ok".equals(result)) {
                    String staffName = staff != null ? staff.getUsername() : "unknown";
                    StaffActionLog.record(staffName, "CẬP NHẬT ĐẶT BÀN", "RESERVATION", id,
                            "Giờ: " + newTime + ", Bàn: " + newTableIdStr);
                    response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED&success=updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/bookings?status=BOOKED&error=" + result);
                }
                return;
            }

            response.sendRedirect(request.getContextPath() + "/staff/bookings?error=unknown_action");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/bookings?error=invalid_id");
        }
    }
}
