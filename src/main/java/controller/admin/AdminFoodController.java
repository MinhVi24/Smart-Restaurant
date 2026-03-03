package controller.admin;

import service.FoodService;
import model.Food;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/admin/food")
public class AdminFoodController extends HttpServlet {

    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String category = request.getParameter("category");
        List<Food> foods;
        
        if (category != null && !category.equals("Tất cả")) {
            foods = foodService.findByCategory(category);
        } else {
            foods = foodService.findAll();
        }
        
        request.setAttribute("foods", foods);
        request.setAttribute("selectedCategory", category != null ? category : "Tất cả");
        request.getRequestDispatcher("/views/admin/food/admin-food-dashboard.jsp").forward(request, response);
    }
}
