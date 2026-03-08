<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dat Ban Thanh Cong - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1410 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .success-container {
            max-width: 600px;
            width: 100%;
            background: rgba(23, 22, 17, 0.98);
            border: 1px solid var(--md-border-gold);
            border-radius: var(--md-radius-lg);
            padding: 48px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 0.6s ease;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: rgba(40, 209, 124, 0.1);
            border: 2px solid #28d17c;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            animation: scaleIn 0.5s ease 0.2s both;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        
        .success-icon .material-symbols-outlined {
            font-size: 48px;
            color: #28d17c;
        }
        
        .success-title {
            font-family: var(--md-font-serif);
            font-size: 2rem;
            color: var(--md-text);
            margin-bottom: 12px;
        }
        
        .success-subtitle {
            color: var(--md-text-muted);
            font-size: 1rem;
            margin-bottom: 32px;
            line-height: 1.6;
        }
        
        .booking-details {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--md-border);
            border-radius: var(--md-radius);
            padding: 24px;
            margin-bottom: 32px;
            text-align: left;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid var(--md-border);
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: var(--md-text-muted);
            font-size: 0.875rem;
        }
        
        .detail-value {
            color: var(--md-text);
            font-weight: 600;
        }
        
        .detail-value.highlight {
            color: var(--md-primary);
            font-family: var(--md-font-serif);
            font-size: 1.125rem;
        }
        
        .total-amount {
            background: rgba(212, 175, 53, 0.1);
            border: 1px solid var(--md-primary);
            border-radius: var(--md-radius);
            padding: 20px;
            margin-bottom: 32px;
        }
        
        .total-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--md-text-muted);
            margin-bottom: 8px;
        }
        
        .total-value {
            font-family: var(--md-font-serif);
            font-size: 2rem;
            font-weight: 700;
            color: var(--md-primary);
        }
        
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .info-box {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            border-radius: var(--md-radius);
            padding: 16px;
            margin-top: 24px;
            text-align: left;
        }
        
        .info-box p {
            color: rgba(147, 197, 253, 0.9);
            font-size: 0.875rem;
            line-height: 1.6;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <!-- Success Icon -->
        <div class="success-icon">
            <span class="material-symbols-outlined">check_circle</span>
        </div>
        
        <!-- Title -->
        <h1 class="success-title">Dat Ban Thanh Cong!</h1>
        <p class="success-subtitle">
            Cam on ban da chon Maison D'Or. Chung toi da nhan duoc yeu cau dat ban cua ban.
        </p>
        
        <!-- Booking Details -->
        <div class="booking-details">
            <div class="detail-row">
                <span class="detail-label">Ma dat ban:</span>
                <span class="detail-value highlight">#${reservation.reservationId}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Ban so:</span>
                <span class="detail-value">#${reservation.tableId.tableId}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Khu vuc:</span>
                <span class="detail-value">${reservation.tableId.area}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Ngay gio:</span>
                <span class="detail-value">
                    <fmt:formatDate value="${reservation.reservationTime}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>
            <div class="detail-row">
                <span class="detail-label">So khach:</span>
                <span class="detail-value">${reservation.guestCount} nguoi</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Trang thai:</span>
                <span class="detail-value" style="color: #28d17c;">${reservation.status}</span>
            </div>
        </div>
        
        <!-- Total Amount -->
        <div class="total-amount">
            <div class="total-label">Tong tien</div>
            <div class="total-value">
                <fmt:formatNumber value="${payment.totalAmount}" pattern="#,###"/>đ
            </div>
            <p style="font-size: 0.75rem; color: var(--md-text-muted); margin-top: 8px;">
                Phuong thuc: ${payment.paymentMethod} | 
                Trang thai: <span style="color: #28d17c;">${payment.paymentStatus}</span>
            </p>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/views/custumer/home/home.jsp" class="md-btn md-btn-primary" style="text-decoration: none;">
                <span class="material-symbols-outlined" style="font-size: 20px;">home</span>
                Tro Ve Trang Chu
            </a>
            <a href="${pageContext.request.contextPath}/bookings/history" class="md-btn md-btn-secondary" style="text-decoration: none;">
                <span class="material-symbols-outlined" style="font-size: 20px;">history</span>
                Xem Lich Su Dat Ban
            </a>
        </div>
        
        <!-- Info Box -->
        <div class="info-box">
            <p>
                <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">info</span>
                <strong>Luu y:</strong> Vui long den dung gio da dat. Neu tre hon 15 phut, ban cua ban co the bi huy. 
                Neu can thay doi hoac huy dat ban, vui long lien he: <strong>1900-xxxx</strong>
            </p>
        </div>
    </div>
</body>
</html>
