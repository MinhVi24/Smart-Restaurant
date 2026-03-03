package dao;

import jakarta.persistence.*;
import model.Food;
import java.util.List;
import configs.JPAConfig;

public class FoodDAO {

    public void save(Food food) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        em.persist(food);
        tx.commit();
        em.close();
    }

    public List<Food> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        List<Food> list = em.createQuery("SELECT f FROM Food f", Food.class)
                            .getResultList();
        em.close();
        return list;
    }

    public Food findById(Long id) {
        EntityManager em = JPAConfig.getEntityManager();
        Food f = em.find(Food.class, id);
        em.close();
        return f;
    }

    public void update(Food food) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        em.merge(food);
        tx.commit();
        em.close();
    }

    public void delete(Long id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        tx.begin();
        Food f = em.find(Food.class, id);
        if (f != null) em.remove(f);
        tx.commit();
        em.close();
    }

    public List<Food> findByCategory(String category) {
        EntityManager em = JPAConfig.getEntityManager();
        List<Food> list = em.createQuery("SELECT f FROM Food f WHERE f.category = :category", Food.class)
                            .setParameter("category", category)
                            .getResultList();
        em.close();
        return list;
    }
}