/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author TRUNG TIN
 */
@Embeddable
public class StaffShiftsPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "staff_id")
    private int staffId;
    @Basic(optional = false)
    @Column(name = "shift_id")
    private int shiftId;
    @Basic(optional = false)
    @Column(name = "shift_date")
    @Temporal(TemporalType.DATE)
    private Date shiftDate;

    public StaffShiftsPK() {
    }

    public StaffShiftsPK(int staffId, int shiftId, Date shiftDate) {
        this.staffId = staffId;
        this.shiftId = shiftId;
        this.shiftDate = shiftDate;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getShiftId() {
        return shiftId;
    }

    public void setShiftId(int shiftId) {
        this.shiftId = shiftId;
    }

    public Date getShiftDate() {
        return shiftDate;
    }

    public void setShiftDate(Date shiftDate) {
        this.shiftDate = shiftDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) staffId;
        hash += (int) shiftId;
        hash += (shiftDate != null ? shiftDate.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof StaffShiftsPK)) {
            return false;
        }
        StaffShiftsPK other = (StaffShiftsPK) object;
        if (this.staffId != other.staffId) {
            return false;
        }
        if (this.shiftId != other.shiftId) {
            return false;
        }
        if ((this.shiftDate == null && other.shiftDate != null) || (this.shiftDate != null && !this.shiftDate.equals(other.shiftDate))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.StaffShiftsPK[ staffId=" + staffId + ", shiftId=" + shiftId + ", shiftDate=" + shiftDate + " ]";
    }
    
}
