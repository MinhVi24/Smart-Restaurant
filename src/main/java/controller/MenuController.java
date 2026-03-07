package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MenuService;
import model.MenuItems;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MenuController", urlPatterns = {"/menu"})
public class MenuController extends HttpServlet {
    
    private MenuService menuService;
    
    @Override
    public void init() throws ServletException {
        menuService = new MenuService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Load all available menu items from database
        List<MenuItems> menuItems = menuService.getAllAvailableMenuItems();
        
        request.setAttribute("menuItems", menuItems);
        request.getRequestDispatcher("/views/custumer/menu/menu.jsp").forward(request, response);
    }
}
