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
                                Gio hang trong
                            </p>
                        </c:if>
                    </div>

                    <!-- Total Amount -->
                    <div style="padding: 20px 0; border-top: 2px solid var(--md-border-gold);">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 16px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em;">Tong Cong</span>
                            <span class="md-text-gold" style="font-size: 28px; font-family: var(--md-font-serif); font-weight: 700;">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="d"/>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Payment QR Code -->
                <div class="md-card md-fade-in" style="animation-delay: 0.1s;">
                    <div class="md-card-header">
                        <h2 class="md-card-title">Thanh Toan QR Code</h2>
                        <p class="md-text-muted" style="font-size: 12px; margin-top: 8px;">
                            Quet ma QR de thanh toan toan bo don hang
                        </p>
                    </div>

                    <!-- Hidden input - always 100% -->
                    <input type="hidden" name="depositPercentage" value="100">
                    
                    <!-- Payment Section -->
                    <div id="qrSection" style="opacity: 1; transform: translateY(0);">
                        <div class="md-qr-container">
                            <!-- QR Code Display -->
                            <div style="text-align: center; margin-bottom: 20px;">
                                <h3 style="color: var(--md-text); font-size: 16px; font-weight: 700; margin-bottom: 16px;">Quet Ma QR De Thanh Toan</h3>
                                <div style="background: white; padding: 16px; border-radius: 12px; display: inline-block;">
                                    <img id="qrCodeImage" src="" alt="QR Code" style="width: 280px; height: 280px; display: block;">
                                </div>
                            </div>
                            
                            <div style="text-align: center; margin-bottom: 20px;">
                                <p class="md-text-muted" style="font-size: 13px; margin-bottom: 8px;">
                                    So tien can thanh toan
                                </p>
                                <p class="md-text-gold" style="font-size: 32px; font-weight: 700; font-family: var(--md-font-serif);">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="d"/>
                                </p>
                            </div>
                            
                            <!-- Payment Instructions -->
                            <div style="background: rgba(212, 175, 53, 0.15); border: 1px solid var(--md-primary); border-radius: 8px; padding: 20px; margin-bottom: 20px;">
                                <p style="font-weight: 700; margin-bottom: 16px; font-size: 15px; color: var(--md-primary);">
                                    <span class="material-symbols-outlined" style="font-size: 18px; vertical-align: middle; margin-right: 6px;">info</span>
                                    Huong dan thanh toan:
                                </p>
                                <ol style="margin: 0; padding-left: 20px; color: var(--md-text); font-size: 14px; line-height: 2; font-weight: 500;">
                                    <li>Mo ung dung ngan hang tren dien thoai</li>
                                    <li>Chon chuc nang quet ma QR</li>
                                    <li>Quet ma QR ben tren</li>
                                    <li>Kiem tra thong tin va xac nhan thanh toan</li>
                                    <li>Sau khi chuyen khoan thanh cong, nhan nut "Xac Nhan Dat Ban" ben duoi</li>
                                </ol>
                            </div>
                            
                            <!-- Bank Info -->
                            <div style="background: rgba(255, 255, 255, 0.05); border: 1px solid var(--md-border); border-radius: 8px; padding: 16px;">
                                <p style="font-size: 13px; color: var(--md-text-muted); text-align: center; margin-bottom: 12px;">
                                    Thong tin chuyen khoan:
                                </p>
                                <div style="font-size: 13px;">
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; padding: 6px 0;">
                                        <span style="color: var(--md-text-muted);">Ngan hang:</span>
                                        <span style="font-weight: 600; color: var(--md-text);">TPBank</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; padding: 6px 0;">
                                        <span style="color: var(--md-text-muted);">So TK:</span>
                                        <span style="font-weight: 700; font-family: monospace; color: var(--md-primary);">07318937999</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; padding: 6px 0;">
                                        <span style="color: var(--md-text-muted);">Chu TK:</span>
                                        <span style="font-weight: 600; color: var(--md-text);">TRAN MINH VI</span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; padding: 6px 0;">
                                        <span style="color: var(--md-text-muted);">Noi dung:</span>
                                        <span style="font-weight: 700; font-family: monospace; color: var(--md-primary);" id="transferNote">DatBan MD</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <input type="hidden" name="paymentMethod" value="QR">
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="md-btn md-btn-primary" style="width: 100%; padding: 16px; font-size: 13px; margin-top: 24px;">
                        <span class="material-symbols-outlined" style="font-size: 20px;">check_circle</span>
                        Xac Nhan Dat Ban
                    </button>

                    <p class="md-text-muted" style="font-size: 11px; text-align: center; margin-top: 16px;">
                        Bang cach xac nhan, ban dong y voi dieu khoan va chinh sach cua chung toi
                    </p>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="/views/includes/footer.jsp"/>

    <script>
        // Generate unique order ID
        const orderId = 'MD' + Date.now();
        const totalAmount = ${not empty totalAmount ? totalAmount : 0};
        
        // Check if totalAmount is valid
        if (!totalAmount || totalAmount <= 0) {
            console.error('Invalid total amount:', totalAmount);
            document.getElementById('qrCodeImage').parentElement.innerHTML = 
                '<div style="padding: 40px; text-align: center;">' +
                '<span class="material-symbols-outlined" style="font-size: 64px; color: #ef4444; opacity: 0.5;">error</span>' +
                '<p style="color: #ef4444; margin-top: 16px; font-size: 14px;">Loi: Gio hang trong</p>' +
                '<p style="color: var(--md-text-muted); margin-top: 8px; font-size: 12px;">Vui long quay lai chon mon</p>' +
                '</div>';
        } else {
            // Update transfer note
            document.getElementById('transferNote').textContent = 'DatBan' + orderId;
            
            // Generate VietQR URL
            const bankId = 'TPB';
            const accountNo = '07318937999';
            const accountName = 'TRAN MINH VI';
            const description = 'DatBan' + orderId;
            
            // Build QR URL using VietQR API
            const qrUrl = 'https://img.vietqr.io/image/' + bankId + '-' + accountNo + '-compact.png' +
                          '?amount=' + totalAmount +
                          '&addInfo=' + encodeURIComponent(description) +
                          '&accountName=' + encodeURIComponent(accountName);
            
            console.log('QR URL:', qrUrl);
            
            // Set QR code image
            const qrImage = document.getElementById('qrCodeImage');
            qrImage.src = qrUrl;
            
            qrImage.onerror = function() {
                console.error('Failed to load QR code');
                // Show error message
                this.parentElement.innerHTML = '<div style="padding: 40px; text-align: center;"><span class="material-symbols-outlined" style="font-size: 64px; color: #ef4444; opacity: 0.5;">error</span><p style="color: #ef4444; margin-top: 16px; font-size: 14px;">Khong the tai ma QR</p><p style="color: var(--md-text-muted); margin-top: 8px; font-size: 12px;">Vui long chuyen khoan thu cong theo thong tin ben duoi</p></div>';
            };
            
            qrImage.onload = function() {
                console.log('QR code loaded successfully');
            };
        }

        // Form validation and submission
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            // Confirm payment
            if (!confirm('Ban da chuyen khoan thanh cong chua?\n\nNhan OK neu ban da hoan tat thanh toan.')) {
                e.preventDefault();
                return false;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="loading-spinner" style="width: 20px; height: 20px; margin-right: 8px;"></span>Dang xu ly...';
        });
    </script>
</body>
</html>
