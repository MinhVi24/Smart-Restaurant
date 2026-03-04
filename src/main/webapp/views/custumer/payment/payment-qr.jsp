<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toan - Maison D'Or</title>
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
        
        .payment-container {
            max-width: 500px;
            width: 100%;
            background: rgba(23, 22, 17, 0.98);
            border: 1px solid var(--md-border-gold);
            border-radius: var(--md-radius-lg);
            padding: 40px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }
        
        .payment-title {
            font-family: var(--md-font-serif);
            font-size: 1.75rem;
            color: var(--md-primary);
            margin-bottom: 8px;
        }
        
        .payment-subtitle {
            color: var(--md-text-muted);
            font-size: 0.875rem;
            margin-bottom: 32px;
        }
        
        .qr-container {
            background: white;
            padding: 24px;
            border-radius: 16px;
            display: inline-block;
            margin-bottom: 24px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }
        
        .qr-container img {
            width: 280px;
            height: 280px;
            display: block;
        }
        
        .amount-box {
            background: rgba(212, 175, 53, 0.1);
            border: 1px solid var(--md-primary);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
        }
        
        .amount-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--md-text-muted);
            margin-bottom: 8px;
        }
        
        .amount-value {
            font-family: var(--md-font-serif);
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--md-primary);
        }
        
        .order-info {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--md-border);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
            text-align: left;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid var(--md-border);
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            color: var(--md-text-muted);
            font-size: 0.875rem;
        }
        
        .info-value {
            color: var(--md-text);
            font-weight: 600;
            font-size: 0.875rem;
        }
        
        .instructions {
            background: linear-gradient(135deg, rgba(212, 175, 53, 0.15), rgba(212, 175, 53, 0.05));
            border: 1px solid var(--md-primary);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
            text-align: left;
        }
        
        .instructions-title {
            display: flex;
            align-items: center;
            color: var(--md-primary);
            font-weight: 700;
            font-size: 0.875rem;
            margin-bottom: 12px;
        }
        
        .instructions ol {
            margin: 0;
            padding-left: 20px;
            color: var(--md-text);
            font-size: 0.875rem;
            line-height: 2;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <h1 class="payment-title">Quet Ma QR De Thanh Toan</h1>
        <p class="payment-subtitle">Ma don hang: <strong>#${reservation.reservationId}</strong></p>
        
        <!-- QR Code -->
        <div class="qr-container">
            <img id="qrImage" src="" alt="QR Code">
        </div>
        
        <!-- Amount -->
        <div class="amount-box">
            <div class="amount-label">So tien can thanh toan</div>
            <div class="amount-value">
                <fmt:formatNumber value="${payment.totalAmount}" pattern="#,###"/>d
            </div>
        </div>
        
        <!-- Order Info -->
        <div class="order-info">
            <div class="info-row">
                <span class="info-label">Ban so:</span>
                <span class="info-value">#${reservation.tableId.tableId}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Ngay gio:</span>
                <span class="info-value">
                    <fmt:formatDate value="${reservation.reservationTime}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>
            <div class="info-row">
                <span class="info-label">So khach:</span>
                <span class="info-value">${reservation.guestCount} nguoi</span>
            </div>
            <div class="info-row">
                <span class="info-label">Ngan hang:</span>
                <span class="info-value">TPBank - 07318937999</span>
            </div>
            <div class="info-row">
                <span class="info-label">Chu TK:</span>
                <span class="info-value">TRAN MINH VI</span>
            </div>
            <div class="info-row">
                <span class="info-label">Noi dung CK:</span>
                <span class="info-value" style="color: var(--md-primary);">DatBan${reservation.reservationId}</span>
            </div>
        </div>
        
        <!-- Instructions -->
        <div class="instructions">
            <div class="instructions-title">
                <span class="material-symbols-outlined" style="font-size: 18px; margin-right: 8px;">info</span>
                Huong dan thanh toan
            </div>
            <ol>
                <li>Mo ung dung ngan hang tren dien thoai</li>
                <li>Chon chuc nang <strong>Quet Ma QR</strong></li>
                <li>Quet ma QR ben tren</li>
                <li>Xac nhan thanh toan</li>
                <li>Sau khi thanh toan xong, nhan nut ben duoi</li>
            </ol>
        </div>
        
        <!-- Action Buttons -->
        <a href="${pageContext.request.contextPath}/booking/success" class="md-btn md-btn-primary" style="width: 100%; text-decoration: none; display: block; margin-bottom: 12px;">
            <span class="material-symbols-outlined" style="font-size: 20px;">check_circle</span>
            Da Thanh Toan Xong
        </a>
        
        <a href="${pageContext.request.contextPath}/views/custumer/home/home.jsp" class="md-btn md-btn-secondary" style="width: 100%; text-decoration: none; display: block;">
            Huy va Quay Lai
        </a>
    </div>
    
    <script>
        // Generate VietQR URL
        const amount = ${payment.totalAmount};
        const orderId = '${reservation.reservationId}';
        const description = 'DatBan' + orderId;
        
        const qrUrl = 'https://img.vietqr.io/image/TPB-07318937999-compact.png' +
                      '?amount=' + amount +
                      '&addInfo=' + encodeURIComponent(description) +
                      '&accountName=' + encodeURIComponent('TRAN MINH VI');
        
        console.log('QR URL:', qrUrl);
        
        const qrImage = document.getElementById('qrImage');
        qrImage.src = qrUrl;
        
        qrImage.onerror = function() {
            console.error('Failed to load QR');
            this.src = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280"><rect width="280" height="280" fill="%23f5f5f5"/><text x="50%" y="50%" text-anchor="middle" fill="%23666" font-size="14">Khong the tai QR</text></svg>';
        };
    </script>
</body>
</html>
