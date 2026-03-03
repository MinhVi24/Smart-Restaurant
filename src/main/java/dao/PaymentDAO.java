package dao;

import configs.JPAConfig;
import jakarta.persistence.EntityManager;
import model.Payments;
import model.Orders;
import java.math.BigDecimal;
import java.util.Date;

public class PaymentDAO extends GenericDAO<Payments> {

    public PaymentDAO() {
        super(Payments.class);
    }

    /**
     * Create payment with deposit
     */
    public Payments createPayment(Orders order, BigDecimal totalAmount, Integer depositPercentage, String paymentMethod) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            
            // Calculate deposit and remaining amounts
            BigDecimal depositAmount = totalAmount.multiply(new BigDecimal(depositPercentage))
                                                  .divide(new BigDecimal(100));
            BigDecimal remainingAmount = totalAmount.subtract(depositAmount);
            
            Payments payment = new Payments();
            payment.setOrderId(order);
            payment.setAmount(totalAmount);
            payment.setDepositPercentage(depositPercentage);
            payment.setDepositAmount(depositAmount);
            payment.setRemainingAmount(remainingAmount);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentTime(new Date());
            
            // Set payment status
            if (depositPercentage == 100) {
                payment.setPaymentStatus("COMPLETED");
            } else {
                payment.setPaymentStatus("PARTIAL");
            }
            
            em.persist(payment);
            em.getTransaction().commit();
            
            return payment;
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
     * Complete remaining payment
     */
    public boolean completePayment(Integer paymentId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Payments payment = em.find(Payments.class, paymentId);
            if (payment != null && "PARTIAL".equals(payment.getPaymentStatus())) {
                payment.setPaymentStatus("COMPLETED");
                payment.setRemainingAmount(BigDecimal.ZERO);
                em.merge(payment);
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

    /**
     * Find payment by order
     */
    public Payments findByOrder(Integer orderId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery(
                "SELECT p FROM Payments p WHERE p.orderId.orderId = :orderId",
                Payments.class
            )
            .setParameter("orderId", orderId)
            .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
}
