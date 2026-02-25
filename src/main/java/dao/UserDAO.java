
package dao;

import configs.JPAConfig;
import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import models.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO extends GenericDAO<User> {

    public UserDAO() {
        super(User.class);
    }

    /**
     * Tìm user theo email.
     */
    public User findByEmail(String email) {
        if (email == null || email.isBlank()) {
            return null;
        }
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email.trim())
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Đăng nhập bằng email và password. So khớp password bằng BCrypt.
     * @return User nếu đúng email và password, null nếu sai.
     */
    public User login(String email, String password) {
        if (email == null || password == null) {
            return null;
        }
        User user = findByEmail(email);
        if (user == null) {
            return null;
        }
        String hashedPassword = user.getPassword();
        if (hashedPassword == null || !BCrypt.checkpw(password, hashedPassword)) {
            return null;
        }
        return user;
    }
}
