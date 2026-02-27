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
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Tables")
@NamedQueries({
    @NamedQuery(name = "Tables.findAll", query = "SELECT t FROM Tables t"),
    @NamedQuery(name = "Tables.findByTableId", query = "SELECT t FROM Tables t WHERE t.tableId = :tableId"),
    @NamedQuery(name = "Tables.findByArea", query = "SELECT t FROM Tables t WHERE t.area = :area"),
    @NamedQuery(name = "Tables.findByCapacity", query = "SELECT t FROM Tables t WHERE t.capacity = :capacity"),
    @NamedQuery(name = "Tables.findByStatus", query = "SELECT t FROM Tables t WHERE t.status = :status")})
public class Tables implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "table_id")
    private Integer tableId;
    @Column(name = "area")
    private String area;
    @Basic(optional = false)
    @Column(name = "capacity")
    private int capacity;
    @Column(name = "status")
    private String status;
    @OneToMany(mappedBy = "tableId")
    private Collection<Orders> ordersCollection;

    public Tables() {
    }

    public Tables(Integer tableId) {
        this.tableId = tableId;
    }

    public Tables(Integer tableId, int capacity) {
        this.tableId = tableId;
        this.capacity = capacity;
    }

    public Integer getTableId() {
        return tableId;
    }

    public void setTableId(Integer tableId) {
        this.tableId = tableId;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Collection<Orders> getOrdersCollection() {
        return ordersCollection;
    }

    public void setOrdersCollection(Collection<Orders> ordersCollection) {
        this.ordersCollection = ordersCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tableId != null ? tableId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tables)) {
            return false;
        }
        Tables other = (Tables) object;
        if ((this.tableId == null && other.tableId != null) || (this.tableId != null && !this.tableId.equals(other.tableId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Tables[ tableId=" + tableId + " ]";
    }
    
}
