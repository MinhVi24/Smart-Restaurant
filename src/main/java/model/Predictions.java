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
@Table(name = "Predictions")
@NamedQueries({
    @NamedQuery(name = "Predictions.findAll", query = "SELECT p FROM Predictions p"),
    @NamedQuery(name = "Predictions.findByPredictionId", query = "SELECT p FROM Predictions p WHERE p.predictionId = :predictionId"),
    @NamedQuery(name = "Predictions.findByPredictionDate", query = "SELECT p FROM Predictions p WHERE p.predictionDate = :predictionDate"),
    @NamedQuery(name = "Predictions.findByPredictedGuestCount", query = "SELECT p FROM Predictions p WHERE p.predictedGuestCount = :predictedGuestCount"),
    @NamedQuery(name = "Predictions.findByPredictedRevenue", query = "SELECT p FROM Predictions p WHERE p.predictedRevenue = :predictedRevenue"),
    @NamedQuery(name = "Predictions.findByMethod", query = "SELECT p FROM Predictions p WHERE p.method = :method"),
    @NamedQuery(name = "Predictions.findByCreatedAt", query = "SELECT p FROM Predictions p WHERE p.createdAt = :createdAt")})
public class Predictions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "prediction_id")
    private Integer predictionId;
    @Basic(optional = false)
    @Column(name = "prediction_date")
    @Temporal(TemporalType.DATE)
    private Date predictionDate;
    @Column(name = "predicted_guest_count")
    private Integer predictedGuestCount;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "predicted_revenue")
    private BigDecimal predictedRevenue;
    @Column(name = "method")
    private String method;
    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Predictions() {
    }

    public Predictions(Integer predictionId) {
        this.predictionId = predictionId;
    }

    public Predictions(Integer predictionId, Date predictionDate) {
        this.predictionId = predictionId;
        this.predictionDate = predictionDate;
    }

    public Integer getPredictionId() {
        return predictionId;
    }

    public void setPredictionId(Integer predictionId) {
        this.predictionId = predictionId;
    }

    public Date getPredictionDate() {
        return predictionDate;
    }

    public void setPredictionDate(Date predictionDate) {
        this.predictionDate = predictionDate;
    }

    public Integer getPredictedGuestCount() {
        return predictedGuestCount;
    }

    public void setPredictedGuestCount(Integer predictedGuestCount) {
        this.predictedGuestCount = predictedGuestCount;
    }

    public BigDecimal getPredictedRevenue() {
        return predictedRevenue;
    }

    public void setPredictedRevenue(BigDecimal predictedRevenue) {
        this.predictedRevenue = predictedRevenue;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (predictionId != null ? predictionId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Predictions)) {
            return false;
        }
        Predictions other = (Predictions) object;
        if ((this.predictionId == null && other.predictionId != null) || (this.predictionId != null && !this.predictionId.equals(other.predictionId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Predictions[ predictionId=" + predictionId + " ]";
    }
    
}
