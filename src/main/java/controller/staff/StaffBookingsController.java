package controller.staff;

import dao.ReservationDAO;
import dao.TableDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reservations;
import model.Users;
import java.util.logging.Logger;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffBookingsController", urlPatterns = {"/staff/bookings"})
public class StaffBookingsController extends HttpServlet {

    private ReservationDAO reservationDAO;
    private TableDAO tableDAO;
    private static final Logger logger = Logger.getLogger(StaffBookingsController.class.getName());

    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
        tableDAO = new TableDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        if (status == null || status.isBlank()) status = "PENDING";
        List<Reservations> list = reservationDAO.findByStatus(status);
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
            if ("confirm".equalsIgnoreCase(action)) {
                boolean ok = reservationDAO.updateStatus(id, "CONFIRMED");
                logger.info(String.format("AUDIT staff=%s action=confirm reservation=%d ok=%s time=%d",
                        staff != null ? staff.getUserId() : "unknown", id, ok, System.currentTimeMillis()));
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=PENDING" + (ok ? "&success=confirmed" : "&error=confirm_failed"));
                return;
            }
            if ("cancel".equalsIgnoreCase(action)) {
                boolean ok = reservationDAO.updateStatus(id, "CANCELLED");
                Reservations r = reservationDAO.findById(id);
                if (ok && r != null && r.getTableId() != null) {
                    tableDAO.updateStatus(r.getTableId().getTableId(), "AVAILABLE");
                }
                logger.info(String.format("AUDIT staff=%s action=cancel reservation=%d ok=%s time=%d",
                        staff != null ? staff.getUserId() : "unknown", id, ok, System.currentTimeMillis()));
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=PENDING" + (ok ? "&success=cancelled" : "&error=cancel_failed"));
                return;
            }
            if ("no_show".equalsIgnoreCase(action)) {
                boolean ok = reservationDAO.updateStatus(id, "NO_SHOW");
                Reservations r = reservationDAO.findById(id);
                if (ok && r != null && r.getTableId() != null) {
                    tableDAO.updateStatus(r.getTableId().getTableId(), "AVAILABLE");
                }
                logger.info(String.format("AUDIT staff=%s action=no_show reservation=%d ok=%s time=%d",
                        staff != null ? staff.getUserId() : "unknown", id, ok, System.currentTimeMillis()));
                response.sendRedirect(request.getContextPath() + "/staff/bookings?status=PENDING" + (ok ? "&success=no_show" : "&error=no_show_failed"));
                return;
            }
            response.sendRedirect(request.getContextPath() + "/staff/bookings?error=unknown_action");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/bookings?error=invalid_id");
        }
    }
}
