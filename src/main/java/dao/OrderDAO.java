package dao;

import configs.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Orders;
import model.OrderItems;
import model.Customers;
import model.Tables;
import model.Reservations;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderDAO extends GenericDAO<Orders> {

    public OrderDAO() {
        super(Orders.class);
    }

    /**
     * Find orders by customer
     */
    public List<Orders> findByCustomer(Integer customerId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Orders> query = em.createQuery(
                "SELECT o FROM Orders o WHERE o.customerId.customerId = :customerId ORDER BY o.orderTime DESC",
                Orders.class
            );
            query.setParameter("customerId", customerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find orders by status
     */
    public List<Orders> findByStatus(String status) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Orders> query = em.createNamedQuery("Orders.findByStatus", Orders.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find order with items
     */
    public Orders findWithItems(Integer orderId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            Orders order = em.find(Orders.class, orderId);
            if (order != null) {
                // Force load order items
                order.getOrderItemsCollection().size();
            }
            return order;
        } finally {
            em.close();
        }
    }

    /**
     * Create order from reservation
     */
    public Orders createOrderFromReservation(Reservations reservation, List<OrderItems> items, BigDecimal totalAmount) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            System.out.println("=== OrderDAO.createOrderFromReservation ===");
            System.out.println("Reservation ID: " + reservation.getReservationId());
            System.out.println("Total Amount: " + totalAmount);
            System.out.println("Items count: " + items.size());
            
            em.getTransaction().begin();
            
            // Find managed entities by ID
            Reservations managedReservation = em.find(Reservations.class, reservation.getReservationId());
            if (managedReservation == null) {
                System.err.println("ERROR: Reservation not found: " + reservation.getReservationId());
                em.getTransaction().rollback();
                return null;
            }
            
            Orders order = new Orders();
            order.setCustomerId(managedReservation.getCustomerId());
            order.setTableId(managedReservation.getTableId());
            order.setReservationId(managedReservation);
            order.setOrderTime(new Date());
            order.setTotalAmount(totalAmount);
            order.setStatus("OPEN");
            
            // Set default staff for online orders (staff_id = 1 is system/online orders)
            model.Staff defaultStaff = em.find(model.Staff.class, 1);
            if (defaultStaff != null) {
                order.setStaffId(defaultStaff);
                System.out.println("Set default staff ID: 1 for online order");
            } else {
                System.err.println("WARNING: Default staff (ID=1) not found. Order may fail.");
            }
            
            System.out.println("Persisting order...");
            em.persist(order);
            
            // Add order items
            System.out.println("Adding " + items.size() + " order items...");
            for (OrderItems item : items) {
                item.setOrderId(order);
                em.persist(item);
            }
            
            System.out.println("Committing transaction...");
            em.getTransaction().commit();
            
            System.out.println("SUCCESS: Order created with ID: " + order.getOrderId());
            System.out.println("========================================");
            
            return order;
        } catch (Exception e) {
            System.err.println("ERROR in createOrderFromReservation:");
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
}
