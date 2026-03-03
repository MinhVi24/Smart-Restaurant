package controller.admin;

import service.FoodService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/admin/food/delete")
public class AdminFoodDeleteController extends HttpServlet {

    private FoodService foodService = new FoodService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long id = Long.parseLong(request.getParameter("id"));
        foodService.delete(id);

        response.sendRedirect(request.getContextPath() + "/admin/food");
    }
}
