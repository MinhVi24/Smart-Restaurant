<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <!DOCTYPE html>
      <html class="dark" lang="vi">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Vesper • Bảng bếp</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin />
        <link
          href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Inter:wght@300;400;500;600&display=swap"
          rel="stylesheet" />
        <link
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet" />
        <meta http-equiv="refresh" content="30">
        <script>tailwind.config = { darkMode: "class", theme: { extend: { colors: { primary: "#D4AF37", "background-dark": "#0A0A0A", "gold-muted": "rgba(212,175,55,.15)" }, fontFamily: { display: ["Cinzel", "serif"], sans: ["Inter", "sans-serif"] } } } };</script>
        <style type="text/tailwindcss">
          @layer base { body { @apply bg-background-dark text-slate-200 antialiased; font-family: 'Inter', sans-serif; } }
      .nav-item { @apply flex flex-col items-center justify-center gap-1 w-full h-20 rounded-lg mx-2 my-2 transition hover:bg-white/5; }
      .nav-item.active { @apply bg-primary/10 ring-1 ring-primary/30; }
      .nav-label { @apply text-[10px] uppercase tracking-[0.2em] font-medium text-slate-400 text-center; }
      .card { @apply rounded-xl border border-[rgba(212,175,55,.15)] bg-[#141411] p-5; }
    </style>
      </head>

      <body class="h-screen flex">
        <aside
          class="w-32 md:w-40 border-r border-[rgba(212,175,55,.3)] flex flex-col items-center bg-background-dark/95 backdrop-blur-2xl">
          <div class="py-10">
            <div class="w-14 h-14 border-2 border-primary/40 rounded-full flex items-center justify-center"><span
                class="font-display font-bold text-primary text-2xl">V</span></div>
          </div>
          <nav class="flex-1 flex flex-col w-full overflow-y-hidden">
            <a class="nav-item" href="${pageContext.request.contextPath}/staff/bookings"><span
                class="material-symbols-outlined text-2xl">calendar_today</span><span class="nav-label">Đặt
                bàn</span></a>
            <a class="nav-item" href="${pageContext.request.contextPath}/staff/orders"><span
                class="material-symbols-outlined text-2xl">restaurant</span><span class="nav-label">Đơn hàng</span></a>
            <a class="nav-item" href="${pageContext.request.contextPath}/staff/tables"><span
                class="material-symbols-outlined text-2xl">grid_view</span><span class="nav-label">Quản lý
                bàn</span></a>
            <a class="nav-item active" href="${pageContext.request.contextPath}/staff/kitchen-board"><span
                class="material-symbols-outlined text-2xl">soup_kitchen</span><span class="nav-label">Bảng
                bếp</span></a>
            <a class="nav-item" href="${pageContext.request.contextPath}/staff/payments"><span
                class="material-symbols-outlined text-2xl">payments</span><span class="nav-label">Thanh toán</span></a>
            <a class="nav-item" href="${pageContext.request.contextPath}/staff/action-log"><span
                class="material-symbols-outlined text-2xl">history</span><span class="nav-label">Lịch sử</span></a>
            <a class="nav-item opacity-60 hover:opacity-100 mb-4" href="${pageContext.request.contextPath}/logout"><span
                class="material-symbols-outlined text-lg">logout</span><span class="nav-label !text-[8px]">Đăng
                xuất</span></a>
          </nav>
        </aside>
        <main class="flex-1 flex flex-col overflow-y-auto">
          <header class="px-12 py-8 flex items-center justify-between">
            <h1 class="font-display text-xs tracking-[0.5em] text-primary/80 uppercase">Bảng bếp</h1>
            <span class="text-[10px] text-slate-500 uppercase tracking-widest">Auto-refresh 30s</span>
          </header>
          <section class="px-12 pb-12">
            <c:if test="${empty openOrders}">
              <div class="card">
                <p class="text-slate-400 text-sm">Không có đơn nào đang chế biến.</p>
              </div>
            </c:if>
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
              <c:forEach var="o" items="${openOrders}">
                <c:set var="isVip"
                  value="${o.tableId != null && o.tableId.area != null && o.tableId.area.contains('VIP')}" />
                <div class="card" data-order-time="${o.orderTime}" id="order-card-${o.orderId}">
                  <div class="flex items-center justify-between mb-3">
                    <span
                      class="text-xs font-semibold tracking-widest uppercase ${isVip ? 'text-primary' : 'text-slate-300'}">
                      Đơn #${o.orderId}
                      <c:if test="${isVip}">
                        <span class="ml-1 px-1.5 py-0.5 bg-primary/20 text-primary rounded text-[9px]">VIP</span>
                      </c:if>
                    </span>
                    <span class="text-[10px] text-slate-500">${o.orderTime}</span>
                  </div>
                  <c:if test="${o.tableId != null}">
                    <div class="text-[11px] text-slate-400 mb-2">Bàn ${o.tableId.tableId} • ${o.tableId.area}</div>
                  </c:if>
                  <div class="space-y-1">
                    <c:forEach var="item" items="${o.orderItemsCollection}">
                      <div class="flex justify-between text-sm ${isVip ? 'text-primary' : 'text-slate-200'}">
                        <span>${item.menuItemId.name}</span>
                        <span class="text-slate-400">x${item.quantity}</span>
                      </div>
                    </c:forEach>
                    <c:if test="${empty o.orderItemsCollection}">
                      <p class="text-slate-500 text-xs italic">Chưa có món</p>
                    </c:if>
                  </div>
                </div>
              </c:forEach>
            </div>
          </section>
        </main>
        <script>
          (function () {
            const now = Date.now();
            document.querySelectorAll('[data-order-time]').forEach(card => {
              const t = card.getAttribute('data-order-time');
              if (!t) return;
              const ts = Date.parse(t);
              if (!isNaN(ts) && (now - ts) > 600000) {
                card.style.borderColor = '#ef4444';
                card.style.boxShadow = '0 0 0 1px rgba(239,68,68,.5) inset';
              }
            });
          })();
        </script>
      </body>

      </html>