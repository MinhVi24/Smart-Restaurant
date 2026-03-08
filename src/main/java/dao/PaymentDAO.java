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
            
            // Set payment status - ALWAYS PENDING until actual payment is confirmed
            // Even if deposit is 100%, user still needs to transfer money
            payment.setPaymentStatus("PENDING");
            
            System.out.println("=== PaymentDAO.createPayment ===");
            System.out.println("Order ID: " + order.getOrderId());
            System.out.println("Total Amount: " + totalAmount);
            System.out.println("Deposit %: " + depositPercentage);
            System.out.println("Deposit Amount: " + depositAmount);
            System.out.println("Payment Status: PENDING (waiting for transfer)");
            System.out.println("================================");
            
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
     * Complete payment - updates from PENDING or PARTIAL to COMPLETED
     */
    public boolean completePayment(Integer paymentId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            
            Payments payment = em.find(Payments.class, paymentId);
            
            System.out.println("=== PaymentDAO.completePayment ===");
            System.out.println("Payment ID: " + paymentId);
            System.out.println("Payment found: " + (payment != null));
            
            if (payment != null) {
                String currentStatus = payment.getPaymentStatus();
                System.out.println("Current status: " + currentStatus);
                
                // Accept both PENDING and PARTIAL status for completion
                if ("PENDING".equals(currentStatus) || "PARTIAL".equals(currentStatus)) {
                    payment.setPaymentStatus("COMPLETED");
                    payment.setRemainingAmount(BigDecimal.ZERO);
                    em.merge(payment);
                    em.getTransaction().commit();
                    
                    System.out.println("✓ Payment updated to COMPLETED");
                    System.out.println("==================================");
                    return true;
                } else {
                    System.out.println("✗ Cannot complete - status is: " + currentStatus);
                    System.out.println("==================================");
                }
            } else {
                System.out.println("✗ Payment not found!");
                System.out.println("==================================");
            }
            
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("ERROR in completePayment:");
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
