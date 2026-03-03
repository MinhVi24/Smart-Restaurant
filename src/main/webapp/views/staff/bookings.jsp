<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt bàn chờ xác nhận</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .topbar { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px,1fr)); gap: 12px; }
        .card { border: 1px solid #ddd; border-radius: 8px; padding: 12px; background: #fff; }
        .actions { display: flex; gap: 8px; margin-top: 8px; }
        .btn { padding: 8px 12px; border: 0; border-radius: 6px; cursor: pointer; }
        .btn-primary { background: #0ea5e9; color: #fff; }
        .btn-success { background: #10b981; color: #fff; }
        .btn-danger { background: #ef4444; color: #fff; }
        .tag { padding: 2px 8px; border-radius: 999px; background: #f4f4f5; font-size: 12px; }
        .muted { color: #52525b; font-size: 12px; }
    </style>
    <script>
        function post(action, id) {
            const f = document.createElement('form');
            f.method = 'POST';
            f.action = '';
            const a = document.createElement('input');
            a.type = 'hidden'; a.name = 'action'; a.value = action;
            const i = document.createElement('input');
            i.type = 'hidden'; i.name = 'id'; i.value = id;
            f.appendChild(a); f.appendChild(i);
            document.body.appendChild(f); f.submit();
        }
    </script>
    <meta http-equiv="refresh" content="30">
    </head>
<body>
    <%@ include file="layout/_header.jspf" %>
    <div style="display:flex;align-items:center;gap:8px;margin-bottom:12px">
        <h2 style="margin:0">Đặt bàn</h2>
        <span class="staff-badge">${status}</span>
    </div>
    <div class="staff-grid">
        <c:forEach var="r" items="${reservations}">
            <div class="staff-card">
                <div><strong>ID:</strong> ${r.reservationId}</div>
                <div><strong>Giờ hẹn:</strong> ${r.reservationTime}</div>
                <div><strong>Khách:</strong> <c:out value="${r.customerId != null ? r.customerId.customerId : 'N/A'}"/></div>
                <div><strong>Bàn:</strong> <c:out value="${r.tableId != null ? r.tableId.tableId : 'N/A'}"/></div>
                <div class="staff-muted">Khách phải có mặt trong 15 phút từ giờ hẹn</div>
                <div class="staff-actions">
                    <button class="btn btn-success" onclick="post('confirm', '${r.reservationId}')">Xác nhận</button>
                    <button class="btn btn-danger" onclick="post('cancel', '${r.reservationId}')">Hủy</button>
                    <button class="btn btn-primary" onclick="post('no_show', '${r.reservationId}')">Không đến</button>
                </div>
            </div>
        </c:forEach>
    </div>
    <%@ include file="layout/_footer.jspf" %>
</body>
</html>
