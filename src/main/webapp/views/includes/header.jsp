<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="md-glass" style="position: sticky; top: 0; z-index: 50; border-bottom: 1px solid var(--md-border);">
  <div class="md-container" style="display: flex; align-items: center; justify-content: space-between; height: 72px;">
    
    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; gap: 16px; text-decoration: none; color: inherit;">
      <div style="width: 42px; height: 42px; border-radius: 8px; background: linear-gradient(135deg, #d4af37 0%, #f4e5b8 50%, #d4af37 100%); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(212, 175, 55, 0.3);">
        <span style="font-family: 'Playfair Display', serif; font-size: 24px; font-weight: 700; color: #1a1a1a; font-style: italic;">V</span>
      </div>
      <div style="display: flex; flex-direction: column; line-height: 1.3;">
        <span style="font-family: 'Playfair Display', serif; font-size: 20px; font-weight: 600; letter-spacing: 0.05em; color: var(--md-text);">VESPER</span>
        <span style="font-size: 10px; text-transform: uppercase; letter-spacing: 0.25em; color: var(--md-primary); font-weight: 500;">Fine Dining Experience</span>
      </div>
    </a>

    <!-- Main Navigation -->
    <nav style="display: flex; align-items: center; gap: 40px; font-size: 13px; letter-spacing: 0.08em; font-weight: 500;">
      <a href="${pageContext.request.contextPath}/" 
         style="color: var(--md-text); text-decoration: none; position: relative; transition: all 0.3s; padding: 8px 0;">
        Trang Chủ
      </a>
      <a href="${pageContext.request.contextPath}/menu" 
         style="color: var(--md-text); text-decoration: none; position: relative; transition: all 0.3s; padding: 8px 0;">
        Thực Đơn
      </a>
      <a href="${pageContext.request.contextPath}/booking" 
         style="color: var(--md-text); text-decoration: none; position: relative; transition: all 0.3s; padding: 8px 0;">
        Đặt Bàn
      </a>
      <a href="${pageContext.request.contextPath}/about" 
         style="color: var(--md-text); text-decoration: none; position: relative; transition: all 0.3s; padding: 8px 0;">
        Về Chúng Tôi
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
  nav a {
    opacity: 0.85;
  }
  
  nav a:hover {
    color: var(--md-primary) !important;
    opacity: 1;
  }
  
  nav a::after {
    content: "";
    position: absolute;
    left: 50%;
    bottom: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, var(--md-primary), transparent);
    transition: all 0.3s ease;
    transform: translateX(-50%);
  }
  
  nav a:hover::after {
    width: 100%;
  }
  
  /* User dropdown hover */
  .user-dropdown:hover .user-dropdown-btn {
    border-color: var(--md-border-gold);
    background: rgba(212, 175, 53, 0.08);
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
    background: rgba(212, 175, 53, 0.08);
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