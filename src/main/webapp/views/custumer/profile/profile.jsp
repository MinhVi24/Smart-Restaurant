<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/includes/header.jsp"/>
    
    <main class="md-container" style="padding: 40px 20px; min-height: calc(100vh - 200px);">
        <h1 class="md-title">Hồ Sơ Cá Nhân</h1>
        <p class="md-subtitle">Quản lý thông tin tài khoản của bạn</p>

        <c:if test="${not empty success}">
            <div class="md-card" style="background: rgba(40, 209, 124, 0.1); border-color: #28d17c; margin-bottom: 24px;">
                <p style="color: #28d17c; margin: 0;">✓ ${success}</p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="md-card" style="background: rgba(239, 68, 68, 0.1); border-color: #ef4444; margin-bottom: 24px;">
                <p style="color: #ef4444; margin: 0;">✗ ${error}</p>
            </div>
        </c:if>

        <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 24px; margin-top: 32px;">
            
            <!-- Left: Avatar & Stats -->
            <div class="md-card">
                <div style="text-align: center;">
                    <div style="width: 120px; height: 120px; margin: 0 auto 20px; border-radius: 50%; background: linear-gradient(135deg, var(--md-primary) 0%, var(--md-primary-dark) 100%); display: flex; align-items: center; justify-content: center; color: #18140c; font-size: 48px; font-weight: 700; box-shadow: var(--md-glow);">
                        ${customer.fullName.substring(0, 1).toUpperCase()}
                    </div>
                    <h2 style="font-family: var(--md-font-serif); font-size: 24px; margin-bottom: 8px;">${customer.fullName}</h2>
                    <p class="md-text-muted" style="font-size: 14px; margin-bottom: 20px;">${sessionScope.loggedInUser.email}</p>
                    
                    <div style="padding: 20px; background: rgba(212, 175, 53, 0.1); border-radius: var(--md-radius-md); border: 1px solid var(--md-border-gold);">
                        <span class="material-symbols-outlined" style="font-size: 32px; color: var(--md-primary);">stars</span>
                        <p style="font-size: 12px; color: var(--md-text-muted); margin: 8px 0 4px;">Điểm tích lũy</p>
                        <p style="font-size: 28px; font-weight: 700; color: var(--md-primary); font-family: var(--md-font-serif);">
                            <c:choose>
                                <c:when test="${customer.totalPoints != null}">
                                    ${customer.totalPoints}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                            điểm
                        </p>
                    </div>
                    
                    <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--md-border);">
                        <p style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.18em; color: var(--md-text-muted); margin-bottom: 8px;">Hạng thành viên</p>
                        <p style="font-size: 16px; font-weight: 700; color: var(--md-primary);">
                            <c:choose>
                                <c:when test="${customer.membershipLevel != null}">
                                    ${customer.membershipLevel}
                                </c:when>
                                <c:otherwise>
                                    Regular
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Right: Edit Form -->
            <div class="md-card">
                <div class="md-card-header">
                    <h2 class="md-card-title">Thông Tin Cá Nhân</h2>
                </div>

                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <div style="margin-bottom: 24px;">
                        <label class="md-label">Họ và Tên</label>
                        <input type="text" name="fullName" class="md-input" value="${customer.fullName}" required>
                    </div>

                    <div style="margin-bottom: 24px;">
                        <label class="md-label">Email</label>
                        <input type="email" class="md-input" value="${sessionScope.loggedInUser.email}" disabled style="opacity: 0.6; cursor: not-allowed;">
                        <p style="font-size: 12px; color: var(--md-text-muted); margin-top: 8px;">Email không thể thay đổi</p>
                    </div>

                    <div style="margin-bottom: 24px;">
                        <label class="md-label">Số Điện Thoại</label>
                        <input type="tel" name="phone" class="md-input" value="${customer.phone}" required>
                    </div>

                    <div style="margin-bottom: 24px;">
                        <label class="md-label">Username</label>
                        <input type="text" class="md-input" value="${sessionScope.loggedInUser.username}" disabled style="opacity: 0.6; cursor: not-allowed;">
                        <p style="font-size: 12px; color: var(--md-text-muted); margin-top: 8px;">Username không thể thay đổi</p>
                    </div>

                    <div style="display: flex; gap: 16px;">
                        <button type="submit" class="md-btn md-btn-primary">
                            <span class="material-symbols-outlined" style="font-size: 18px; vertical-align: middle; margin-right: 8px;">save</span>
                            Lưu Thay Đổi
                        </button>
                        <a href="${pageContext.request.contextPath}/" class="md-btn md-btn-ghost" style="text-decoration: none;">
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="/views/includes/footer.jsp"/>
</body>
</html>
