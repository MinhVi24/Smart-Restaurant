package controller.staff;

import service.StaffActionLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffActionLogController", urlPatterns = { "/staff/action-log" })
public class StaffActionLogController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<StaffActionLog> logs = StaffActionLog.getAll();
        request.setAttribute("actionLogs", logs);
        request.getRequestDispatcher("/views/staff/action-log.jsp").forward(request, response);
    }
}
