<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="md-glass" style="position: sticky; top: 0; z-index: 50; border-bottom: 1px solid var(--md-border);">
  <div class="md-container" style="display: flex; align-items: center; justify-content: space-between; height: 72px;">
    
    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; gap: 12px; text-decoration: none; color: inherit;">
      <div style="width: 36px; height: 36px; border-radius: 11px; background: radial-gradient(circle at 30% 0, #fff8da, #f0cf57 28%, #b48b20 65%, #765712 100%); color: #111; display: grid; place-items: center; font-weight: 800; letter-spacing: 0.16em; font-size: 13px; box-shadow: var(--md-glow);">
        V
      </div>
      <div style="display: flex; flex-direction: column; line-height: 1.1;">
        <span style="font-family: var(--md-font-serif); text-transform: uppercase; letter-spacing: 0.22em; font-size: 13px;">VESPER</span>
        <span style="font-size: 9px; text-transform: uppercase; letter-spacing: 0.32em; color: var(--md-text-muted);">Fine Dining Restaurant</span>
      </div>
    </a>

    <!-- Main Navigation -->
    <nav style="display: flex; align-items: center; gap: 24px; font-size: 11px; letter-spacing: 0.22em; text-transform: uppercase;">
      <a href="${pageContext.request.contextPath}/" 
         style="color: rgba(255, 255, 255, 0.72); text-decoration: none; position: relative; transition: color 0.2s;">
        Trang chủ
      </a>
      <a href="${pageContext.request.contextPath}/menu" 
         style="color: rgba(255, 255, 255, 0.72); text-decoration: none; position: relative; transition: color 0.2s;">
        Thực đơn
      </a>
      <a href="${pageContext.request.contextPath}/booking" 
         style="color: rgba(255, 255, 255, 0.72); text-decoration: none; position: relative; transition: color 0.2s;">
        Đặt bàn
      </a>
      <a href="${pageContext.request.contextPath}/about" 
         style="color: rgba(255, 255, 255, 0.72); text-decoration: none; position: relative; transition: color 0.2s;">
        Về chúng tôi
      </a>
    </nav>

    <!-- Auth Area -->
    <div style="display: flex; align-items: center; gap: 16px;">
      <c:choose>
        <c:when test="${not empty sessionScope.loggedInUser}">
          <!-- User Dropdown -->
          <div class="user-dropdown" style="position: relative;">
            <button type="button" class="user-dropdown-btn" 
                    style="display: flex; align-items: center; gap: 8px; padding: 8px 12px; border-radius: 999px; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.15); cursor: pointer; transition: all 0.2s;">
              <div style="width: 32px; height: 32px; border-radius: 50%; background: linear-gradient(135deg, var(--md-primary) 0%, var(--md-primary-dark) 100%); display: flex; align-items: center; justify-content: center; color: #18140c; font-weight: 700; font-size: 14px;">
                ${sessionScope.loggedInUser.username.substring(0, 1).toUpperCase()}
              </div>
              <div style="display: flex; flex-direction: column; text-align: left;">
                <span style="font-size: 11px; font-weight: 600; color: var(--md-text);">
                  ${sessionScope.loggedInUser.username}
                </span>
                <span style="font-size: 9px; color: var(--md-primary); text-transform: uppercase; letter-spacing: 0.24em;">
                  <c:choose>
                    <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">Quản trị viên</c:when>
                    <c:when test="${sessionScope.loggedInUser.role == 'STAFF'}">Nhân viên</c:when>
                    <c:otherwise>Thành viên vàng</c:otherwise>
                  </c:choose>
                </span>
              </div>
              <span class="material-symbols-outlined" style="font-size: 18px; color: var(--md-text-muted);">expand_more</span>
            </button>

            <!-- Dropdown Menu -->
            <div class="user-dropdown-menu" 
                 style="position: absolute; right: 0; top: calc(100% + 8px); width: 280px; background: rgba(23, 22, 17, 0.98); border: 1px solid var(--md-border-gold); border-radius: var(--md-radius-lg); box-shadow: var(--md-shadow); opacity: 0; visibility: hidden; transform: translateY(-10px); transition: all 0.3s ease; backdrop-filter: blur(14px);">
              
              <!-- User Info -->
              <div style="padding: 16px; border-bottom: 1px solid var(--md-border);">
                <p style="font-size: 11px; text-transform: uppercase; letter-spacing: 0.18em; color: var(--md-text-muted); margin-bottom: 8px;">
                  <c:choose>
                    <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">Quản trị viên</c:when>
                    <c:when test="${sessionScope.loggedInUser.role == 'STAFF'}">Nhân viên</c:when>
                    <c:otherwise>Thành viên</c:otherwise>
                  </c:choose>
                </p>
                <p style="font-weight: 600; margin-bottom: 4px;">${sessionScope.loggedInUser.username}</p>
                <p style="font-size: 12px; color: var(--md-text-muted);">${sessionScope.loggedInUser.email}</p>
                <c:if test="${sessionScope.loggedInUser.role == 'CUSTOMER'}">
                  <div style="display: flex; align-items: center; gap: 8px; margin-top: 12px; padding: 8px; background: rgba(212, 175, 53, 0.1); border-radius: 8px; border: 1px solid var(--md-border-gold);">
                    <span class="material-symbols-outlined" style="font-size: 20px; color: var(--md-primary);">stars</span>
                    <div>
                      <p style="font-size: 10px; color: var(--md-text-muted);">Điểm tích lũy</p>
                      <p style="font-size: 16px; font-weight: 700; color: var(--md-primary);">
                        <c:choose>
                          <c:when test="${not empty sessionScope.customerPoints}">
                            ${sessionScope.customerPoints} điểm
                          </c:when>
                          <c:otherwise>
                            0 điểm
                          </c:otherwise>
                        </c:choose>
                      </p>
                    </div>
                  </div>
                </c:if>
              </div>

              <!-- Menu Items -->
              <nav style="padding: 8px 0;">
                <a href="${pageContext.request.contextPath}/profile" 
                   style="display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--md-text); text-decoration: none; transition: background 0.2s;">
                  <span class="material-symbols-outlined" style="font-size: 20px; color: var(--md-primary);">person</span>
                  <span style="font-size: 13px;">Hồ sơ cá nhân</span>
                </a>
                <a href="${pageContext.request.contextPath}/bookings/history" 
                   style="display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--md-text); text-decoration: none; transition: background 0.2s;">
                  <span class="material-symbols-outlined" style="font-size: 20px; color: var(--md-primary);">event</span>
                  <span style="font-size: 13px;">Lịch sử đặt bàn</span>
                </a>
                <a href="${pageContext.request.contextPath}/orders/my" 
                   style="display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--md-text); text-decoration: none; transition: background 0.2s;">
                  <span class="material-symbols-outlined" style="font-size: 20px; color: var(--md-primary);">receipt_long</span>
                  <span style="font-size: 13px;">Đơn hàng của tôi</span>
                </a>
                
                <c:if test="${sessionScope.loggedInUser.role == 'ADMIN' || sessionScope.loggedInUser.role == 'STAFF'}">
                  <div style="height: 1px; background: var(--md-border); margin: 8px 0;"></div>
                  <a href="${pageContext.request.contextPath}/admin/dashboard" 
                     style="display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--md-primary); text-decoration: none; transition: background 0.2s;">
                    <span class="material-symbols-outlined" style="font-size: 20px;">dashboard</span>
                    <span style="font-size: 13px; font-weight: 600;">Quản trị hệ thống</span>
                  </a>
                </c:if>
                
                <div style="height: 1px; background: var(--md-border); margin: 8px 0;"></div>
                <a href="${pageContext.request.contextPath}/logout" 
                   style="display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--md-error); text-decoration: none; transition: background 0.2s;">
                  <span class="material-symbols-outlined" style="font-size: 20px;">logout</span>
                  <span style="font-size: 13px;">Đăng xuất</span>
                </a>
              </nav>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <!-- Login/Register Buttons -->
          <a href="${pageContext.request.contextPath}/login" class="md-btn md-btn-ghost" style="text-decoration: none;">
            Đăng nhập
          </a>
          <a href="${pageContext.request.contextPath}/register" class="md-btn md-btn-primary" style="text-decoration: none;">
            Đăng ký
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

