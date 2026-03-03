<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js"></script>
</head>
<body>
    <jsp:include page="/views/includes/header.jsp"/>
    
    <main class="md-container" style="padding: 40px 20px;">
        <!-- Step Indicator -->
        <div class="md-steps">
            <div class="md-step completed">
                <div class="md-step-number">✓</div>
                <span class="md-step-label">Chọn Bàn</span>
            </div>
            <div class="md-step-divider"></div>
            <div class="md-step completed">
                <div class="md-step-number">✓</div>
                <span class="md-step-label">Chọn Món</span>
            </div>
            <div class="md-step-divider"></div>
            <div class="md-step active">
                <div class="md-step-number">3</div>
                <span class="md-step-label">Thanh Toán</span>
            </div>
        </div>

        <h1 class="md-title">Thanh Toán Đặt Bàn</h1>
        <p class="md-subtitle">Hoàn tất đặt bàn của bạn với thanh toán an toàn</p>

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
                        <h2 class="md-card-title">Thông Tin Đặt Bàn</h2>
                    </div>
                    
                    <!-- Booking Details -->
                    <div style="margin-bottom: 24px;">
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Bàn số:</span>
                            <span class="md-text-gold" style="font-weight: 700;">#${sessionScope.selectedTableId}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Ngày:</span>
                            <span>${sessionScope.bookingDate}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Giờ:</span>
                            <span>${sessionScope.bookingTime}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                            <span class="md-text-muted">Số khách:</span>
                            <span>${sessionScope.guestCount} người</span>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="md-card-header">
                        <h3 class="md-card-title" style="font-size: 14px;">Món Đã Chọn</h3>
                    </div>
                    
                    <div style="margin-bottom: 24px;">
                        <c:forEach var="menuItem" items="${cartItems}" varStatus="status">
                            <c:set var="quantity" value="${cart[menuItem.menuItemId]}" />
                            <c:set var="itemTotal" value="${menuItem.price * quantity}" />
                            <div style="display: flex; justify-between; padding: 12px 0; border-bottom: 1px solid var(--md-border);">
                                <div>
                                    <p style="font-weight: 600; margin-bottom: 4px;">${menuItem.name}</p>
                                    <p class="md-text-muted" style="font-size: 12px;">
                                        ${quantity} × <fmt:formatNumber value="${menuItem.price}" type="number" groupingUsed="true"/>₫
                                    </p>
                                </div>
                                <p class="md-text-gold" style="font-weight: 700;">
                                    <fmt:formatNumber value="${itemTotal}" type="number" groupingUsed="true"/>₫
                                </p>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty cartItems}">
                            <p style="text-align: center; color: var(--md-text-muted); padding: 20px;">
                                Giỏ hàng trống
                            </p>
                        </c:if>
                    </div>

                    <!-- Total Amount -->
                    <div style="padding: 20px 0; border-top: 2px solid var(--md-border-gold);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 16px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;">Tổng Cộng</span>
                            <span class="md-text-gold" style="font-size: 28px; font-family: var(--md-font-serif); font-weight: 700;">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"/>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Payment Options -->
                <div class="md-card md-fade-in" style="animation-delay: 0.1s;">
                    <div class="md-card-header">
                        <h2 class="md-card-title">Chọn Mức Tiền Cọc</h2>
                        <p class="md-text-muted" style="font-size: 12px; margin-top: 8px;">
                            Chọn phần trăm tiền cọc bạn muốn thanh toán ngay
                        </p>
                    </div>

                    <!-- Deposit Options -->
                    <div class="md-radio-group" style="margin-bottom: 32px;">
                        <label class="md-radio-item" data-percentage="30">
                            <input type="radio" name="depositPercentage" value="30" required>
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-weight: 600;">Cọc 30%</span>
                                    <span class="md-text-gold deposit-amount" style="font-weight: 700;">
                                        <fmt:formatNumber value="${totalAmount * 0.3}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                                <p class="md-text-muted" style="font-size: 11px; margin-top: 4px;">
                                    Còn lại: <span class="remaining-amount"><fmt:formatNumber value="${totalAmount * 0.7}" type="currency" currencySymbol="₫"/></span>
                                </p>
                            </div>
                        </label>

                        <label class="md-radio-item" data-percentage="50">
                            <input type="radio" name="depositPercentage" value="50">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-weight: 600;">Cọc 50%</span>
                                    <span class="md-text-gold deposit-amount" style="font-weight: 700;">
                                        <fmt:formatNumber value="${totalAmount * 0.5}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                                <p class="md-text-muted" style="font-size: 11px; margin-top: 4px;">
                                    Còn lại: <span class="remaining-amount"><fmt:formatNumber value="${totalAmount * 0.5}" type="currency" currencySymbol="₫"/></span>
                                </p>
                            </div>
                        </label>

                        <label class="md-radio-item" data-percentage="100">
                            <input type="radio" name="depositPercentage" value="100">
                            <div style="flex: 1;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-weight: 600;">Thanh toán đầy đủ 100%</span>
                                    <span class="md-text-gold deposit-amount" style="font-weight: 700;">
                                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                                <p class="md-text-muted" style="font-size: 11px; margin-top: 4px;">
                                    Không còn số tiền phải trả
                                </p>
                            </div>
                        </label>
                    </div>

                    <!-- QR Code Section -->
                    <div id="qrSection" style="display: none;">
                        <div class="md-card-header">
                            <h3 class="md-card-title" style="font-size: 14px;">Quét Mã QR Để Thanh Toán</h3>
                        </div>
                        
                        <div class="md-qr-container">
                            <div class="md-qr-code" id="qrcode"></div>
                            <div style="text-align: center;">
                                <p class="md-text-muted" style="font-size: 12px; margin-bottom: 8px;">
                                    Số tiền cần thanh toán
                                </p>
                                <p class="md-text-gold" style="font-size: 24px; font-weight: 700;" id="paymentAmount">
                                    0₫
                                </p>
                            </div>
                        </div>

                        <input type="hidden" name="paymentMethod" value="QR_CODE">
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="md-btn md-btn-primary" style="width: 100%; padding: 16px; font-size: 13px; margin-top: 24px;">
                        <span class="material-symbols-outlined" style="font-size: 20px;">check_circle</span>
                        Xác Nhận Đặt Bàn
                    </button>

                    <p class="md-text-muted" style="font-size: 11px; text-align: center; margin-top: 16px;">
                        Bằng cách xác nhận, bạn đồng ý với điều khoản và chính sách của chúng tôi
                    </p>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="/views/includes/footer.jsp"/>

    <script>
        // Handle deposit percentage selection
        const radioItems = document.querySelectorAll('.md-radio-item');
        const qrSection = document.getElementById('qrSection');
        const paymentAmountEl = document.getElementById('paymentAmount');
        const totalAmount = ${totalAmount};
        let qrCodeGenerated = false;

        radioItems.forEach(item => {
            const radio = item.querySelector('input[type="radio"]');
            
            radio.addEventListener('change', function() {
                // Remove selected class from all items
                radioItems.forEach(i => i.classList.remove('selected'));
                
                // Add selected class to current item
                if (this.checked) {
                    item.classList.add('selected');
                    
                    // Calculate deposit amount
                    const percentage = parseInt(this.value);
                    const depositAmount = totalAmount * (percentage / 100);
                    
                    // Update payment amount display
                    paymentAmountEl.textContent = depositAmount.toLocaleString('vi-VN') + '₫';
                    
                    // Show QR section
                    qrSection.style.display = 'block';
                    
                    // Generate QR code (only once or when amount changes)
                    if (!qrCodeGenerated || window.lastPercentage !== percentage) {
                        generateQRCode(depositAmount);
                        window.lastPercentage = percentage;
                        qrCodeGenerated = true;
                    }
                }
            });
        });

        function generateQRCode(amount) {
            // Clear previous QR code
            document.getElementById('qrcode').innerHTML = '';
            
            // Generate QR code with payment information
            // Format: Bank transfer info or payment gateway URL
            const paymentInfo = `MAISON_DOR|AMOUNT:${amount}|ORDER:${Date.now()}`;
            
            QRCode.toCanvas(
                document.getElementById('qrcode'),
                paymentInfo,
                {
                    width: 208,
                    height: 208,
                    margin: 1,
                    color: {
                        dark: '#000000',
                        light: '#ffffff'
                    }
                },
                function (error) {
                    if (error) console.error(error);
                }
            );
        }

        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const selectedDeposit = document.querySelector('input[name="depositPercentage"]:checked');
            
            if (!selectedDeposit) {
                e.preventDefault();
                alert('Vui lòng chọn mức tiền cọc');
                return false;
            }
        });

        // Responsive handling
        if (window.innerWidth < 768) {
            const form = document.querySelector('form > div');
            form.style.gridTemplateColumns = '1fr';
        }
    </script>
</body>
</html>
