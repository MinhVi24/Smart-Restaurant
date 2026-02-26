package service;

import dao.FoodDAO;
import model.Food;
import java.util.List;

public class FoodService {

    private FoodDAO foodDAO = new FoodDAO();

    public void create(String name, double price, String imagePath) {
        Food f = new Food();
        f.setName(name);
        f.setPrice(price);
        f.setImage(imagePath);
        foodDAO.save(f);
    }

    public List<Food> getAll() {
        return foodDAO.findAll();
    }

    public void delete(Long id) {
        foodDAO.delete(id);
    }
}