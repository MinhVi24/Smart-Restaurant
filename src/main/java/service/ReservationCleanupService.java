package service;

import dao.ReservationDAO;
import dao.TableDAO;
import model.Reservations;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Service to clean up old reservations
 * Should be called periodically (e.g., daily at midnight)
 */
public class ReservationCleanupService {
    
    private final ReservationDAO reservationDAO;
    private final TableDAO tableDAO;
    
    public ReservationCleanupService() {
        this.reservationDAO = new ReservationDAO();
        this.tableDAO = new TableDAO();
    }
    
    /**
     * Mark old reservations as COMPLETED and release their tables
     * This should be called daily to prevent old reservations from blocking table availability
     */
    public int cleanupOldReservations() {
        System.out.println("=== CLEANUP: Starting old reservation cleanup ===");
        
        // Get start of today (00:00:00)
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date todayStart = cal.getTime();
        
        // Find all active reservations before today
        List<Reservations> oldReservations = reservationDAO.findByDateRange(
            new Date(0), // From epoch
            todayStart   // Until today
        );
        
        int cleanedCount = 0;
        
        for (Reservations reservation : oldReservations) {
            String status = reservation.getStatus();
            
            // Only update PENDING, BOOKED, CONFIRMED (not already COMPLETED or CANCELLED)
            if ("PENDING".equals(status) || "BOOKED".equals(status) || "CONFIRMED".equals(status)) {
                // Update reservation to COMPLETED
                boolean updated = reservationDAO.updateStatus(
                    reservation.getReservationId(), 
                    "COMPLETED"
                );
                
                if (updated) {
                    cleanedCount++;
                    
                    // Release the table if it was reserved
                    if (reservation.getTableId() != null) {
                        Integer tableId = reservation.getTableId().getTableId();
                        String tableStatus = reservation.getTableId().getStatus();
                        
                        // Only update if table is still RESERVED or OCCUPIED
                        if ("RESERVED".equals(tableStatus) || "OCCUPIED".equals(tableStatus)) {
                            tableDAO.updateStatus(tableId, "AVAILABLE");
                            System.out.println("  Released table " + tableId);
                        }
                    }
                    
                    System.out.println("  Completed reservation " + reservation.getReservationId() + 
                                     " (was " + status + ")");
                }
            }
        }
        
        System.out.println("=== CLEANUP: Completed " + cleanedCount + " old reservations ===");
        return cleanedCount;
    }
    
    /**
     * Get count of active reservations that need cleanup
     */
    public int getOldReservationCount() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date todayStart = cal.getTime();
        
        List<Reservations> oldReservations = reservationDAO.findByDateRange(
            new Date(0),
            todayStart
        );
        
        int count = 0;
        for (Reservations r : oldReservations) {
            String status = r.getStatus();
            if ("PENDING".equals(status) || "BOOKED".equals(status) || "CONFIRMED".equals(status)) {
                count++;
            }
        }
        
        return count;
    }
}
