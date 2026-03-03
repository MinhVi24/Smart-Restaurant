<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; }
    </style>
</head>
<body>
    <%@ include file="layout/_header.jspf" %>
    <h2 style="margin:0 0 12px 0">Thanh toán</h2>
    <div class="staff-card">
      <p class="staff-muted">Khu vực thanh toán sẽ được kết nối với đơn và hóa đơn.</p>
    </div>
    <%@ include file="layout/_footer.jspf" %>
</body>
</html>
