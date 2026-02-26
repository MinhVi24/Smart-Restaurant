/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Inventory")
@NamedQueries({
    @NamedQuery(name = "Inventory.findAll", query = "SELECT i FROM Inventory i"),
    @NamedQuery(name = "Inventory.findByInventoryId", query = "SELECT i FROM Inventory i WHERE i.inventoryId = :inventoryId"),
    @NamedQuery(name = "Inventory.findByQuantity", query = "SELECT i FROM Inventory i WHERE i.quantity = :quantity"),
    @NamedQuery(name = "Inventory.findByExpiryDate", query = "SELECT i FROM Inventory i WHERE i.expiryDate = :expiryDate"),
    @NamedQuery(name = "Inventory.findByStatus", query = "SELECT i FROM Inventory i WHERE i.status = :status"),
    @NamedQuery(name = "Inventory.findByLastUpdated", query = "SELECT i FROM Inventory i WHERE i.lastUpdated = :lastUpdated")})
public class Inventory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "inventory_id")
    private Integer inventoryId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @Column(name = "quantity")
    private BigDecimal quantity;
    @Column(name = "expiry_date")
    @Temporal(TemporalType.DATE)
    private Date expiryDate;
    @Column(name = "status")
    private String status;
    @Column(name = "last_updated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastUpdated;
    @JoinColumn(name = "ingredient_id", referencedColumnName = "ingredient_id")
    @ManyToOne(optional = false)
    private Ingredients ingredientId;
    @JoinColumn(name = "supplier_id", referencedColumnName = "supplier_id")
    @ManyToOne
    private Suppliers supplierId;

    public Inventory() {
    }

    public Inventory(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }

    public Inventory(Integer inventoryId, BigDecimal quantity) {
        this.inventoryId = inventoryId;
        this.quantity = quantity;
    }

    public Integer getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public Ingredients getIngredientId() {
        return ingredientId;
    }

    public void setIngredientId(Ingredients ingredientId) {
        this.ingredientId = ingredientId;
    }

    public Suppliers getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Suppliers supplierId) {
        this.supplierId = supplierId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (inventoryId != null ? inventoryId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Inventory)) {
            return false;
        }
        Inventory other = (Inventory) object;
        if ((this.inventoryId == null && other.inventoryId != null) || (this.inventoryId != null && !this.inventoryId.equals(other.inventoryId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Inventory[ inventoryId=" + inventoryId + " ]";
    }
    
}
