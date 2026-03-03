<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bảng bếp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; }
    </style>
</head>
<body>
    <%@ include file="layout/_header.jspf" %>
    <h2 style="margin:0 0 12px 0">Bảng bếp</h2>
    <div class="staff-grid">
      <div class="staff-card">
        <p class="staff-muted">Khu vực theo dõi món đang chế biến. Sẽ hiển thị danh sách món theo trạng thái PREPARING, READY.</p>
      </div>
    </div>
    <%@ include file="layout/_footer.jspf" %>
</body>
</html>
