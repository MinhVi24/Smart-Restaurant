package controller.admin;

import service.FoodService;
import model.Food;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/admin/food/update")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5
)
public class AdminFoodUpdateController extends HttpServlet {

    private FoodService foodService = new FoodService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Long id = Long.parseLong(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        Food food = foodService.findById(id);
        if (food != null) {
            food.setName(name);
            food.setCategory(category);
            food.setDescription(description);
            food.setPrice(price);

            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/assets/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(uploadPath + File.separator + fileName);
                food.setImage("assets/images/" + fileName);
            }

            foodService.update(food);
        }

        response.sendRedirect(request.getContextPath() + "/admin/food");
    }
}
