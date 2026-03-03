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
}

