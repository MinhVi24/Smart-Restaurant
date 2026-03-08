<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng Nhập - Maison D'Or</title>

            <!-- CSS Thống Nhất -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
            <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap"
                rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
        </head>

        <body>
            <!-- Header Thống Nhất -->
            <jsp:include page="/views/includes/header.jsp" />

            <!-- Main Content -->
            <main
                style="min-height: calc(100vh - 72px); display: flex; align-items: center; justify-content: center; padding: 40px 20px;">
                <div class="md-card" style="max-width: 480px; width: 100%; padding: 48px;">
                    <div style="text-align: center; margin-bottom: 40px;">
                        <h1
                            style="font-family: var(--md-font-serif); font-size: 2rem; color: var(--md-primary); margin-bottom: 8px;">
                            Đăng Nhập</h1>
                        <p style="color: var(--md-text-muted);">Chào mừng quý khách trở lại</p>
                    </div>

                    <!-- Error Messages -->
                    <c:if test="${not empty error}">
                        <div
                            style="background: rgba(220, 38, 38, 0.1); border: 1px solid rgba(220, 38, 38, 0.3); border-radius: var(--md-radius); padding: 12px; margin-bottom: 24px; color: #fca5a5; text-align: center; font-size: 0.875rem;">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${param.success == 'true'}">
                        <div
                            style="background: rgba(34, 197, 94, 0.1); border: 1px solid rgba(34, 197, 94, 0.3); border-radius: var(--md-radius); padding: 12px; margin-bottom: 24px; color: #86efac; text-align: center; font-size: 0.875rem;">
                            Đăng ký thành công! Vui lòng đăng nhập.
                        </div>
                    </c:if>

                    <c:if test="${param.reset == 'success'}">
                        <div
                            style="background: rgba(34, 197, 94, 0.1); border: 1px solid rgba(34, 197, 94, 0.3); border-radius: var(--md-radius); padding: 12px; margin-bottom: 24px; color: #86efac; text-align: center; font-size: 0.875rem;">
                            Đổi mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.
                        </div>
                    </c:if>

                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="returnUrl"
                            value="${param.returnUrl != null ? param.returnUrl : requestScope.returnUrl}">

                        <div style="margin-bottom: 24px;">
                            <label for="username" class="md-label">Tên đăng nhập</label>
                            <input type="text" id="username" name="username" class="md-input"
                                placeholder="Nhập tên đăng nhập" required>
                        </div>

                        <div style="margin-bottom: 24px;">
                            <div
                                style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                <label for="password" class="md-label">Mật khẩu</label>
                                <a href="${pageContext.request.contextPath}/forgot-password"
                                    style="color: var(--md-primary); font-size: 0.875rem; text-decoration: none;">Quên
                                    mật khẩu?</a>
                            </div>
                            <input type="password" id="password" name="password" class="md-input" placeholder="••••••••"
                                required>
                        </div>

                        <button type="submit" class="md-btn md-btn-primary" style="width: 100%; margin-top: 32px;">
                            Đăng Nhập
                        </button>
                    </form>

                    <!-- Divider -->
                    <div style="position: relative; margin: 32px 0;">
                        <div style="position: absolute; inset: 0; display: flex; align-items: center;">
                            <div style="width: 100%; border-top: 1px solid var(--md-border);"></div>
                        </div>
                        <div style="position: relative; display: flex; justify-content: center;">
                            <span
                                style="background: var(--md-surface-dark); padding: 0 16px; color: var(--md-text-muted); font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.1em;">Hoặc
                                tiếp tục với</span>
                        </div>
                    </div>

                    <!-- Google Login -->
                    <a href="${googleLoginUrl}" class="md-btn md-btn-secondary"
                        style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 12px; background: white; color: #1f2937; text-decoration: none;">
                        <svg style="width: 20px; height: 20px;" viewBox="0 0 24 24">
                            <path fill="#4285F4"
                                d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
                            <path fill="#34A853"
                                d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
                            <path fill="#FBBC05"
                                d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
                            <path fill="#EA4335"
                                d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
                        </svg>
                        Đăng nhập với Google
                    </a>

                    <!-- Register Link -->
                    <div style="text-align: center; margin-top: 32px;">
                        <p style="color: var(--md-text-muted); font-size: 0.875rem;">
                            Chưa có tài khoản?
                            <a href="${pageContext.request.contextPath}/register"
                                style="color: var(--md-primary); text-decoration: none; font-weight: 600; margin-left: 4px;">
                                Đăng ký ngay
                            </a>
                        </p>
                    </div>
                </div>
            </main>
        </body>

        </html>