package service;

import dao.TableDAO;
import dao.ReservationDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import dao.MenuItemDAO;
import model.Tables;
import model.Reservations;
import model.Orders;
import model.Payments;
import model.Customers;
import model.OrderItems;
import model.MenuItems;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

public class BookingService {

    private static final Logger logger = Logger.getLogger(BookingService.class.getName());

    private final TableDAO tableDAO;
    private final ReservationDAO reservationDAO;
    private final OrderDAO orderDAO;
    private final PaymentDAO paymentDAO;
    private final MenuItemDAO menuItemDAO;

    public BookingService() {
        this.tableDAO = new TableDAO();
        this.reservationDAO = new ReservationDAO();
        this.orderDAO = new OrderDAO();
        this.paymentDAO = new PaymentDAO();
        this.menuItemDAO = new MenuItemDAO();
    }

    /**
     * Get all tables (including occupied and reserved) - for admin
     */
    public List<Tables> getAllTables() {
        return tableDAO.findAll();
    }

    /**
     * Update table status - for admin
     */
    public boolean updateTableStatus(Integer tableId, String status) {
        return tableDAO.updateStatus(tableId, status);
    }

    /**
     * Get all available tables
     */
    public List<Tables> getAvailableTables() {
        return tableDAO.findByStatus("AVAILABLE");
    }

    /**
     * Get available tables by area
     */
    public List<Tables> getAvailableTablesByArea(String area) {
        List<Tables> tables = tableDAO.findByArea(area);
        tables.removeIf(t -> !"AVAILABLE".equals(t.getStatus()));
        return tables;
    }

    /**
     * Get available tables by capacity
     */
    public List<Tables> getAvailableTablesByCapacity(int minCapacity) {
        return tableDAO.findAvailableByCapacity(minCapacity);
    }

    /**
     * Create reservation with table
     */
    public Reservations createReservation(Customers customer, Integer tableId, Date reservationTime, int guestCount) {
        Tables table = tableDAO.findById(tableId);

        if (table == null || !"AVAILABLE".equals(table.getStatus())) {
            return null;
        }

        // Create reservation
        Reservations reservation = reservationDAO.createReservation(customer, table, reservationTime, guestCount);

        if (reservation != null) {
            // Update table status to RESERVED
            tableDAO.updateStatus(tableId, "RESERVED");
        }

        return reservation;
    }

    /**
     * Complete booking with order and payment
     */
    public BookingResult completeBooking(
            Integer reservationId,
            List<OrderItems> orderItems,
            BigDecimal totalAmount,
            Integer depositPercentage,
            String paymentMethod) {
        Reservations reservation = reservationDAO.findById(reservationId);

        if (reservation == null) {
            return new BookingResult(false, "Reservation not found", null, null, null);
        }

        // Create order
        Orders order = orderDAO.createOrderFromReservation(reservation, orderItems, totalAmount);

        if (order == null) {
            return new BookingResult(false, "Failed to create order", null, null, null);
        }

        // Create payment
        Payments payment = paymentDAO.createPayment(order, totalAmount, depositPercentage, paymentMethod);

        if (payment == null) {
            return new BookingResult(false, "Failed to create payment", null, null, null);
        }

        // Update reservation status
        reservationDAO.updateStatus(reservationId, "CONFIRMED");

        // Update table status to OCCUPIED
        if (reservation.getTableId() != null) {
            tableDAO.updateStatus(reservation.getTableId().getTableId(), "OCCUPIED");
        }

        return new BookingResult(true, "Booking completed successfully", reservation, order, payment);
    }

    /**
     * Cancel reservation
     */
    public boolean cancelReservation(Integer reservationId) {
        Reservations reservation = reservationDAO.findById(reservationId);

        if (reservation == null) {
            return false;
        }

        // Update reservation status
        boolean updated = reservationDAO.updateStatus(reservationId, "CANCELLED");

        if (updated && reservation.getTableId() != null) {
            // Release table
            tableDAO.updateStatus(reservation.getTableId().getTableId(), "AVAILABLE");
        }

        return updated;
    }

    /**
     * Get customer reservations
     */
    public List<Reservations> getCustomerReservations(Integer customerId) {
        return reservationDAO.findByCustomer(customerId);
    }

    /**
     * Get all available menu items
     */
    public List<MenuItems> getAvailableMenuItems() {
        return menuItemDAO.findAll();
    }

    // =========================================================================
    // Staff-specific methods
    // =========================================================================

    /**
     * Lấy danh sách reservation theo trạng thái
     */
    public List<Reservations> getReservationsByStatus(String status) {
        if (status == null || status.isBlank()) {
            status = "BOOKED";
        }
        return reservationDAO.findByStatus(status);
    }

