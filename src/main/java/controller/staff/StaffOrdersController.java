package controller.staff;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Orders;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffOrdersController", urlPatterns = {"/staff/orders"})
public class StaffOrdersController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        if (status == null || status.isBlank()) status = "PREPARING";
        List<Orders> list = orderDAO.findByStatus(status);
        request.setAttribute("status", status);
        request.setAttribute("orders", list);
        request.getRequestDispatcher("/views/staff/orders.jsp").forward(request, response);
    }
}
