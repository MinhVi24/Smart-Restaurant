/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
@Table(name = "Daily_Stats")
@NamedQueries({
    @NamedQuery(name = "DailyStats.findAll", query = "SELECT d FROM DailyStats d"),
    @NamedQuery(name = "DailyStats.findByStatDate", query = "SELECT d FROM DailyStats d WHERE d.statDate = :statDate"),
    @NamedQuery(name = "DailyStats.findByGuestCount", query = "SELECT d FROM DailyStats d WHERE d.guestCount = :guestCount"),
    @NamedQuery(name = "DailyStats.findByTotalRevenue", query = "SELECT d FROM DailyStats d WHERE d.totalRevenue = :totalRevenue"),
    @NamedQuery(name = "DailyStats.findByPeakFlag", query = "SELECT d FROM DailyStats d WHERE d.peakFlag = :peakFlag")})
public class DailyStats implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "stat_date")
    @Temporal(TemporalType.DATE)
    private Date statDate;
    @Column(name = "guest_count")
    private Integer guestCount;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "total_revenue")
    private BigDecimal totalRevenue;
    @Column(name = "peak_flag")
    private Boolean peakFlag;

    public DailyStats() {
    }

    public DailyStats(Date statDate) {
        this.statDate = statDate;
    }

    public Date getStatDate() {
        return statDate;
    }

    public void setStatDate(Date statDate) {
        this.statDate = statDate;
    }

    public Integer getGuestCount() {
        return guestCount;
    }

    public void setGuestCount(Integer guestCount) {
        this.guestCount = guestCount;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Boolean getPeakFlag() {
        return peakFlag;
    }

    public void setPeakFlag(Boolean peakFlag) {
        this.peakFlag = peakFlag;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (statDate != null ? statDate.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DailyStats)) {
            return false;
        }
        DailyStats other = (DailyStats) object;
        if ((this.statDate == null && other.statDate != null) || (this.statDate != null && !this.statDate.equals(other.statDate))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.DailyStats[ statDate=" + statDate + " ]";
    }
    
}
