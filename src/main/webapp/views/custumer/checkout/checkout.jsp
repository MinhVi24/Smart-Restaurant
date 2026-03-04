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
    
    <style>
        #qrSection {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease;
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
                        <div class="md-card-header" style="margin-top: 24px;">
                            <h3 class="md-card-title" style="font-size: 14px;">Quét Mã QR Để Thanh Toán</h3>
                            <p class="md-text-muted" style="font-size: 11px; margin-top: 4px;">
                                Sử dụng ứng dụng ngân hàng để quét mã QR
                            </p>
                        </div>
                        
                        <div class="md-qr-container">
                            <div class="md-qr-code" id="qrcode"></div>
                            
                            <div style="text-align: center; margin-bottom: 16px;">
                                <p class="md-text-muted" style="font-size: 12px; margin-bottom: 8px;">
                                    Số tiền cần thanh toán
                                </p>
                                <p class="md-text-gold" style="font-size: 28px; font-weight: 700; font-family: var(--md-font-serif);" id="paymentAmount">
                                    0₫
                                </p>
                            </div>
                            
                            <!-- Payment Instructions -->
                            <div style="background: rgba(212, 175, 53, 0.1); border: 1px solid var(--md-primary); border-radius: 8px; padding: 16px; margin-top: 16px;">
                                <p style="font-weight: 600; margin-bottom: 12px; font-size: 13px; color: var(--md-text);">
                                    <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">info</span>
                                    Hướng dẫn thanh toán:
                                </p>
                                <ol style="margin: 0; padding-left: 20px; color: var(--md-text-muted); font-size: 12px; line-height: 1.8;">
                                    <li>Mở ứng dụng ngân hàng trên điện thoại</li>
                                    <li>Chọn chức năng quét mã QR</li>
                                    <li>Quét mã QR phía trên</li>
                                    <li>Kiểm tra thông tin và xác nhận thanh toán</li>
                                    <li>Sau khi thanh toán thành công, nhấn "Xác Nhận Đặt Bàn"</li>
                                </ol>
                            </div>
                            
                            <!-- Bank Info (Fallback) -->
                            <div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid rgba(0,0,0,0.1);">
                                <p style="font-size: 11px; color: #666; text-align: center; margin-bottom: 8px;">
                                    Hoặc chuyển khoản thủ công:
                                </p>
                                <div style="background: #f5f5f5; border-radius: 6px; padding: 12px; font-size: 12px; color: #333;">
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                                        <span style="color: #666;">Ngân hàng:</span>
                                        <span style="font-weight: 600;" id="bankName">Vietcombank</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                                        <span style="color: #666;">Số TK:</span>
                                        <span style="font-weight: 600; font-family: monospace;" id="accountNumber">1234567890</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                                        <span style="color: #666;">Chủ TK:</span>
                                        <span style="font-weight: 600;" id="accountOwner">MAISON DOR</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between;">
                                        <span style="color: #666;">Nội dung:</span>
                                        <span style="font-weight: 600; font-family: monospace; color: var(--md-primary);" id="transferNote">Dat ban MD...</span>
                                    </div>
                                </div>
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
        // VietQR Configuration - THÔNG TIN NGÂN HÀNG THẬT
        const BANK_CONFIG = {
            bankId: 'TPB',               // TPBank
            accountNo: '07318937999',    // Số tài khoản
            accountName: 'TRAN MINH VI', // Tên chủ tài khoản
            template: 'compact'          // Template: compact, print, qr_only
        };
        
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
                    
                    // Show QR section with animation
                    qrSection.style.display = 'block';
                    setTimeout(() => {
                        qrSection.style.opacity = '1';
                        qrSection.style.transform = 'translateY(0)';
                    }, 10);
                    
                    // Generate QR code
                    if (!qrCodeGenerated || window.lastPercentage !== percentage) {
                        generateVietQR(depositAmount);
                        window.lastPercentage = percentage;
                        qrCodeGenerated = true;
                    }
                }
            });
        });

        function generateVietQR(amount) {
            // Clear previous QR code
            const qrContainer = document.getElementById('qrcode');
            qrContainer.innerHTML = '<div style="text-align: center; padding: 20px;"><div class="loading-spinner"></div><p style="color: var(--md-text-muted); font-size: 12px; margin-top: 12px;">Đang tạo mã QR...</p></div>';
            
            // Generate order ID
            const orderId = 'MD' + Date.now();
            
            // Create payment description
            const description = 'Dat ban ' + orderId;
            
            // Update bank info display
            updateBankInfo(orderId);
            
            // VietQR API URL (using img.vietqr.io service)
            const qrUrl = `https://img.vietqr.io/image/${BANK_CONFIG.bankId}-${BANK_CONFIG.accountNo}-${BANK_CONFIG.template}.png?amount=${amount}&addInfo=${encodeURIComponent(description)}&accountName=${encodeURIComponent(BANK_CONFIG.accountName)}`;
            
            // Create image element
            const img = new Image();
            img.onload = function() {
                qrContainer.innerHTML = '';
                img.style.width = '100%';
                img.style.height = 'auto';
                img.style.borderRadius = '8px';
                qrContainer.appendChild(img);
            };
            
            img.onerror = function() {
                // Fallback to canvas QR if API fails
                qrContainer.innerHTML = '';
                generateFallbackQR(amount, description);
            };
            
            img.src = qrUrl;
            
            // Store order ID for reference
            window.currentOrderId = orderId;
        }
        
        function updateBankInfo(orderId) {
            // Update bank name based on bank ID
            const bankNames = {
                'VCB': 'Vietcombank',
                'TCB': 'Techcombank',
                'MB': 'MB Bank',
                'ACB': 'ACB',
                'VPB': 'VPBank',
                'TPB': 'TPBank',
                'STB': 'Sacombank',
                'VIB': 'VIB',
                'MSB': 'MSB',
                'BIDV': 'BIDV'
            };
            
            document.getElementById('bankName').textContent = bankNames[BANK_CONFIG.bankId] || BANK_CONFIG.bankId;
            document.getElementById('accountNumber').textContent = BANK_CONFIG.accountNo;
            document.getElementById('accountOwner').textContent = BANK_CONFIG.accountName;
            document.getElementById('transferNote').textContent = 'Dat ban ' + orderId;
        }
        
        function generateFallbackQR(amount, description) {
            // Fallback: Generate QR with payment info using QRCode.js
            const qrContainer = document.getElementById('qrcode');
            qrContainer.innerHTML = '';
            
            const canvas = document.createElement('canvas');
            qrContainer.appendChild(canvas);
            
            // Create payment string (VietQR format)
            const paymentData = `00020101021238570010A00000072701270006970454011${BANK_CONFIG.accountNo}0208QRIBFTTA53037045802VN62${('0' + description.length).slice(-2)}${description}6304`;
            
            QRCode.toCanvas(
                canvas,
                paymentData,
                {
                    width: 280,
                    height: 280,
                    margin: 2,
                    color: {
                        dark: '#000000',
                        light: '#ffffff'
                    }
                },
                function (error) {
                    if (error) {
                        console.error('QR generation error:', error);
                        qrContainer.innerHTML = '<p style="color: #ef4444; text-align: center; padding: 20px;">Không thể tạo mã QR. Vui lòng thử lại.</p>';
                    }
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
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="loading-spinner" style="width: 20px; height: 20px; margin-right: 8px;"></span>Đang xử lý...';
        });

        // Auto-select 100% by default
        window.addEventListener('load', function() {
            const defaultRadio = document.querySelector('input[name="depositPercentage"][value="100"]');
            if (defaultRadio) {
                defaultRadio.checked = true;
                defaultRadio.dispatchEvent(new Event('change'));
            }
        });

        // Responsive handling
        if (window.innerWidth < 768) {
            const form = document.querySelector('form > div');
            if (form) {
                form.style.gridTemplateColumns = '1fr';
            }
        }
    </script>
</body>
</html>
