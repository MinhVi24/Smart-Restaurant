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
import java.util.Date;

/**
 *
 * @author TRUNG TIN
 */
@Entity
@Table(name = "Queue_Tickets")
@NamedQueries({
    @NamedQuery(name = "QueueTickets.findAll", query = "SELECT q FROM QueueTickets q"),
    @NamedQuery(name = "QueueTickets.findByQueueId", query = "SELECT q FROM QueueTickets q WHERE q.queueId = :queueId"),
    @NamedQuery(name = "QueueTickets.findByQueueDate", query = "SELECT q FROM QueueTickets q WHERE q.queueDate = :queueDate"),
    @NamedQuery(name = "QueueTickets.findByTicketNumber", query = "SELECT q FROM QueueTickets q WHERE q.ticketNumber = :ticketNumber"),
    @NamedQuery(name = "QueueTickets.findByGuestCount", query = "SELECT q FROM QueueTickets q WHERE q.guestCount = :guestCount"),
    @NamedQuery(name = "QueueTickets.findByPriority", query = "SELECT q FROM QueueTickets q WHERE q.priority = :priority"),
    @NamedQuery(name = "QueueTickets.findByStatus", query = "SELECT q FROM QueueTickets q WHERE q.status = :status"),
    @NamedQuery(name = "QueueTickets.findByCreatedTime", query = "SELECT q FROM QueueTickets q WHERE q.createdTime = :createdTime"),
    @NamedQuery(name = "QueueTickets.findByCalledTime", query = "SELECT q FROM QueueTickets q WHERE q.calledTime = :calledTime")})
public class QueueTickets implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "queue_id")
    private Integer queueId;
    @Basic(optional = false)
    @Column(name = "queue_date")
    @Temporal(TemporalType.DATE)
    private Date queueDate;
    @Basic(optional = false)
    @Column(name = "ticket_number")
    private int ticketNumber;
    @Basic(optional = false)
    @Column(name = "guest_count")
    private int guestCount;
    @Column(name = "priority")
    private String priority;
    @Column(name = "status")
    private String status;
    @Column(name = "created_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdTime;
    @Column(name = "called_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date calledTime;
    @JoinColumn(name = "customer_id", referencedColumnName = "customer_id")
    @ManyToOne
    private Customers customerId;

    public QueueTickets() {
    }

    public QueueTickets(Integer queueId) {
        this.queueId = queueId;
    }

    public QueueTickets(Integer queueId, Date queueDate, int ticketNumber, int guestCount) {
        this.queueId = queueId;
        this.queueDate = queueDate;
        this.ticketNumber = ticketNumber;
        this.guestCount = guestCount;
    }

    public Integer getQueueId() {
        return queueId;
    }

    public void setQueueId(Integer queueId) {
        this.queueId = queueId;
    }

    public Date getQueueDate() {
        return queueDate;
    }

    public void setQueueDate(Date queueDate) {
        this.queueDate = queueDate;
    }

    public int getTicketNumber() {
        return ticketNumber;
    }

    public void setTicketNumber(int ticketNumber) {
        this.ticketNumber = ticketNumber;
    }

    public int getGuestCount() {
        return guestCount;
    }

    public void setGuestCount(int guestCount) {
        this.guestCount = guestCount;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getCalledTime() {
        return calledTime;
    }

    public void setCalledTime(Date calledTime) {
        this.calledTime = calledTime;
    }

    public Customers getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customers customerId) {
        this.customerId = customerId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (queueId != null ? queueId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof QueueTickets)) {
            return false;
        }
        QueueTickets other = (QueueTickets) object;
        if ((this.queueId == null && other.queueId != null) || (this.queueId != null && !this.queueId.equals(other.queueId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.QueueTickets[ queueId=" + queueId + " ]";
    }
    
}
