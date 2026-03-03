<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý bàn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/staff.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; }
    </style>
</head>
<body>
    <%@ include file="layout/_header.jspf" %>
    <h2 style="margin:0 0 12px 0">Bàn đang trống</h2>
    <table class="staff-table">
        <thead>
            <tr>
                <th>Mã bàn</th>
                <th>Khu</th>
                <th>Sức chứa</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="t" items="${availableTables}">
                <tr>
                    <td>${t.tableId}</td>
                    <td>${t.area}</td>
                    <td>${t.capacity}</td>
                    <td>${t.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <%@ include file="layout/_footer.jspf" %>
</body>
</html>
