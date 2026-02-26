/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;

/**
 *
 * @author TRUNG TIN
 */
@Embeddable
public class MenuIngredientsPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "menu_item_id")
    private int menuItemId;
    @Basic(optional = false)
    @Column(name = "ingredient_id")
    private int ingredientId;

    public MenuIngredientsPK() {
    }

    public MenuIngredientsPK(int menuItemId, int ingredientId) {
        this.menuItemId = menuItemId;
        this.ingredientId = ingredientId;
    }

    public int getMenuItemId() {
        return menuItemId;
    }

    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }

    public int getIngredientId() {
        return ingredientId;
    }

    public void setIngredientId(int ingredientId) {
        this.ingredientId = ingredientId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) menuItemId;
        hash += (int) ingredientId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MenuIngredientsPK)) {
            return false;
        }
        MenuIngredientsPK other = (MenuIngredientsPK) object;
        if (this.menuItemId != other.menuItemId) {
            return false;
        }
        if (this.ingredientId != other.ingredientId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.MenuIngredientsPK[ menuItemId=" + menuItemId + ", ingredientId=" + ingredientId + " ]";
    }
    
}
