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
     * Find reservations with a given status whose reservationTime is before cutoff
     */
    public List<Reservations> findByStatusBefore(String status, Date cutoff) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Reservations> query = em.createQuery(
                "SELECT r FROM Reservations r WHERE r.status = :status AND r.reservationTime <= :cutoff",
                Reservations.class
            );
            query.setParameter("status", status);
            query.setParameter("cutoff", cutoff);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Create new reservation with table
     */
    public Reservations createReservation(Customers customer, Tables table, Date reservationTime, int guestCount) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Reservations reservation = new Reservations();
            reservation.setCustomerId(customer);
            reservation.setTableId(table);
            reservation.setReservationTime(reservationTime);
            reservation.setGuestCount(guestCount);
            reservation.setStatus("CONFIRMED");
            reservation.setCreatedAt(new Date());
            
            em.persist(reservation);
            em.getTransaction().commit();
            
            return reservation;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
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
