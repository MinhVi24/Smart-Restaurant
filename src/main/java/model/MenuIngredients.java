/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Menu_Ingredients")
@NamedQueries({
    @NamedQuery(name = "MenuIngredients.findAll", query = "SELECT m FROM MenuIngredients m"),
    @NamedQuery(name = "MenuIngredients.findByMenuItemId", query = "SELECT m FROM MenuIngredients m WHERE m.menuIngredientsPK.menuItemId = :menuItemId"),
    @NamedQuery(name = "MenuIngredients.findByIngredientId", query = "SELECT m FROM MenuIngredients m WHERE m.menuIngredientsPK.ingredientId = :ingredientId"),
    @NamedQuery(name = "MenuIngredients.findByQuantityRequired", query = "SELECT m FROM MenuIngredients m WHERE m.quantityRequired = :quantityRequired")})
public class MenuIngredients implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected MenuIngredientsPK menuIngredientsPK;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @Column(name = "quantity_required")
    private BigDecimal quantityRequired;
    @JoinColumn(name = "ingredient_id", referencedColumnName = "ingredient_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Ingredients ingredients;
    @JoinColumn(name = "menu_item_id", referencedColumnName = "menu_item_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private MenuItems menuItems;

    public MenuIngredients() {
    }

    public MenuIngredients(MenuIngredientsPK menuIngredientsPK) {
        this.menuIngredientsPK = menuIngredientsPK;
    }

    public MenuIngredients(MenuIngredientsPK menuIngredientsPK, BigDecimal quantityRequired) {
        this.menuIngredientsPK = menuIngredientsPK;
        this.quantityRequired = quantityRequired;
    }

    public MenuIngredients(int menuItemId, int ingredientId) {
        this.menuIngredientsPK = new MenuIngredientsPK(menuItemId, ingredientId);
    }

    public MenuIngredientsPK getMenuIngredientsPK() {
        return menuIngredientsPK;
    }

    public void setMenuIngredientsPK(MenuIngredientsPK menuIngredientsPK) {
        this.menuIngredientsPK = menuIngredientsPK;
    }

    public BigDecimal getQuantityRequired() {
        return quantityRequired;
    }

    public void setQuantityRequired(BigDecimal quantityRequired) {
        this.quantityRequired = quantityRequired;
    }

    public Ingredients getIngredients() {
        return ingredients;
    }

    public void setIngredients(Ingredients ingredients) {
        this.ingredients = ingredients;
    }

    public MenuItems getMenuItems() {
        return menuItems;
    }

    public void setMenuItems(MenuItems menuItems) {
        this.menuItems = menuItems;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (menuIngredientsPK != null ? menuIngredientsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MenuIngredients)) {
            return false;
        }
        MenuIngredients other = (MenuIngredients) object;
        if ((this.menuIngredientsPK == null && other.menuIngredientsPK != null) || (this.menuIngredientsPK != null && !this.menuIngredientsPK.equals(other.menuIngredientsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.MenuIngredients[ menuIngredientsPK=" + menuIngredientsPK + " ]";
    }
    
}
