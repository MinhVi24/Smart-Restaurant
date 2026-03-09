<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html class="dark" lang="vi">

    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Vesper • Đặt bàn</title>
      <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
      <link href="https://fonts.googleapis.com" rel="preconnect" />
      <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin />
      <link
        href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Inter:wght@300;400;500;600&display=swap"
        rel="stylesheet" />
      <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
        rel="stylesheet" />
      <script>
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              colors: { primary: "#D4AF37", "background-dark": "#0A0A0A", "gold-muted": "rgba(212,175,55,.15)" },
              fontFamily: { display: ["Cinzel", "serif"], sans: ["Inter", "sans-serif"] }
            }
          }
        };
      </script>
      <style type="text/tailwindcss">
        @layer base { body { @apply bg-background-dark text-slate-200 antialiased; font-family: 'Inter', sans-serif; } }
      .nav-item { @apply flex flex-col items-center justify-center gap-1 w-full h-20 rounded-lg mx-2 my-2 transition hover:bg-white/5; }
      .nav-item.active { @apply bg-primary/10 ring-1 ring-primary/30; }
      .nav-label { @apply text-[10px] uppercase tracking-[0.2em] font-medium text-slate-400 text-center; }
      .card { @apply rounded-xl border border-[rgba(212,175,55,.15)] bg-[#141411] p-6; }
      .btn { @apply inline-flex items-center px-3 py-2 rounded-md text-xs tracking-widest uppercase font-semibold; }
      .btn-primary { @apply bg-[color:var(--tw-color-primary,#D4AF37)] text-black; }
      .btn-success { @apply bg-emerald-500 text-black; }
      .btn-danger { @apply bg-red-600 text-white; }
    </style>
    </head>

    <body class="h-screen flex">
      <aside
        class="w-32 md:w-40 border-r border-[rgba(212,175,55,.3)] flex flex-col items-center bg-background-dark/95 backdrop-blur-2xl">
        <div class="py-10">
          <div class="w-14 h-14 border-2 border-primary/40 rounded-full flex items-center justify-center">
            <span class="font-display font-bold text-primary text-2xl">V</span>
          </div>
        </div>
        <nav class="flex-1 flex flex-col w-full overflow-y-hidden">
          <a class="nav-item active" href="${pageContext.request.contextPath}/staff/bookings">
            <span class="material-symbols-outlined text-2xl">calendar_today</span>
            <span class="nav-label">Đặt bàn</span>
          </a>
          <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/orders">
            <span class="material-symbols-outlined text-2xl">restaurant</span>
            <span class="nav-label">Món đang chế biến</span>
          </a>
          <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/tables">
            <span class="material-symbols-outlined text-2xl">grid_view</span>
            <span class="nav-label">Quản lý bàn</span>
          </a>
          <a class="nav-item opacity-80 hover:opacity-100"
            href="${pageContext.request.contextPath}/staff/kitchen-board">
            <span class="material-symbols-outlined text-2xl">soup_kitchen</span>
            <span class="nav-label">Bảng bếp</span>
          </a>
          <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/payments">
            <span class="material-symbols-outlined text-2xl">payments</span><span class="nav-label">Thanh toán</span>
          </a>
          <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/action-log">
            <span class="material-symbols-outlined text-2xl">history</span><span class="nav-label">Lịch sử</span>
          </a>
          <a class="nav-item opacity-60 hover:opacity-100 mb-4" href="${pageContext.request.contextPath}/logout">
            <span class="material-symbols-outlined text-lg">logout</span>
            <span class="nav-label !text-[8px]">Đăng xuất</span>
          </a>
        </nav>
      </aside>
      <main class="flex-1 flex flex-col overflow-y-auto">
        <header class="px-12 py-8 flex items-center justify-between">
          <div>
            <h1 class="font-display text-xs tracking-[0.5em] text-primary/80 uppercase">Đặt bàn</h1>
          </div>
          <a href="${pageContext.request.contextPath}/logout" class="btn bg-red-600 text-white">Đăng xuất</a>
        </header>
        <section class="px-12 pb-12">
          <div class="mb-6 flex items-center gap-3">
            <span class="text-xs uppercase tracking-[0.3em] text-slate-400">Trạng thái</span>
            <span
              class="px-2 py-1 rounded-full border border-[rgba(212,175,55,.3)] text-[10px] uppercase tracking-[0.2em]">${status}</span>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="r" items="${reservations}">
              <div class="card">
                <div class="grid grid-cols-2 gap-1 text-sm">
                  <div class="text-slate-400">ID</div>
                  <div>${r.reservationId}</div>
                  <div class="text-slate-400">Giờ hẹn</div>
                  <div>${r.reservationTime}</div>
                  <div class="text-slate-400">Khách</div>
                  <div>
                    <c:out value="${r.customerId != null ? r.customerId.customerId : 'N/A'}" />
                  </div>
                  <div class="text-slate-400">Bàn</div>
                  <div>
                    <c:out value="${r.tableId != null ? r.tableId.tableId : 'N/A'}" />
                  </div>
                </div>
                <p class="text-[12px] text-slate-400 mt-2">Khách phải có mặt trong 15 phút từ giờ hẹn</p>
                <div class="flex gap-2 mt-3">
                  <button class="btn btn-success" onclick="quickPost('confirm','${r.reservationId}')">Xác nhận</button>
                  <button class="btn btn-danger" onclick="cancelWithReason('${r.reservationId}')">Hủy</button>
                  <button class="btn btn-primary" onclick="quickPost('no_show','${r.reservationId}')">Không đến</button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/staff/bookings"
                  class="grid grid-cols-1 sm:grid-cols-3 gap-2 mt-3">
                  <input type="hidden" name="action" value="update" />
                  <input type="hidden" name="id" value="${r.reservationId}" />
                  <input type="datetime-local" name="reservationTime"
                    class="bg-[#0f0f0e] border border-[rgba(212,175,55,.2)] rounded px-2 py-2 text-sm" />
                  <input type="number" name="tableId" placeholder="Mã bàn"
                    class="bg-[#0f0f0e] border border-[rgba(212,175,55,.2)] rounded px-2 py-2 text-sm" />
                  <button class="btn btn-primary" type="submit">Cập nhật</button>
                </form>
              </div>
            </c:forEach>
          </div>
        </section>
      </main>
      <script>
        function quickPost(action, id) {
          const f = document.createElement('form'); f.method = 'POST'; f.action = '';
          [['action', action], ['id', id]].forEach(([k, v]) => { const i = document.createElement('input'); i.type = 'hidden'; i.name = k; i.value = v; f.appendChild(i); });
          document.body.appendChild(f); f.submit();
        }
        function cancelWithReason(id) {
          const reason = prompt('Lý do hủy đặt bàn:'); if (reason === null) return;
          const f = document.createElement('form'); f.method = 'POST'; f.action = '';
          [['action', 'cancel'], ['id', id], ['reason', reason]].forEach(([k, v]) => { const i = document.createElement('input'); i.type = 'hidden'; i.name = k; i.value = v; f.appendChild(i); });
          document.body.appendChild(f); f.submit();
        }
      </script>
    </body>

    </html>