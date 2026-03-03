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
            em.getTransaction().begin();
            
            Orders order = new Orders();
            order.setCustomerId(reservation.getCustomerId());
            order.setTableId(reservation.getTableId());
            order.setReservationId(reservation);
            order.setOrderTime(new Date());
            order.setTotalAmount(totalAmount);
            order.setStatus("PENDING");
            
            em.persist(order);
            
            // Add order items
            for (OrderItems item : items) {
                item.setOrderId(order);
                em.persist(item);
            }
            
            em.getTransaction().commit();
            return order;
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
}
