<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Sidebar -->
<aside class="w-64 bg-black border-r border-stone-900 flex flex-col min-h-screen">
    <div class="p-6">
        <!-- Logo -->
        <div class="flex items-center gap-3 mb-10">
            <div class="w-14 h-14 bg-primary rounded-2xl flex items-center justify-center text-black font-bold text-3xl font-display shadow-lg">
                V
            </div>
            <div>
                <h1 class="font-display text-xl font-bold leading-none text-white uppercase tracking-tight">Vesper</h1>
                <p class="text-[10px] tracking-[0.25em] uppercase text-primary mt-1 font-bold">Executive Admin</p>
            </div>
        </div>
        
        <!-- Navigation -->
        <nav class="space-y-6">
            <div>
                <p class="text-[11px] uppercase tracking-widest text-stone-600 mb-4 font-bold">TỔNG QUAN</p>
                <a class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${pageContext.request.requestURI.contains('/admin/home') ? 'sidebar-active text-primary font-semibold' : 'hover:text-stone-300 text-stone-500'}" href="${pageContext.request.contextPath}/admin/home">
                    <span class="material-icons-round text-xl">dashboard</span>
                    <span class="text-base">Dashboard</span>
                </a>
            </div>
            
            <div>
                <p class="text-[11px] uppercase tracking-widest text-stone-600 mb-4 font-bold">VẬN HÀNH</p>
                <div class="space-y-2">
                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${pageContext.request.requestURI.contains('/admin/booking') ? 'sidebar-active text-primary font-semibold' : 'hover:text-stone-300 text-stone-500'}" href="${pageContext.request.contextPath}/admin/booking">
                        <span class="material-icons-round text-xl">event_seat</span>
                        <span class="text-base">Quản lí đặt bàn</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${pageContext.request.requestURI.contains('/admin/menu') ? 'sidebar-active text-primary font-semibold' : 'hover:text-stone-300 text-stone-500'}" href="${pageContext.request.contextPath}/admin/menu">
                        <span class="material-icons-round text-xl">restaurant_menu</span>
                        <span class="text-base">Thực đơn</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${pageContext.request.requestURI.contains('/admin/inventory') ? 'sidebar-active text-primary font-semibold' : 'hover:text-stone-300 text-stone-500'}" href="${pageContext.request.contextPath}/admin/inventory">
                        <span class="material-icons-round text-xl">inventory_2</span>
                        <span class="text-base">Kho &amp; Nguyên liệu</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${pageContext.request.requestURI.contains('/admin/accounts') ? 'sidebar-active text-primary font-semibold' : 'hover:text-stone-300 text-stone-500'}" href="${pageContext.request.contextPath}/admin/accounts">
                        <span class="material-icons-round text-xl">manage_accounts</span>
                        <span class="text-base">Quản lí tài khoản</span>
                    </a>
                </div>
            </div>
        </nav>
    </div>
    
    <!-- User Info at Bottom -->
    <div class="mt-auto p-6 border-t border-stone-900">
        <div class="flex items-center gap-3 mb-4">
            <div class="w-12 h-12 rounded-full bg-stone-800 flex items-center justify-center font-bold text-base text-primary border-2 border-stone-700">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.username}">
                        ${sessionScope.user.username.substring(0, 1).toUpperCase()}${sessionScope.user.username.length() > 1 ? sessionScope.user.username.substring(1, 2).toUpperCase() : 'A'}
                    </c:when>
                    <c:otherwise>
                        VA
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <p class="text-base font-bold text-white">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.username}">
                            ${sessionScope.user.username}
                        </c:when>
                        <c:otherwise>
                            Admin
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="text-[10px] text-stone-500 uppercase tracking-widest">Quản trị viên cấp cao</p>
            </div>
        </div>
        <button onclick="window.location.href='${pageContext.request.contextPath}/logout'" class="w-full flex items-center justify-center gap-2 py-3 border-2 border-stone-800 rounded-xl text-sm font-bold text-stone-300 hover:bg-stone-900 hover:border-stone-700 transition-all uppercase tracking-wider">
            <span class="material-icons-round text-lg">logout</span>
            Đăng xuất
        </button>
    </div>
</aside>

<style>
    .sidebar-active {
        background: linear-gradient(90deg, rgba(212, 175, 55, 0.3) 0%, rgba(212, 175, 55, 0.1) 100%);
        border-left: 4px solid #D4AF37;
        padding-left: calc(1rem - 4px);
        box-shadow: 0 0 20px rgba(212, 175, 55, 0.2);
    }
</style>
