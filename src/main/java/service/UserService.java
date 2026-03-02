package service;

import dao.UserDAO;
import model.Users;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Date;
import java.util.List;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /**
     * Đăng ký tài khoản mới.
     * @param username tên đăng nhập (Users.username)
     * @param email email (Users.email) - có thể null
     * @param rawPassword mật khẩu thô → hash bằng BCrypt
     * @param role vai trò (CUSTOMER, ADMIN, STAFF)
     * @return Users đã được lưu vào DB (có ID)
     * @throws IllegalArgumentException nếu username đã tồn tại
     */
    public Users register(String username, String email, String rawPassword, String role) {
        // Kiểm tra trùng username
        if (userDAO.findByUsername(username) != null) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.");
        }

        // Kiểm tra trùng email (nếu có nhập)
        if (email != null && !email.trim().isEmpty() && userDAO.findByEmail(email) != null) {
            throw new IllegalArgumentException("Email này đã được đăng ký.");
        }

        Users newUser = new Users();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPasswordHash(BCrypt.hashpw(rawPassword, BCrypt.gensalt()));
        newUser.setRole(role);
        newUser.setStatus("ACTIVE");
        newUser.setCreatedAt(new Date());

        userDAO.create(newUser);

        // Trả về user đã lưu (có ID)
        return userDAO.findByUsername(username);
    }

    /**
     * Đăng nhập: kiểm tra tài khoản + mật khẩu.
     * @return Users nếu hợp lệ
     * @throws IllegalArgumentException nếu sai thông tin hoặc tài khoản bị khóa
     */
    public Users login(String username, String rawPassword) {
        Users user = userDAO.findByUsername(username);

        if (user == null) {
            throw new IllegalArgumentException("Tài khoản không tồn tại.");
        }

        if ("INACTIVE".equalsIgnoreCase(user.getStatus()) || "BLOCKED".equalsIgnoreCase(user.getStatus())) {
            throw new IllegalArgumentException("Tài khoản đã bị khóa.");
        }

        if (!BCrypt.checkpw(rawPassword, user.getPasswordHash())) {
            throw new IllegalArgumentException("Mật khẩu không chính xác.");
        }

        return user;
    }

    public Users findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    public Users findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    public List<Users> getAll() {
        return userDAO.findAll();
    }
}
