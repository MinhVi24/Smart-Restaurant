<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html class="dark" lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Vesper • Thanh toán</title>
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
      .card { @apply rounded-xl border border-[rgba(212,175,55,.15)] bg-[#141411] p-5; }
      .btn { @apply inline-flex items-center px-3 py-2 rounded-md text-xs tracking-widest uppercase font-semibold; }
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
              class="material-symbols-outlined text-2xl">calendar_today</span><span class="nav-label">Đặt bàn</span></a>
          <a class="nav-item" href="${pageContext.request.contextPath}/staff/orders"><span
              class="material-symbols-outlined text-2xl">restaurant</span><span class="nav-label">Đơn hàng</span></a>
          <a class="nav-item" href="${pageContext.request.contextPath}/staff/tables"><span
              class="material-symbols-outlined text-2xl">grid_view</span><span class="nav-label">Quản lý bàn</span></a>
          <a class="nav-item" href="${pageContext.request.contextPath}/staff/kitchen-board"><span
              class="material-symbols-outlined text-2xl">soup_kitchen</span><span class="nav-label">Bảng bếp</span></a>
          <a class="nav-item active" href="${pageContext.request.contextPath}/staff/payments"><span
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
          <h1 class="font-display text-xs tracking-[0.5em] text-primary/80 uppercase">Thanh toán</h1>
        </header>
        <section class="px-12 pb-12">
          <c:if test="${param.success == 'paid'}">
            <div
              class="mb-4 px-4 py-2 rounded-lg bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 text-sm">
              ✓ Đã xác nhận thanh toán thành công</div>
          </c:if>
          <c:if test="${param.error != null}">
            <div class="mb-4 px-4 py-2 rounded-lg bg-red-500/10 border border-red-500/30 text-red-400 text-sm">✗ Lỗi:
              ${param.error}</div>
          </c:if>
          <c:if test="${empty unpaidOrders}">
            <div class="card">
              <p class="text-slate-400 text-sm">Không có đơn nào chờ thanh toán.</p>
            </div>
          </c:if>
          <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
            <c:forEach var="o" items="${unpaidOrders}">
              <div class="card">
                <div class="flex items-center justify-between mb-3">
                  <span class="text-xs font-semibold tracking-widest uppercase text-slate-300">Đơn #${o.orderId}</span>
                  <span class="text-[10px] text-slate-500">${o.orderTime}</span>
                </div>
                <div class="grid grid-cols-2 gap-1 text-sm mb-3">
                  <div class="text-slate-400">Bàn</div>
                  <div>
                    <c:out value="${o.tableId != null ? o.tableId.tableId : 'N/A'}" />
                  </div>
                  <div class="text-slate-400">Tổng tiền</div>
                  <div class="text-primary font-semibold">
                    <c:choose>
                      <c:when test="${o.totalAmount != null}">${o.totalAmount} ₫</c:when>
                      <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                  </div>
                  <div class="text-slate-400">Thanh toán</div>
                  <div>
                    <c:choose>
                      <c:when test="${o.payments != null}">
                        <span class="px-2 py-0.5 text-[10px] rounded-full
                        ${o.payments.paymentStatus == 'COMPLETED' ? 'bg-emerald-500/20 text-emerald-400' :
                          o.payments.paymentStatus == 'PARTIAL' ? 'bg-yellow-500/20 text-yellow-400' :
                          'bg-slate-500/20 text-slate-400'}">
                          ${o.payments.paymentStatus}
                        </span>
                      </c:when>
                      <c:otherwise><span class="text-slate-500 text-xs">Chưa có</span></c:otherwise>
                    </c:choose>
                  </div>
                </div>
                <!-- Chi tiết món -->
                <c:if test="${not empty o.orderItemsCollection}">
                  <div class="border-t border-[rgba(212,175,55,.1)] pt-2 mt-2 space-y-1">
                    <c:forEach var="item" items="${o.orderItemsCollection}">
                      <div class="flex justify-between text-xs text-slate-400">
                        <span>${item.menuItemId.name}</span>
                        <span>x${item.quantity} • ${item.price}₫</span>
                      </div>
                    </c:forEach>
                  </div>
                </c:if>
                <!-- Nút xác nhận -->
                <form method="post" action="${pageContext.request.contextPath}/staff/payments" class="mt-4">
                  <input type="hidden" name="orderId" value="${o.orderId}" />
                  <button type="submit" class="btn bg-emerald-500 text-black w-full justify-center"
                    onclick="return confirm('Xác nhận đơn #${o.orderId} đã thanh toán?')">
                    <span class="material-symbols-outlined text-sm mr-1">check_circle</span>
                    Xác nhận thanh toán
                  </button>
                </form>
              </div>
            </c:forEach>
          </div>
        </section>
      </main>
    </body>

    </html>