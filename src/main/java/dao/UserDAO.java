package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import model.Users;
import configs.JPAConfig;

public class UserDAO extends GenericDAO<Users> {

    public UserDAO() {
        super(Users.class);
    }

    public Users findByUsername(String username) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Users> query = em.createNamedQuery("Users.findByUsername", Users.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Không tìm thấy user
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

    public Users login(String email, String password) {
        Users user = findByEmail(email);
        if (user != null) {
            // Kiểm tra password (giả sử password đã được hash bằng BCrypt)
            if (org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }
}
