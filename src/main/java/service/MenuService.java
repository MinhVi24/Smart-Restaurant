package service;

import configs.JPAConfig;
import dao.FoodDAO;
import model.MenuItems;
import model.Food;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class MenuService {
    
    private final FoodDAO foodDAO;
    
    public MenuService() {
        this.foodDAO = new FoodDAO();
    }
    
    /**
     * Get all menu items
     */
    public List<MenuItems> getAllMenuItems() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT m FROM MenuItems m", MenuItems.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all available menu items (for customer)
     */
    public List<MenuItems> getAllAvailableMenuItems() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            // Get all menu items without status filter for now
            TypedQuery<MenuItems> query = em.createQuery(
                "SELECT m FROM MenuItems m ORDER BY m.menuItemId",
                MenuItems.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get available menu items
     */
    public List<MenuItems> getAvailableMenuItems() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<MenuItems> query = em.createQuery(
                "SELECT m FROM MenuItems m WHERE m.status = 'AVAILABLE' ORDER BY m.menuItemId",
                MenuItems.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    /**
     * Get menu item by ID
     */
    public MenuItems getMenuItem(Integer menuItemId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(MenuItems.class, menuItemId);
        } finally {
            em.close();
        }
    }
    
    /**
     * Get all food items
     */
    public List<Food> getAllFoodItems() {
        return foodDAO.findAll();
    }
    
    /**
     * Get food item by ID
     */
    public Food getFoodItem(Long foodId) {
        return foodDAO.findById(foodId);
    }
    
    /**
     * Search menu items by name
     */
    public List<MenuItems> searchMenuItems(String keyword) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<MenuItems> query = em.createQuery(
                "SELECT m FROM MenuItems m WHERE LOWER(m.name) LIKE LOWER(:keyword) AND m.status = 'AVAILABLE'",
                MenuItems.class
            );
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