<style>
  /* Hover effects for navigation */
  nav a:hover {
    color: var(--md-primary) !important;
  }
  
  nav a::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -6px;
    width: 0;
    height: 1px;
    background: var(--md-primary);
    transition: width 0.2s ease-out;
  }
  
  nav a:hover::after {
    width: 100%;
  }
  
  /* User dropdown hover */
  .user-dropdown:hover .user-dropdown-btn {
    border-color: var(--md-border-gold);
    background: rgba(212, 175, 53, 0.05);
  }
  
  .user-dropdown:hover .user-dropdown-menu,
  .user-dropdown-menu:hover {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
    pointer-events: auto;
  }
  
  /* Dropdown menu item hover */
  .user-dropdown-menu nav a:hover {
    background: rgba(255, 255, 255, 0.05);
  }
  
  .user-dropdown-menu nav a:hover span:first-child {
    transform: scale(1.1);
  }
</style>

<script>
// Keep dropdown open when hovering over menu
document.addEventListener('DOMContentLoaded', function() {
    const dropdown = document.querySelector('.user-dropdown');
    const menu = document.querySelector('.user-dropdown-menu');
    
    if (dropdown && menu) {
        let timeout;
        
        dropdown.addEventListener('mouseenter', function() {
            clearTimeout(timeout);
            menu.style.opacity = '1';
            menu.style.visibility = 'visible';
            menu.style.transform = 'translateY(0)';
            menu.style.pointerEvents = 'auto';
        });
        
        dropdown.addEventListener('mouseleave', function() {
            timeout = setTimeout(function() {
                menu.style.opacity = '0';
                menu.style.visibility = 'hidden';
                menu.style.transform = 'translateY(-10px)';
                menu.style.pointerEvents = 'none';
            }, 200);
        });
        
        menu.addEventListener('mouseenter', function() {
            clearTimeout(timeout);
        });
        
        menu.addEventListener('mouseleave', function() {
            menu.style.opacity = '0';
            menu.style.visibility = 'hidden';
            menu.style.transform = 'translateY(-10px)';
            menu.style.pointerEvents = 'none';
        });
    }
});
</script>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">