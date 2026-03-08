<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        #qrSection {
            opacity: 1;
            transform: translateY(0);
        }
        
        .loading-spinner {
            display: inline-block;
            width: 40px;
            height: 40px;
            border: 4px solid rgba(212, 175, 53, 0.2);
            border-top-color: var(--md-primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .md-qr-container {
            background: #ffffff;
            border-radius: 12px;
            padding: 24px;
            margin: 20px 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .md-qr-code {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 280px;
            margin-bottom: 16px;
            background: #ffffff;
            border-radius: 8px;
        }
        
        .md-radio-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            border: 2px solid var(--md-border);
            border-radius: 8px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .md-radio-item:hover {
            border-color: var(--md-primary);
            background: rgba(212, 175, 53, 0.05);
        }
        
        .md-radio-item.selected {
            border-color: var(--md-primary);
            background: rgba(212, 175, 53, 0.1);
            box-shadow: 0 0 0 3px rgba(212, 175, 53, 0.1);
        }
        
        .md-radio-item input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: var(--md-primary);
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            form > div {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/views/includes/header.jsp"/>
    
    <main class="md-container" style="padding: 40px 20px;">
        <!-- Step Indicator -->
        <div class="md-steps">
            <div class="md-step completed">
                <div class="md-step-number">✓</div>
                <span class="md-step-label">Chon Ban</span>
            </div>
            <div class="md-step-divider"></div>
            <div class="md-step completed">
                <div class="md-step-number">✓</div>
                <span class="md-step-label">Chon Mon</span>
            </div>
            <div class="md-step-divider"></div>
            <div class="md-step active">
                <div class="md-step-number">3</div>
                <span class="md-step-label">Thanh Toan</span>
            </div>
        </div>

        <h1 class="md-title">Thanh Toan Dat Ban</h1>
        <p class="md-subtitle">Hoan tat dat ban cua ban voi thanh toan an toan</p>
        
        <c:if test="${not empty success}">
            <div class="md-card" style="background: rgba(40, 209, 124, 0.1); border-color: #28d17c; margin-bottom: 24px;">
                <p style="color: #28d17c; margin: 0;">${success}</p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="md-card" style="background: rgba(239, 68, 68, 0.1); border-color: #ef4444; margin-bottom: 24px;">
                <p style="color: #ef4444; margin: 0;">${error}</p>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 32px;">
                
                <!-- Left Column: Order Summary -->
                <div class="md-card md-fade-in">
                    <div class="md-card-header">
                        <h2 class="md-card-title">Thong Tin Dat Ban</h2>
                    </div>
                    
                    <!-- Booking Details -->
                    <div style="margin-bottom: 24px;">
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Ban so:</span>
                            <span class="md-text-gold" style="font-weight: 700;">#${sessionScope.selectedTableId}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Ngay:</span>
                            <span>${sessionScope.bookingDate}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Gio:</span>
                            <span>${sessionScope.bookingTime}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">So khach:</span>
                            <span>${sessionScope.guestCount} nguoi</span>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="md-card-header">
                        <h3 class="md-card-title" style="font-size: 14px;">Mon Da Chon</h3>
                    </div>
                    
                    <div style="margin-bottom: 24px;">
                        <c:forEach var="menuItem" items="${cartItems}" varStatus="status">
                            <c:set var="quantity" value="${cart[menuItem.menuItemId]}" />
                            <c:set var="itemTotal" value="${menuItem.price * quantity}" />
                            <div style="display: flex; justify-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                                <div>
                                    <p style="font-weight: 600; margin-bottom: 4px;">${menuItem.name}</p>
                                    <p class="md-text-muted" style="font-size: 12px;">
                                        ${quantity} × <fmt:formatNumber value="${menuItem.price}" type="number" groupingUsed="true"/>đ
                                    </p>
                                </div>
                                <p class="md-text-gold" style="font-weight: 700;">
                                    <fmt:formatNumber value="${itemTotal}" type="number" groupingUsed="true"/>đ
                                </p>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty cartItems}">
                            <p style="text-align: center; color: var(--md-text-muted); padding: 20px;">
                                Gio hang trong
                            </p>
                        </c:if>
                    </div>

                    <!-- Total Amount -->
                    <div style="padding: 20px 0; border-top: 2px solid var(--md-border-gold);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 16px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;">Tong Cong</span>
                            <span class="md-text-gold" style="font-size: 28px; font-family: var(--md-font-serif); font-weight: 700;">
                                <fmt:formatNumber value="${totalAmount}" pattern="#,###"/>đ
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Payment Options -->
                <div class="md-card md-fade-in" style="animation-delay: 0.1s;">
                    <div class="md-card-header">
                        <h2 class="md-card-title">Phương Thức Thanh Toán</h2>
                        <p class="md-text-muted" style="font-size: 12px; margin-top: 8px;">
                            Chọn phương thức thanh toán cho đơn hàng
                        </p>
                    </div>

                    <!-- Hidden input - always 100% -->
                    <input type="hidden" name="depositPercentage" value="100">
                    <input type="hidden" name="paymentMethod" value="QR">
                    
                    <!-- Payment Method Selection -->
                    <div style="margin-bottom: 24px;">
                        <div style="background: linear-gradient(135deg, rgba(212, 175, 53, 0.15), rgba(212, 175, 53, 0.05)); border: 2px solid var(--md-primary); border-radius: 12px; padding: 24px;">
                            <div style="display: flex; align-items: center; margin-bottom: 16px;">
                                <span class="material-symbols-outlined" style="font-size: 48px; color: var(--md-primary); margin-right: 16px;">qr_code_scanner</span>
                                <div>
                                    <h3 style="font-size: 18px; font-weight: 700; color: var(--md-text); margin-bottom: 4px;">Thanh Toán QR Code</h3>
                                    <p class="md-text-muted" style="font-size: 13px;">Quét mã QR để thanh toán nhanh chóng</p>
                                </div>
                            </div>
                            
                            <div style="background: rgba(255, 255, 255, 0.05); border-radius: 8px; padding: 16px; margin-bottom: 16px;">
                                <p style="font-size: 14px; color: var(--md-text); margin-bottom: 12px; font-weight: 600;">
                                    <span class="material-symbols-outlined" style="font-size: 18px; vertical-align: middle; margin-right: 6px; color: var(--md-primary);">check_circle</span>
                                    Ưu điểm:
                                </p>
                                <ul style="margin: 0; padding-left: 24px; color: var(--md-text-muted); font-size: 13px; line-height: 1.8;">
                                    <li>Tự động xác nhận thanh toán trong 5-10 giây</li>
                                    <li>An toàn, bảo mật cao</li>
                                    <li>Không cần nhập thông tin thủ công</li>
                                    <li>Hỗ trợ tất cả ngân hàng có VietQR</li>
                                </ul>
                            </div>
                            
                            <div style="text-align: center; padding: 16px 0;">
                                <p class="md-text-gold" style="font-size: 14px; font-weight: 700; margin-bottom: 8px;">
                                    Số tiền cần thanh toán:
                                </p>
                                <p class="md-text-gold" style="font-size: 36px; font-weight: 700; font-family: var(--md-font-serif);">
                                    <fmt:formatNumber value="${totalAmount}" pattern="#,###"/>đ
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="md-btn md-btn-primary" style="width: 100%; padding: 18px; font-size: 15px; font-weight: 700;">
                        <span class="material-symbols-outlined" style="font-size: 22px;">arrow_forward</span>
                        Tiếp Tục Thanh Toán
                    </button>

                    <p class="md-text-muted" style="font-size: 11px; text-align: center; margin-top: 16px;">
                        Bạn sẽ được chuyển đến trang thanh toán QR code
                    </p>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="/views/includes/footer.jsp"/>

    <script>
        // Form validation and submission
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            // Validate cart
            const totalAmount = ${not empty totalAmount ? totalAmount : 0};
            
            if (!totalAmount || totalAmount <= 0) {
                e.preventDefault();
                alert('Giỏ hàng trống! Vui lòng chọn món trước khi thanh toán.');
                return false;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="loading-spinner" style="width: 20px; height: 20px; margin-right: 8px;"></span>Đang xử lý...';
        });
    </script>
</body>
</html>
