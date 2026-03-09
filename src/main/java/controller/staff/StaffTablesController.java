package controller.staff;

import service.StaffTableService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "StaffTablesController", urlPatterns = { "/staff/tables" })
public class StaffTablesController extends HttpServlet {

    private StaffTableService staffTableService;

    @Override
    public void init() throws ServletException {
        staffTableService = new StaffTableService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String area = request.getParameter("area");
        String status = request.getParameter("status");

        request.setAttribute("availableTables", staffTableService.getTablesByFilter(area, status));
        request.setAttribute("areas", staffTableService.getDistinctAreas());
        request.setAttribute("selectedArea", area);
        request.setAttribute("selectedStatus", status);
        request.getRequestDispatcher("/views/staff/tables.jsp").forward(request, response);
    }
}
