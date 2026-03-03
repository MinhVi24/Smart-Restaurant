<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt bàn - Maison D'or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/includes/header.jsp" />
    
    <main class="md-container" style="padding: 48px 0; min-height: calc(100vh - 200px);">
        <!-- Page Header -->
        <div style="margin-bottom: 32px;">
            <h1 class="md-heading-1" style="margin-bottom: 8px;">Lịch sử đặt bàn</h1>
            <p class="md-text-muted">Quản lý các đặt bàn của bạn</p>
        </div>

        <!-- Reservations List -->
        <c:choose>
            <c:when test="${empty reservations}">
                <div class="md-card" style="text-align: center; padding: 64px 24px;">
                    <span class="material-symbols-outlined" style="font-size: 64px; color: var(--md-text-muted); margin-bottom: 16px;">event_busy</span>
                    <h3 style="margin-bottom: 8px;">Chưa có đặt bàn nào</h3>
                    <p class="md-text-muted" style="margin-bottom: 24px;">Bạn chưa có lịch sử đặt bàn nào</p>
                    <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-primary">Đặt bàn ngay</a>
                </div>
            </c:when>
            <c:otherwise>
                <div style="display: grid; gap: 16px;">
                    <c:forEach var="reservation" items="${reservations}">
                        <div class="md-card" style="padding: 24px;">
                            <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 16px;">
                                <div>
                                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 8px;">
                                        <h3 style="font-size: 18px; margin: 0;">Đặt bàn #${reservation.reservationId}</h3>
                                        <c:choose>
                                            <c:when test="${reservation.status == 'CONFIRMED'}">
                                                <span class="md-badge" style="background: rgba(34, 197, 94, 0.1); color: #22c55e; border: 1px solid rgba(34, 197, 94, 0.2);">
                                                    Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'PENDING'}">
                                                <span class="md-badge" style="background: rgba(251, 191, 36, 0.1); color: #fbbf24; border: 1px solid rgba(251, 191, 36, 0.2);">
                                                    Chờ xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CANCELLED'}">
                                                <span class="md-badge" style="background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2);">
                                                    Đã hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="md-badge">${reservation.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <p class="md-text-muted" style="font-size: 13px;">
                                        <fmt:formatDate value="${reservation.reservationTime}" pattern="dd/MM/yyyy HH:mm" />
                                    </p>
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; padding: 16px; background: rgba(255, 255, 255, 0.02); border-radius: 8px; border: 1px solid var(--md-border);">
                                <div>
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Bàn</p>
                                    <p style="font-weight: 600;">
                                        <c:choose>
                                            <c:when test="${not empty reservation.tableId}">
                                                ${reservation.tableId.tableNumber}
                                            </c:when>
                                            <c:otherwise>
                                                Chưa chọn bàn
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div>
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Số khách</p>
                                    <p style="font-weight: 600;">${reservation.guestCount} người</p>
                                </div>
                                <div>
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Ngày đặt</p>
                                    <p style="font-weight: 600;">
                                        <fmt:formatDate value="${reservation.createdAt}" pattern="dd/MM/yyyy" />
                                    </p>
                                </div>
                            </div>

                            <c:if test="${not empty reservation.specialRequests}">
                                <div style="margin-top: 16px; padding: 12px; background: rgba(212, 175, 53, 0.05); border-radius: 8px; border: 1px solid var(--md-border-gold);">
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Yêu cầu đặc biệt</p>
                                    <p style="font-size: 14px;">${reservation.specialRequests}</p>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="/views/includes/footer.jsp" />
</body>
</html>
