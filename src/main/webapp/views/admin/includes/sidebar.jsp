<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Sidebar -->
<aside class="w-64 bg-[#0A0A0A] border-r border-stone-200 dark:border-stone-800 flex flex-col min-h-screen">
    <div class="p-6">
        <!-- Logo -->
        <div class="flex items-center gap-3 mb-10">
            <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-black font-bold text-xl font-display">
                V
            </div>
            <div>
                <h1 class="font-display text-base font-bold leading-none dark:text-stone-100 uppercase tracking-tight">Vesper</h1>
                <p class="text-[9px] tracking-[0.2em] uppercase text-primary mt-1 font-bold">Executive Admin</p>
            </div>
        </div>
        
        <!-- Navigation -->
        <nav class="space-y-6">
            <div>
                <p class="text-[10px] uppercase tracking-widest text-stone-500 mb-3 font-bold">Tổng Quan</p>
                <a class="flex items-center gap-3 px-4 py-2.5 rounded-r-lg ${pageContext.request.requestURI.contains('/admin/home') ? 'sidebar-active text-primary' : 'hover:text-primary transition-colors text-stone-600 dark:text-stone-400'}" href="${pageContext.request.contextPath}/admin/home">
                    <span class="material-icons-round text-xl">dashboard</span>
                    <span class="font-medium text-sm">Dashboard</span>
                </a>
            </div>
            
            <div>
                <p class="text-[10px] uppercase tracking-widest text-stone-500 mb-3 font-bold">Vận Hành</p>
                <div class="space-y-1">
                    <a class="flex items-center gap-3 px-4 py-2 rounded-r-lg ${pageContext.request.requestURI.contains('/admin/booking') ? 'sidebar-active text-primary' : 'hover:text-primary transition-colors text-stone-600 dark:text-stone-400'}" href="${pageContext.request.contextPath}/admin/booking">
                        <span class="material-icons-round text-xl">event_seat</span>
                        <span class="text-sm">Quản lí đặt bàn</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 rounded-r-lg ${pageContext.request.requestURI.contains('/admin/menu') ? 'sidebar-active text-primary' : 'hover:text-primary transition-colors text-stone-600 dark:text-stone-400'}" href="${pageContext.request.contextPath}/admin/menu">
                        <span class="material-icons-round text-xl">restaurant_menu</span>
                        <span class="text-sm">Thực đơn</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 rounded-r-lg ${pageContext.request.requestURI.contains('/admin/inventory') ? 'sidebar-active text-primary' : 'hover:text-primary transition-colors text-stone-600 dark:text-stone-400'}" href="${pageContext.request.contextPath}/admin/inventory">
                        <span class="material-icons-round text-xl">inventory_2</span>
                        <span class="text-sm">Kho &amp; Nguyên liệu</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-2 rounded-r-lg ${pageContext.request.requestURI.contains('/admin/accounts') ? 'sidebar-active text-primary' : 'hover:text-primary transition-colors text-stone-600 dark:text-stone-400'}" href="${pageContext.request.contextPath}/admin/accounts">
                        <span class="material-icons-round text-xl">manage_accounts</span>
                        <span class="text-sm">Quản lí tài khoản</span>
                    </a>
                </div>
            </div>
        </nav>
    </div>
    
    <!-- User Info at Bottom -->
    <div class="mt-auto p-6 border-t border-stone-200 dark:border-stone-800">
        <div class="flex items-center gap-3 mb-4">
            <div class="w-10 h-10 rounded-full bg-stone-200 dark:bg-stone-800 flex items-center justify-center font-bold text-xs text-primary border border-primary/20">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.username}">
                        ${sessionScope.user.username.substring(0, 1).toUpperCase()}${sessionScope.user.username.length() > 1 ? sessionScope.user.username.substring(1, 2).toUpperCase() : ''}
                    </c:when>
                    <c:otherwise>
                        VA
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <p class="text-sm font-semibold dark:text-stone-200">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.username}">
                            ${sessionScope.user.username}
                        </c:when>
                        <c:otherwise>
                            Admin
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="text-[10px] text-stone-500 uppercase tracking-wider">Quản trị viên cấp cao</p>
            </div>
        </div>
        <button onclick="window.location.href='${pageContext.request.contextPath}/logout'" class="w-full flex items-center justify-center gap-2 py-2.5 border border-stone-200 dark:border-stone-800 rounded-lg text-sm font-medium hover:bg-stone-50 dark:hover:bg-stone-900 transition-all">
            <span class="material-icons-round text-sm">logout</span>
            ĐĂNG XUẤT
        </button>
    </div>
</aside>

<style>
    .sidebar-active {
        background: linear-gradient(90deg, rgba(212, 175, 55, 0.15) 0%, rgba(212, 175, 55, 0) 100%);
        border-left: 3px solid #D4AF37;
    }
</style>
