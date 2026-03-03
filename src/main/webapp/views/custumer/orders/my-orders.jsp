<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Maison D'or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/includes/header.jsp" />
    
    <main class="md-container" style="padding: 48px 0; min-height: calc(100vh - 200px);">
        <!-- Page Header -->
        <div style="margin-bottom: 32px;">
            <h1 class="md-heading-1" style="margin-bottom: 8px;">Đơn hàng của tôi</h1>
            <p class="md-text-muted">Theo dõi các đơn hàng của bạn</p>
        </div>

        <!-- Orders List -->
        <c:choose>
            <c:when test="${empty orders}">
                <div class="md-card" style="text-align: center; padding: 64px 24px;">
                    <span class="material-symbols-outlined" style="font-size: 64px; color: var(--md-text-muted); margin-bottom: 16px;">receipt_long</span>
                    <h3 style="margin-bottom: 8px;">Chưa có đơn hàng nào</h3>
                    <p class="md-text-muted" style="margin-bottom: 24px;">Bạn chưa có đơn hàng nào</p>
                    <a href="${pageContext.request.contextPath}/menu" class="md-btn md-btn-primary">Xem thực đơn</a>
                </div>
            </c:when>
            <c:otherwise>
                <div style="display: grid; gap: 16px;">
                    <c:forEach var="order" items="${orders}">
                        <div class="md-card" style="padding: 24px;">
                            <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 16px;">
                                <div>
                                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 8px;">
                                        <h3 style="font-size: 18px; margin: 0;">Đơn hàng #${order.orderId}</h3>
                                        <c:choose>
                                            <c:when test="${order.status == 'COMPLETED'}">
                                                <span class="md-badge" style="background: rgba(34, 197, 94, 0.1); color: #22c55e; border: 1px solid rgba(34, 197, 94, 0.2);">
                                                    Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="md-badge" style="background: rgba(251, 191, 36, 0.1); color: #fbbf24; border: 1px solid rgba(251, 191, 36, 0.2);">
                                                    Đang xử lý
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="md-badge" style="background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2);">
                                                    Đã hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="md-badge">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <p class="md-text-muted" style="font-size: 13px;">
                                        <fmt:formatDate value="${order.orderTime}" pattern="dd/MM/yyyy HH:mm" />
                                    </p>
                                </div>
                                <div style="text-align: right;">
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Tổng tiền</p>
                                    <p style="font-size: 24px; font-weight: 700; color: var(--md-primary);">
                                        <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" />đ
                                    </p>
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; padding: 16px; background: rgba(255, 255, 255, 0.02); border-radius: 8px; border: 1px solid var(--md-border);">
                                <div>
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Bàn</p>
                                    <p style="font-weight: 600;">
                                        <c:choose>
                                            <c:when test="${not empty order.tableId}">
                                                ${order.tableId.tableNumber}
                                            </c:when>
                                            <c:otherwise>
                                                Mang về
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <c:if test="${not empty order.reservationId}">
                                    <div>
                                        <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Đặt bàn</p>
                                        <p style="font-weight: 600;">#${order.reservationId.reservationId}</p>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Order Items -->
                            <c:if test="${not empty order.orderItemsCollection}">
                                <div style="margin-top: 16px;">
                                    <p class="md-text-muted" style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px;">Món ăn</p>
                                    <div style="display: grid; gap: 8px;">
                                        <c:forEach var="item" items="${order.orderItemsCollection}">
                                            <div style="display: flex; justify-content: space-between; align-items: center; padding: 8px; background: rgba(255, 255, 255, 0.02); border-radius: 6px;">
                                                <div style="display: flex; align-items: center; gap: 12px;">
                                                    <span style="font-weight: 600; color: var(--md-primary);">${item.quantity}x</span>
                                                    <span>${item.menuItemId.itemName}</span>
                                                </div>
                                                <span style="font-weight: 600;">
                                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />đ
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </div>
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
