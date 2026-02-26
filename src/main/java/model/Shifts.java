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
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Shifts")
@NamedQueries({
    @NamedQuery(name = "Shifts.findAll", query = "SELECT s FROM Shifts s"),
    @NamedQuery(name = "Shifts.findByShiftId", query = "SELECT s FROM Shifts s WHERE s.shiftId = :shiftId"),
    @NamedQuery(name = "Shifts.findByShiftName", query = "SELECT s FROM Shifts s WHERE s.shiftName = :shiftName"),
    @NamedQuery(name = "Shifts.findByStartTime", query = "SELECT s FROM Shifts s WHERE s.startTime = :startTime"),
    @NamedQuery(name = "Shifts.findByEndTime", query = "SELECT s FROM Shifts s WHERE s.endTime = :endTime")})
public class Shifts implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "shift_id")
    private Integer shiftId;
    @Basic(optional = false)
    @Column(name = "shift_name")
    private String shiftName;
    @Basic(optional = false)
    @Column(name = "start_time")
    @Temporal(TemporalType.TIME)
    private Date startTime;
    @Basic(optional = false)
    @Column(name = "end_time")
    @Temporal(TemporalType.TIME)
    private Date endTime;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "shifts")
    private Collection<StaffShifts> staffShiftsCollection;

    public Shifts() {
    }

    public Shifts(Integer shiftId) {
        this.shiftId = shiftId;
    }

    public Shifts(Integer shiftId, String shiftName, Date startTime, Date endTime) {
        this.shiftId = shiftId;
        this.shiftName = shiftName;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Integer getShiftId() {
        return shiftId;
    }

    public void setShiftId(Integer shiftId) {
        this.shiftId = shiftId;
    }

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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
        hash += (shiftId != null ? shiftId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Shifts)) {
            return false;
        }
        Shifts other = (Shifts) object;
        if ((this.shiftId == null && other.shiftId != null) || (this.shiftId != null && !this.shiftId.equals(other.shiftId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Shifts[ shiftId=" + shiftId + " ]";
    }
    
}
