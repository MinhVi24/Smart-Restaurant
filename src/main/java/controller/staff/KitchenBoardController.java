package controller.staff;

import service.KitchenBoardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Orders;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "KitchenBoardController", urlPatterns = { "/staff/kitchen-board" })
public class KitchenBoardController extends HttpServlet {

    private KitchenBoardService kitchenBoardService;

    @Override
    public void init() throws ServletException {
        kitchenBoardService = new KitchenBoardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Orders> openOrders = kitchenBoardService.getOpenOrdersWithItems();
        request.setAttribute("openOrders", openOrders);
        request.getRequestDispatcher("/views/staff/kitchen-board.jsp").forward(request, response);
    }
}
