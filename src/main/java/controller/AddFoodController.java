package controller.auth;

import service.FoodService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/addFood")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5
)
public class AddFoodController extends HttpServlet {

    private FoodService foodService = new FoodService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        Part filePart = request.getPart("imageFile");
        String fileName = System.currentTimeMillis() + "_" 
                + filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        String imagePath = "images/" + fileName;

        foodService.create(name, price, imagePath);

        response.sendRedirect("menu");
    }
}