    /**
     * Staff xác nhận đặt bàn.
     * Reservation → CONFIRMED, Bàn → RESERVED.
     */
    public boolean confirmReservation(Integer reservationId, Integer staffUserId) {
        boolean ok = reservationDAO.updateStatus(reservationId, "CONFIRMED");
        if (ok) {
            Reservations r = reservationDAO.findById(reservationId);
            if (r != null && r.getTableId() != null) {
                tableDAO.updateStatus(r.getTableId().getTableId(), "RESERVED");
            }
        }
        logger.info(String.format("AUDIT staff=%s action=confirm reservation=%d ok=%s time=%d",
                staffUserId != null ? staffUserId : "unknown", reservationId, ok, System.currentTimeMillis()));
        return ok;
    }

    /**
     * Staff hủy đặt bàn với lý do.
     * Reservation → CANCELLED, Bàn → AVAILABLE.
     */
    public boolean cancelReservationWithReason(Integer reservationId, String reason, Integer staffUserId) {
        boolean ok = reservationDAO.updateStatus(reservationId, "CANCELLED");
        Reservations r = reservationDAO.findById(reservationId);
        if (ok && r != null && r.getTableId() != null) {
            tableDAO.updateStatus(r.getTableId().getTableId(), "AVAILABLE");
        }
        logger.info(String.format("AUDIT staff=%s action=cancel reservation=%d ok=%s reason=%s time=%d",
                staffUserId != null ? staffUserId : "unknown", reservationId, ok, reason, System.currentTimeMillis()));
        return ok;
    }

    /**
     * Staff đánh dấu khách không đến (no-show).
     * Reservation → CANCELLED, Bàn → AVAILABLE.
     */
    public boolean markNoShow(Integer reservationId, Integer staffUserId) {
        boolean ok = reservationDAO.updateStatus(reservationId, "CANCELLED");
        Reservations r = reservationDAO.findById(reservationId);
        if (ok && r != null && r.getTableId() != null) {
            tableDAO.updateStatus(r.getTableId().getTableId(), "AVAILABLE");
        }
        logger.info(String.format("AUDIT staff=%s action=no_show reservation=%d ok=%s time=%d",
                staffUserId != null ? staffUserId : "unknown", reservationId, ok, System.currentTimeMillis()));
        return ok;
    }

    /**
     * Staff cập nhật giờ hẹn và/hoặc bàn cho reservation.
     * Có kiểm tra xung đột ±60 phút trước khi cập nhật.
     *
     * @return "ok" nếu thành công, hoặc mã lỗi: "not_found", "conflict",
     *         "update_failed", "missing_params"
     */
    public String updateReservation(Integer reservationId, String newTime, String newTableIdStr, Integer staffUserId) {
        if ((newTime == null || newTime.isEmpty()) && (newTableIdStr == null || newTableIdStr.isEmpty())) {
            return "missing_params";
        }

        Reservations r = reservationDAO.findById(reservationId);
        if (r == null) {
            return "not_found";
        }

        // Parse thời gian mới
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date targetTime = r.getReservationTime();
        if (newTime != null && !newTime.isEmpty()) {
            try {
                targetTime = fmt.parse(newTime);
            } catch (Exception ignored) {
            }
        }

        // Parse bàn mới
        Integer targetTableId = r.getTableId() != null ? r.getTableId().getTableId() : null;
        if (newTableIdStr != null && !newTableIdStr.isEmpty()) {
            try {
                targetTableId = Integer.valueOf(newTableIdStr);
            } catch (NumberFormatException ignored) {
            }
        }

        // Kiểm tra xung đột ±60 phút
        Calendar cal = Calendar.getInstance();
        cal.setTime(targetTime);
        cal.add(Calendar.MINUTE, -60);
        Date start = cal.getTime();
        cal.setTime(targetTime);
        cal.add(Calendar.MINUTE, 60);
        Date end = cal.getTime();

        List<Reservations> conflicts = reservationDAO.findByTableAndTimeRange(targetTableId, start, end);
        conflicts.removeIf(x -> x.getReservationId().equals(reservationId));
        if (!conflicts.isEmpty()) {
            return "conflict";
        }

        // Cập nhật
        if (targetTableId != null
                && (r.getTableId() == null || !targetTableId.equals(r.getTableId().getTableId()))) {
            Tables t = new Tables();
            t.setTableId(targetTableId);
            r.setTableId(t);
        }
        r.setReservationTime(targetTime);

        boolean ok = reservationDAO.updateReservation(r);
        if (!ok) {
            return "update_failed";
        }

        logger.info(String.format("AUDIT staff=%s action=update reservation=%d time=%s table=%s",
                staffUserId != null ? staffUserId : "unknown", reservationId, newTime, newTableIdStr));
        return "ok";
    }

    /**
     * Result class for booking completion
     */
    public static class BookingResult {
        private final boolean success;
        private final String message;
        private final Reservations reservation;
        private final Orders order;
        private final Payments payment;

        public BookingResult(boolean success, String message, Reservations reservation, Orders order,
                Payments payment) {
            this.success = success;
            this.message = message;
            this.reservation = reservation;
            this.order = order;
            this.payment = payment;
        }

        public boolean isSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }

        public Reservations getReservation() {
            return reservation;
        }

        public Orders getOrder() {
            return order;
        }

        public Payments getPayment() {
            return payment;
        }
    }
}
