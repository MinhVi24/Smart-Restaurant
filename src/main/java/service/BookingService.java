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
import java.util.Date;
import java.util.List;

public class BookingService {
    
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
     * Get available tables for specific date/time and guest count
     * Checks against existing reservations
     */
    public List<Tables> getAvailableTablesForDateTime(Date reservationTime, int guestCount) {
        // Get all tables with sufficient capacity
        List<Tables> tables = tableDAO.findAvailableByCapacity(guestCount);
        
        // Filter out tables that have reservations at the same time
        // (within 2 hours window)
        List<Reservations> reservations = reservationDAO.findByDateTime(reservationTime);
        
        for (Reservations reservation : reservations) {
            if (reservation.getTableId() != null && 
                !"CANCELLED".equals(reservation.getStatus())) {
                tables.removeIf(t -> t.getTableId().equals(reservation.getTableId().getTableId()));
            }
        }
        
        return tables;
    }
    
    /**
     * Create reservation with table
     * Allow any table status for testing/development
     */
    public Reservations createReservation(Customers customer, Integer tableId, Date reservationTime, int guestCount) {
        Tables table = tableDAO.findById(tableId);
        
        if (table == null) {
            System.out.println("ERROR: Table not found: " + tableId);
            return null;
        }
        
        System.out.println("Creating reservation for table " + tableId + " (current status: " + table.getStatus() + ")");
        
        // Create reservation regardless of table status
        // This allows testing without resetting database
        Reservations reservation = reservationDAO.createReservation(customer, table, reservationTime, guestCount);
        
        if (reservation != null) {
            // Update table status to RESERVED
            tableDAO.updateStatus(tableId, "RESERVED");
            System.out.println("SUCCESS: Created reservation " + reservation.getReservationId() + " for table " + tableId);
        } else {
            System.out.println("ERROR: Failed to create reservation in database");
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
            String paymentMethod
    ) {
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
    
    /**
     * Result class for booking completion
     */
    public static class BookingResult {
        private final boolean success;
        private final String message;
        private final Reservations reservation;
        private final Orders order;
        private final Payments payment;
        
        public BookingResult(boolean success, String message, Reservations reservation, Orders order, Payments payment) {
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
