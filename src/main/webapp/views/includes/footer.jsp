<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer style="background: #0a0a0a; border-top: 1px solid var(--md-border); padding: 48px 20px 24px;">
    <div class="md-container">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 48px; margin-bottom: 48px;">
            <!-- Column 1: About -->
            <div>
                <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 24px;">
                    <div style="width: 32px; height: 32px; border-radius: 8px; background: radial-gradient(circle at 30% 0, #fff8da, #f0cf57 28%, #b48b20 65%, #765712 100%); color: #111; display: grid; place-items: center; font-weight: 800; letter-spacing: 0.16em; font-size: 11px;">
                        M
                    </div>
                    <h3 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-text); margin: 0;">SmartResto</h3>
                </div>
                <p style="color: var(--md-text-muted); font-size: 0.875rem; line-height: 1.6; margin-bottom: 16px;">
                    Nơi hội tụ tinh hoa ẩm thực và công nghệ hiện đại, mang đến trải nghiệm 5 sao chuẩn mực mới.
                </p>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div>
                <h4 style="color: var(--md-text); font-weight: 700; margin-bottom: 20px; font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.1em;">Liên Kết Nhanh</h4>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="margin-bottom: 12px;">
                        <a href="${pageContext.request.contextPath}/" style="color: var(--md-text-muted); text-decoration: none; font-size: 0.875rem; transition: color 0.2s;">Trang chủ</a>
                    </li>
                    <li style="margin-bottom: 12px;">
                        <a href="${pageContext.request.contextPath}/menu" style="color: var(--md-text-muted); text-decoration: none; font-size: 0.875rem; transition: color 0.2s;">Thực đơn</a>
                    </li>
                    <li style="margin-bottom: 12px;">
                        <a href="${pageContext.request.contextPath}/booking" style="color: var(--md-text-muted); text-decoration: none; font-size: 0.875rem; transition: color 0.2s;">Đặt bàn</a>
                    </li>
                    <li style="margin-bottom: 12px;">
                        <a href="${pageContext.request.contextPath}/login" style="color: var(--md-text-muted); text-decoration: none; font-size: 0.875rem; transition: color 0.2s;">Đăng nhập</a>
                    </li>
                </ul>
            </div>
            
            <!-- Column 3: Contact -->
            <div>
                <h4 style="color: var(--md-text); font-weight: 700; margin-bottom: 20px; font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.1em;">Liên Hệ</h4>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="display: flex; align-items: flex-start; gap: 8px; margin-bottom: 12px;">
                        <span class="material-symbols-outlined" style="color: var(--md-primary); font-size: 18px;">location_on</span>
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">Tầng 64, Tòa Landmark, Quận 1, TP.HCM, Việt Nam</span>
                    </li>
                    <li style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px;">
                        <span class="material-symbols-outlined" style="color: var(--md-primary); font-size: 18px;">call</span>
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">+84 909 123 456</span>
                    </li>
                    <li style="display: flex; align-items: center; gap: 8px;">
                        <span class="material-symbols-outlined" style="color: var(--md-primary); font-size: 18px;">mail</span>
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">booking@smartresto.vn</span>
                    </li>
                </ul>
            </div>
            
            <!-- Column 4: Hours -->
            <div>
                <h4 style="color: var(--md-text); font-weight: 700; margin-bottom: 20px; font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.1em;">Giờ Mở Cửa</h4>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">Thứ 2 - Thứ 5</span>
                        <span style="color: var(--md-text); font-size: 0.875rem; font-weight: 600;">10:00 - 23:00</span>
                    </li>
                    <li style="display: flex; justify-content: space-between; margin-bottom: 12px;">
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">Thứ 7 - Chủ Nhật</span>
                        <span style="color: var(--md-text); font-size: 0.875rem; font-weight: 600;">09:00 - 00:00</span>
                    </li>
                </ul>
            </div>
        </div>
        
        <!-- Bottom Bar -->
        <div style="padding-top: 24px; border-top: 1px solid var(--md-border); text-align: center;">
            <p style="color: var(--md-text-muted); font-size: 0.75rem; margin: 0;">
                © 2024 SmartResto. All rights reserved.
            </p>
        </div>
    </div>
</footer>

<style>
    footer a:hover {
        color: var(--md-primary);
    }
</style>

<!-- AI Chatbot - appears on every page -->
<jsp:include page="/views/includes/chatbot.jsp"/>
