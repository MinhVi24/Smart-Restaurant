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

    public void create(String name, String category, String description, double price, String imagePath) {
        Food f = new Food();
        f.setName(name);
        f.setCategory(category);
        f.setDescription(description);
        f.setPrice(price);
        f.setImage(imagePath);
        foodDAO.save(f);
    }

    public List<Food> getAll() {
        return foodDAO.findAll();
    }

    public List<Food> findAll() {
        return foodDAO.findAll();
    }

    public List<Food> findByCategory(String category) {
        return foodDAO.findByCategory(category);
    }

    public Food findById(Long id) {
        return foodDAO.findById(id);
    }

    public void update(Food food) {
        foodDAO.update(food);
    }

    public void delete(Long id) {
        foodDAO.delete(id);
    }
}