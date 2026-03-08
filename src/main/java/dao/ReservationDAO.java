package dao;

import configs.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Reservations;
import model.Customers;
import model.Tables;
import java.util.Date;
import java.util.List;

public class ReservationDAO extends GenericDAO<Reservations> {

    public ReservationDAO() {
        super(Reservations.class);
    }

    /**
     * Find reservations by customer
     */
    public List<Reservations> findByCustomer(Integer customerId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Reservations> query = em.createQuery(
                "SELECT r FROM Reservations r WHERE r.customerId.customerId = :customerId ORDER BY r.reservationTime DESC",
                Reservations.class
            );
            query.setParameter("customerId", customerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find reservations by status
     */
    public List<Reservations> findByStatus(String status) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Reservations> query = em.createNamedQuery("Reservations.findByStatus", Reservations.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find reservations by date range
     */
    public List<Reservations> findByDateRange(Date startDate, Date endDate) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Reservations> query = em.createQuery(
                "SELECT r FROM Reservations r WHERE r.reservationTime BETWEEN :startDate AND :endDate ORDER BY r.reservationTime",
                Reservations.class
            );
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Find reservations by specific date/time (within 2 hour window)
     */
    public List<Reservations> findByDateTime(Date reservationTime) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            // Create 2-hour window (1 hour before, 1 hour after)
            long oneHour = 60 * 60 * 1000;
            Date startTime = new Date(reservationTime.getTime() - oneHour);
            Date endTime = new Date(reservationTime.getTime() + oneHour);
            
            TypedQuery<Reservations> query = em.createQuery(
                "SELECT r FROM Reservations r WHERE r.reservationTime BETWEEN :startTime AND :endTime " +
                "AND r.status IN ('BOOKED', 'CONFIRMED') ORDER BY r.reservationTime",
                Reservations.class
            );
            query.setParameter("startTime", startTime);
            query.setParameter("endTime", endTime);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Create new reservation with table - SIMPLIFIED VERSION
     */
    public Reservations createReservation(Customers customer, Tables table, Date reservationTime, int guestCount) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            System.out.println("=== ReservationDAO.createReservation ===");
            System.out.println("Customer: " + (customer != null ? customer.getCustomerId() + " - " + customer.getFullName() : "NULL"));
            System.out.println("Table: " + (table != null ? table.getTableId() + " - " + table.getStatus() : "NULL"));
            System.out.println("Reservation Time: " + reservationTime);
            System.out.println("Guest Count: " + guestCount);
            
            em.getTransaction().begin();
            
            // Find managed entities by ID to avoid detached entity issues
            Customers managedCustomer = em.find(Customers.class, customer.getCustomerId());
            Tables managedTable = em.find(Tables.class, table.getTableId());
            
            if (managedCustomer == null) {
                System.err.println("ERROR: Customer not found in database: " + customer.getCustomerId());
                em.getTransaction().rollback();
                return null;
            }
            
            if (managedTable == null) {
                System.err.println("ERROR: Table not found in database: " + table.getTableId());
                em.getTransaction().rollback();
                return null;
            }
            
            Reservations reservation = new Reservations();
            reservation.setCustomerId(managedCustomer);
            reservation.setTableId(managedTable);
            reservation.setReservationTime(reservationTime);
            reservation.setGuestCount(guestCount);
            reservation.setStatus("PENDING"); // PENDING until payment is confirmed
            reservation.setCreatedAt(new Date());
            
            System.out.println("Persisting reservation...");
            em.persist(reservation);
            
            System.out.println("Committing transaction...");
            em.getTransaction().commit();
            
            System.out.println("SUCCESS: Reservation created with ID: " + reservation.getReservationId());
            System.out.println("========================================");
            
            return reservation;
        } catch (Exception e) {
            System.err.println("ERROR in createReservation:");
            System.err.println("Exception type: " + e.getClass().getName());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            
            if (em.getTransaction().isActive()) {
                System.out.println("Rolling back transaction...");
                em.getTransaction().rollback();
            }
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Update reservation status
     */
    public boolean updateStatus(Integer reservationId, String status) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            Reservations reservation = em.find(Reservations.class, reservationId);
            if (reservation != null) {
                reservation.setStatus(status);
                em.merge(reservation);
                em.getTransaction().commit();
                return true;
            }
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
