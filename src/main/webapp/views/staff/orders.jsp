<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng</title>
    <meta http-equiv="refresh" content="30">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .topbar { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px,1fr)); gap: 12px; }
        .card { border: 1px solid #ddd; border-radius: 8px; padding: 12px; background: #fff; }
        .tag { padding: 2px 8px; border-radius: 999px; background: #f4f4f5; font-size: 12px; }
        .muted { color: #52525b; font-size: 12px; }
    </style>
</head>
<body>
    <%@ include file="layout/_header.jspf" %>
    <div style="display:flex;align-items:center;gap:8px;margin-bottom:12px">
        <h2 style="margin:0">Đơn hàng</h2>
        <span class="staff-badge">${status}</span>
    </div>
    <div class="staff-grid">
        <c:forEach var="o" items="${orders}">
            <div class="staff-card">
                <div><strong>ID:</strong> ${o.orderId}</div>
                <div><strong>Trạng thái:</strong> ${o.status}</div>
                <div class="staff-muted">Danh sách món xem chi tiết trong phiếu</div>
            </div>
        </c:forEach>
    </div>
    <%@ include file="layout/_footer.jspf" %>
</body>
</html>
