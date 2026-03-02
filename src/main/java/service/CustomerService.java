package service;

import dao.CustomerDAO;
import model.Customers;
import model.Users;

import java.util.Date;
import java.util.List;

public class CustomerService {

    private final CustomerDAO customerDAO = new CustomerDAO();

    /**
     * Tạo mới Customer gắn với User vừa đăng ký.
     */
    public Customers createCustomer(String fullName, String phone, Users user) {
        Customers customer = new Customers();
        customer.setFullName(fullName);
        customer.setPhone(phone);
        customer.setMembershipLevel("BRONZE");
        customer.setTotalPoints(0);
        customer.setCreatedAt(new Date());
        customer.setUserId(user);

        customerDAO.create(customer);
        return customer;
    }

    public Customers findByPhone(String phone) {
        return customerDAO.findByPhone(phone);
    }

    public List<Customers> getAll() {
        return customerDAO.findAll();
    }

    public void update(Customers customer) {
        customerDAO.update(customer);
    }

    public void delete(Long id) {
        customerDAO.delete(id);
    }
}
