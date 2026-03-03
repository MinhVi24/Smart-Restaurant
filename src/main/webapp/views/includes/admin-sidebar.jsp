<style>
    .admin-sidebar {
        width: 280px;
        background: linear-gradient(180deg, #1a1a1a 0%, #0d0d0d 100%);
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        display: flex;
        flex-direction: column;
        border-right: 1px solid #2a2a2a;
        z-index: 1000;
    }

    .sidebar-logo {
        padding: 32px 24px;
        border-bottom: 1px solid #2a2a2a;
    }

    .logo-container {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo-icon {
        width: 48px;
        height: 48px;
        background: #D4AF37;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }

    .logo-text h1 {
        font-family: 'Playfair Display', serif;
        font-size: 20px;
        font-weight: 600;
        color: #D4AF37;
        margin: 0;
        line-height: 1.2;
    }

    .logo-text p {
        font-size: 9px;
        color: #666;
        margin: 2px 0 0 0;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        font-weight: 600;
    }

    .sidebar-nav {
        flex: 1;
        padding: 24px 16px;
        overflow-y: auto;
    }

    .nav-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px 16px;
        color: #666;
        text-decoration: none;
        border-radius: 8px;
        margin-bottom: 8px;
        transition: all 0.3s;
        font-size: 14px;
        font-weight: 500;
    }

    .nav-item:hover {
        background: rgba(212, 175, 55, 0.1);
        color: #D4AF37;
    }

    .nav-item.active {
        background: rgba(212, 175, 55, 0.15);
        color: #D4AF37;
        border-left: 3px solid #D4AF37;
        padding-left: 13px;
    }

    .nav-item svg {
        width: 20px;
        height: 20px;
        flex-shrink: 0;
    }

    .sidebar-footer {
        padding: 24px;
        border-top: 1px solid #2a2a2a;
    }

    .upgrade-card {
        background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
        border: 1px solid #3a3a3a;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
    }

    .upgrade-label {
        font-size: 11px;
        color: #666;
        margin-bottom: 12px;
        font-weight: 600;
    }

    .upgrade-btn {
        width: 100%;
        padding: 12px;
        background: #D4AF37;
        color: #1a1a1a;
        border: none;
        border-radius: 8px;
        font-weight: 700;
        font-size: 13px;
        cursor: pointer;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s;
    }

    .upgrade-btn:hover {
        background: #f0c14b;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(212, 175, 55, 0.4);
    }

    @media (max-width: 968px) {
        .admin-sidebar {
            width: 70px;
        }

        .logo-text,
        .nav-item span,
        .upgrade-card {
            display: none;
        }

        .sidebar-logo {
            padding: 24px 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            font-size: 20px;
        }

        .nav-item {
            justify-content: center;
            padding: 12px;
        }
    }
</style>

<aside class="admin-sidebar">
    <div class="sidebar-logo">
        <div class="logo-container">
            <div class="logo-icon">🍴</div>
            <div class="logo-text">
                <h1>Maison D'Or</h1>
                <p>Elite Dining Management</p>
            </div>
        </div>
    </div>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/home" class="nav-item">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"/>
            </svg>
            <span>Tổng quan</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/food" class="nav-item active">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 4.804A7.968 7.968 0 005.5 4c-1.255 0-2.443.29-3.5.804v10A7.969 7.969 0 015.5 14c1.669 0 3.218.51 4.5 1.385A7.962 7.962 0 0114.5 14c1.255 0 2.443.29 3.5.804v-10A7.968 7.968 0 0014.5 4c-1.255 0-2.443.29-3.5.804V12a1 1 0 11-2 0V4.804z"/>
            </svg>
            <span>Thực đơn & Món ăn</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
            </svg>
            <span>Đơn hàng</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"/>
            </svg>
            <span>Báo cáo & Tài chính</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/staff" class="nav-item">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
            </svg>
            <span>Nhân viên</span>
        </a>

        <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item">
            <svg fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"/>
            </svg>
            <span>Cài đặt hệ thống</span>
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="upgrade-card">
            <p class="upgrade-label">Gói hiện tại: Platinum</p>
            <button class="upgrade-btn">Nâng cấp gói</button>
        </div>
    </div>
</aside>
