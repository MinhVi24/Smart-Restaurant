package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import model.Customers;
import configs.JPAConfig;
import model.Users;

public class CustomerDAO extends GenericDAO<Customers> {

    public CustomerDAO() {
        super(Customers.class);
    }

    public Customers findByPhone(String phone) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Customers> query = em.createNamedQuery("Customers.findByPhone", Customers.class);
            query.setParameter("phone", phone);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Không tìm thấy customer
        } finally {
            em.close();
        }
    }
    
    /**
     * Find customer by user_id
     * Used for linking User to Customer after login
     */
    public Customers findByUserId(Integer userId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Customers> query = em.createQuery(
                "SELECT c FROM Customers c WHERE c.userId.userId = :userId", 
                Customers.class
            );
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Customer not found
        } finally {
            em.close();
        }
    }

    public Users findByEmail(String email) {
        // Sử dụng JPAConfig giống như cách lớp cha GenericDAO đang làm
        EntityManager em = configs.JPAConfig.getEntityManager();
        try {
            // Gọi NamedQuery đã được định nghĩa trong class Users
            return em.createNamedQuery("Users.findByEmail", Users.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            // Nếu không tìm thấy user nào khớp email, trả về null
            return null;
        } catch (Exception e) {
            // Log lỗi nếu cần thiết và trả về null
            e.printStackTrace();
            return null;
        } finally {
            // Bắt buộc phải đóng EntityManager để tránh rò rỉ bộ nhớ (Memory Leak)
            // Giống như các hàm create, update, findAll trong lớp cha của bạn
            em.close();
        }

    }
}
