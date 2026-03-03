package listener;

import dao.ReservationDAO;
import dao.TableDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import model.Reservations;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class ScheduledTasksListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;
    private static final Logger logger = Logger.getLogger(ScheduledTasksListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(this::markNoShowAfter15Minutes, 60, 60, TimeUnit.SECONDS);
        logger.info("ScheduledTasksListener initialized: no-show checker running every 60s");
    }

    private void markNoShowAfter15Minutes() {
        try {
            ReservationDAO reservationDAO = new ReservationDAO();
            TableDAO tableDAO = new TableDAO();
            Date cutoff = new Date(System.currentTimeMillis() - 15 * 60 * 1000);
            List<Reservations> overdue = reservationDAO.findByStatusBefore("PENDING", cutoff);
            for (Reservations r : overdue) {
                boolean updated = reservationDAO.updateStatus(r.getReservationId(), "NO_SHOW");
                if (updated && r.getTableId() != null) {
                    try {
                        tableDAO.updateStatus(r.getTableId().getTableId(), "AVAILABLE");
                    } catch (Exception te) {
                        logger.log(Level.WARNING, "Failed to release table for reservation " + r.getReservationId(), te);
                    }
                }
            }
            if (!overdue.isEmpty()) {
                logger.info("Marked NO_SHOW for " + overdue.size() + " reservations overdue >15m");
            }
        } catch (Exception e) {
            logger.log(Level.WARNING, "Error in no-show scheduler", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }
}
