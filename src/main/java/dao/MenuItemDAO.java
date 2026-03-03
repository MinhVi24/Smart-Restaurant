package dao;

import jakarta.persistence.*;
import model.MenuItems;
import java.util.List;
import configs.JPAConfig;

public class MenuItemDAO {

    public void save(MenuItems menuItem) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        em.persist(menuItem);
        tx.commit();
        em.close();
    }

    public List<MenuItems> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        List<MenuItems> list = em.createQuery("SELECT m FROM MenuItems m", MenuItems.class)
                            .getResultList();
        em.close();
        return list;
    }

    public MenuItems findById(Integer id) {
        EntityManager em = JPAConfig.getEntityManager();
        MenuItems m = em.find(MenuItems.class, id);
        em.close();
        return m;
    }

    public void update(MenuItems menuItem) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        em.merge(menuItem);
        tx.commit();
        em.close();
    }

    public void delete(Integer id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        MenuItems m = em.find(MenuItems.class, id);
        if (m != null) em.remove(m);
        tx.commit();
        em.close();
    }

    public List<MenuItems> findAvailable() {
        EntityManager em = JPAConfig.getEntityManager();
        List<MenuItems> list = em.createQuery(
            "SELECT m FROM MenuItems m WHERE m.status = :status", 
            MenuItems.class
        )
        .setParameter("status", "AVAILABLE")
        .getResultList();
        em.close();
        return list;
    }
    
    /**
     * Get top selling items with order count
     */
    public List<java.util.Map<String, Object>> getTopSellingItems(int limit) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            List<Object[]> results = em.createQuery(
                "SELECT m.itemName, m.itemId, COUNT(oi.orderItemId) as orderCount " +
                "FROM MenuItems m JOIN m.orderItemsCollection oi " +
                "GROUP BY m.itemId, m.itemName " +
                "ORDER BY orderCount DESC",
                Object[].class
            )
            .setMaxResults(limit)
            .getResultList();
            
            List<java.util.Map<String, Object>> topItems = new java.util.ArrayList<>();
            for (Object[] row : results) {
                java.util.Map<String, Object> item = new java.util.HashMap<>();
                item.put("itemName", row[0]);
                item.put("itemId", row[1]);
                item.put("orderCount", row[2]);
                topItems.add(item);
            }
            return topItems;
        } finally {
            em.close();
        }
    }
    
    /**
     * Get low stock items (mock - can be enhanced with inventory)
     */
    public List<MenuItems> getLowStockItems(int limit) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery(
                "SELECT m FROM MenuItems m WHERE m.status = 'AVAILABLE' ORDER BY m.itemId DESC",
                MenuItems.class
            )
            .setMaxResults(limit)
            .getResultList();
        } finally {
            em.close();
        }
    }
}

