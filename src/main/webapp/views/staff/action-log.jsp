<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html class="dark" lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Vesper • Lịch sử thao tác</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
                <link href="https://fonts.googleapis.com" rel="preconnect" />
                <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin />
                <link
                    href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                    rel="stylesheet" />
                <script>tailwind.config = { darkMode: "class", theme: { extend: { colors: { primary: "#D4AF37", "background-dark": "#0A0A0A", "gold-muted": "rgba(212,175,55,.15)" }, fontFamily: { display: ["Cinzel", "serif"], sans: ["Inter", "sans-serif"] } } } };</script>
                <style type="text/tailwindcss">
                    @layer base { body { @apply bg-background-dark text-slate-200 antialiased; font-family: 'Inter', sans-serif; } }
      .nav-item { @apply flex flex-col items-center justify-center gap-1 w-full h-20 rounded-lg mx-2 my-2 transition hover:bg-white/5; }
      .nav-item.active { @apply bg-primary/10 ring-1 ring-primary/30; }
      .nav-label { @apply text-[10px] uppercase tracking-[0.2em] font-medium text-slate-400 text-center; }
      .table-v { @apply w-full text-sm border border-[rgba(212,175,55,.15)] rounded-lg overflow-hidden; }
      .table-v thead { @apply bg-[#0d0d0c] text-slate-400; }
      .table-v th, .table-v td { @apply border-t border-[rgba(212,175,55,.15)] px-4 py-3; }
    </style>
            </head>

            <body class="h-screen flex">
                <aside
                    class="w-32 md:w-40 border-r border-[rgba(212,175,55,.3)] flex flex-col items-center bg-background-dark/95 backdrop-blur-2xl">
                    <div class="py-10">
                        <div class="w-14 h-14 border-2 border-primary/40 rounded-full flex items-center justify-center">
                            <span class="font-display font-bold text-primary text-2xl">V</span></div>
                    </div>
                    <nav class="flex-1 flex flex-col w-full overflow-y-hidden">
                        <a class="nav-item" href="${pageContext.request.contextPath}/staff/bookings"><span
                                class="material-symbols-outlined text-2xl">calendar_today</span><span
                                class="nav-label">Đặt bàn</span></a>
                        <a class="nav-item" href="${pageContext.request.contextPath}/staff/orders"><span
                                class="material-symbols-outlined text-2xl">restaurant</span><span class="nav-label">Đơn
                                hàng</span></a>
                        <a class="nav-item" href="${pageContext.request.contextPath}/staff/tables"><span
                                class="material-symbols-outlined text-2xl">grid_view</span><span class="nav-label">Quản
                                lý bàn</span></a>
                        <a class="nav-item" href="${pageContext.request.contextPath}/staff/kitchen-board"><span
                                class="material-symbols-outlined text-2xl">soup_kitchen</span><span
                                class="nav-label">Bảng bếp</span></a>
                        <a class="nav-item" href="${pageContext.request.contextPath}/staff/payments"><span
                                class="material-symbols-outlined text-2xl">payments</span><span class="nav-label">Thanh
                                toán</span></a>
                        <a class="nav-item active" href="${pageContext.request.contextPath}/staff/action-log"><span
                                class="material-symbols-outlined text-2xl">history</span><span class="nav-label">Lịch
                                sử</span></a>
                        <a class="nav-item opacity-60 hover:opacity-100 mb-4"
                            href="${pageContext.request.contextPath}/logout"><span
                                class="material-symbols-outlined text-lg">logout</span><span
                                class="nav-label !text-[8px]">Đăng xuất</span></a>
                    </nav>
                </aside>
                <main class="flex-1 flex flex-col overflow-y-auto">
                    <header class="px-12 py-8 flex items-center justify-between">
                        <h1 class="font-display text-xs tracking-[0.5em] text-primary/80 uppercase">Lịch sử thao tác
                        </h1>
                        <span class="text-[10px] text-slate-500 uppercase tracking-widest">Tối đa 200 bản ghi gần
                            nhất</span>
                    </header>
                    <section class="px-12 pb-12">
                        <c:if test="${empty actionLogs}">
                            <div class="rounded-xl border border-[rgba(212,175,55,.15)] bg-[#141411] p-6">
                                <p class="text-slate-400 text-sm">Chưa có thao tác nào được ghi lại. Các thao tác sẽ tự
                                    động ghi khi staff xác nhận đặt bàn, hủy đơn, thanh toán, v.v.</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty actionLogs}">
                            <div class="overflow-auto">
                                <table class="table-v">
                                    <thead>
                                        <tr>
                                            <th class="text-left">Thời gian</th>
                                            <th class="text-left">Nhân viên</th>
                                            <th class="text-left">Hành động</th>
                                            <th class="text-left">Đối tượng</th>
                                            <th class="text-left">ID</th>
                                            <th class="text-left">Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="log" items="${actionLogs}">
                                            <tr class="hover:bg-white/[0.02]">
                                                <td class="text-slate-400 text-xs whitespace-nowrap">${log.timestamp}
                                                </td>
                                                <td class="text-primary text-xs">${log.staffName}</td>
                                                <td>
                                                    <span class="px-2 py-0.5 text-[10px] rounded-full uppercase tracking-wider
                        ${log.actionType.contains('HỦY') || log.actionType.contains('CANCEL') ? 'bg-red-500/20 text-red-400' :
                          log.actionType.contains('XÁC NHẬN') || log.actionType.contains('CONFIRM') ? 'bg-emerald-500/20 text-emerald-400' :
                          'bg-blue-500/20 text-blue-400'}">
                                                        ${log.actionType}
                                                    </span>
                                                </td>
                                                <td class="text-xs text-slate-400">${log.targetType}</td>
                                                <td class="text-xs">#${log.targetId}</td>
                                                <td class="text-xs text-slate-300">${log.details}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </section>
                </main>
            </body>

            </html>