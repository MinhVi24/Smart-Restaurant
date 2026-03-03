package dao;

import configs.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Tables;
import java.util.List;

public class TableDAO extends GenericDAO<Tables> {

    public TableDAO() {
        super(Tables.class);
    }

    /**
     * Find all tables by area
     */
    public List<Tables> findByArea(String area) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Tables> query = em.createNamedQuery("Tables.findByArea", Tables.class);
            query.setParameter("area", area);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find all tables by status
     */
    public List<Tables> findByStatus(String status) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Tables> query = em.createNamedQuery("Tables.findByStatus", Tables.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Find available tables by capacity
     */
    public List<Tables> findAvailableByCapacity(int minCapacity) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Tables> query = em.createQuery(
                "SELECT t FROM Tables t WHERE t.status = 'AVAILABLE' AND t.capacity >= :minCapacity",
                Tables.class
            );
            query.setParameter("minCapacity", minCapacity);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Update table status
     */
    public boolean updateStatus(Integer tableId, String status) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            em.getTransaction().begin();
            Tables table = em.find(Tables.class, tableId);
            if (table != null) {
                table.setStatus(status);
                em.merge(table);
                em.getTransaction().commit();
                return true;
            }
            em.getTransaction().rollback();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
