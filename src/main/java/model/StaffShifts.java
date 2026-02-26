/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Staff_Shifts")
@NamedQueries({
    @NamedQuery(name = "StaffShifts.findAll", query = "SELECT s FROM StaffShifts s"),
    @NamedQuery(name = "StaffShifts.findByStaffId", query = "SELECT s FROM StaffShifts s WHERE s.staffShiftsPK.staffId = :staffId"),
    @NamedQuery(name = "StaffShifts.findByShiftId", query = "SELECT s FROM StaffShifts s WHERE s.staffShiftsPK.shiftId = :shiftId"),
    @NamedQuery(name = "StaffShifts.findByShiftDate", query = "SELECT s FROM StaffShifts s WHERE s.staffShiftsPK.shiftDate = :shiftDate")})
public class StaffShifts implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected StaffShiftsPK staffShiftsPK;
    @JoinColumn(name = "shift_id", referencedColumnName = "shift_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Shifts shifts;
    @JoinColumn(name = "staff_id", referencedColumnName = "staff_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Staff staff;

    public StaffShifts() {
    }

    public StaffShifts(StaffShiftsPK staffShiftsPK) {
        this.staffShiftsPK = staffShiftsPK;
    }

    public StaffShifts(int staffId, int shiftId, Date shiftDate) {
        this.staffShiftsPK = new StaffShiftsPK(staffId, shiftId, shiftDate);
    }

    public StaffShiftsPK getStaffShiftsPK() {
        return staffShiftsPK;
    }

    public void setStaffShiftsPK(StaffShiftsPK staffShiftsPK) {
        this.staffShiftsPK = staffShiftsPK;
    }

    public Shifts getShifts() {
        return shifts;
    }

    public void setShifts(Shifts shifts) {
        this.shifts = shifts;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffShiftsPK != null ? staffShiftsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof StaffShifts)) {
            return false;
        }
        StaffShifts other = (StaffShifts) object;
        if ((this.staffShiftsPK == null && other.staffShiftsPK != null) || (this.staffShiftsPK != null && !this.staffShiftsPK.equals(other.staffShiftsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.StaffShifts[ staffShiftsPK=" + staffShiftsPK + " ]";
    }
    
}
