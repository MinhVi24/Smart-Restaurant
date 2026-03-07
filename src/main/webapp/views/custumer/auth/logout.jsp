<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng xuất - Maison D'Or</title>
</head>
<body>
    <script>
        // Clear all sessionStorage data
        sessionStorage.clear();
        
        // Redirect to login page
        window.location.href = '${pageContext.request.contextPath}/login';
    </script>
</body>
</html>
