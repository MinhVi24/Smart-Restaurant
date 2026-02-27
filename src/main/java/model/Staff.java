/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Staff")
@NamedQueries({
    @NamedQuery(name = "Staff.findAll", query = "SELECT s FROM Staff s"),
    @NamedQuery(name = "Staff.findByStaffId", query = "SELECT s FROM Staff s WHERE s.staffId = :staffId"),
    @NamedQuery(name = "Staff.findByFullName", query = "SELECT s FROM Staff s WHERE s.fullName = :fullName"),
    @NamedQuery(name = "Staff.findByPosition", query = "SELECT s FROM Staff s WHERE s.position = :position"),
    @NamedQuery(name = "Staff.findByStatus", query = "SELECT s FROM Staff s WHERE s.status = :status")})
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "staff_id")
    private Integer staffId;
    @Basic(optional = false)
    @Column(name = "full_name")
    private String fullName;
    @Column(name = "position")
    private String position;
    @Column(name = "status")
    private String status;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "staffId")
    private Collection<Orders> ordersCollection;
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    @OneToOne(optional = false)
    private Users userId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "staff")
    private Collection<StaffShifts> staffShiftsCollection;

    public Staff() {
    }

    public Staff(Integer staffId) {
        this.staffId = staffId;
    }

    public Staff(Integer staffId, String fullName) {
        this.staffId = staffId;
        this.fullName = fullName;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
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

    public Users getUserId() {
        return userId;
    }

    public void setUserId(Users userId) {
        this.userId = userId;
    }

    public Collection<StaffShifts> getStaffShiftsCollection() {
        return staffShiftsCollection;
    }

    public void setStaffShiftsCollection(Collection<StaffShifts> staffShiftsCollection) {
        this.staffShiftsCollection = staffShiftsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffId != null ? staffId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.staffId == null && other.staffId != null) || (this.staffId != null && !this.staffId.equals(other.staffId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Staff[ staffId=" + staffId + " ]";
    }
    
}
