<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html class="dark" lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Vesper • Quản lý bàn</title>
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
      .table-v th, .table-v td { @apply border-t border-[rgba(212,175,55,.15)] px-3 py-2; }
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
              class="material-symbols-outlined text-2xl">restaurant</span><span class="nav-label">Món đang chế
              biến</span></a>
          <a class="nav-item active" href="${pageContext.request.contextPath}/staff/tables"><span
              class="material-symbols-outlined text-2xl">grid_view</span><span class="nav-label">Quản lý bàn</span></a>
          <a class="nav-item" href="${pageContext.request.contextPath}/staff/kitchen-board"><span
              class="material-symbols-outlined text-2xl">soup_kitchen</span><span class="nav-label">Bảng bếp</span></a>
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
          <h1 class="font-display text-xs tracking-[0.5em] text-primary/80 uppercase">Quản lý bàn</h1>
        </header>
        <section class="px-12 pb-12">
          <form method="get" action="${pageContext.request.contextPath}/staff/tables"
            class="flex flex-wrap gap-2 items-center mb-4">
            <select name="area"
              class="bg-[#0f0f0e] border border-[rgba(212,175,55,.2)] rounded px-3 py-2 text-sm min-w-[160px]">
              <option value="">-- Tất cả khu vực --</option>
              <c:forEach var="a" items="${areas}">
                <option value="${a}" ${a==selectedArea ? 'selected' : '' }>${a}</option>
              </c:forEach>
            </select>
            <select name="status"
              class="bg-[#0f0f0e] border border-[rgba(212,175,55,.2)] rounded px-3 py-2 text-sm min-w-[160px]">
              <option value="">-- Tất cả trạng thái --</option>
              <option value="AVAILABLE" ${selectedStatus=='AVAILABLE' ? 'selected' : '' }>🟢 AVAILABLE</option>
              <option value="RESERVED" ${selectedStatus=='RESERVED' ? 'selected' : '' }>🟡 RESERVED</option>
              <option value="OCCUPIED" ${selectedStatus=='OCCUPIED' ? 'selected' : '' }>🔴 OCCUPIED</option>
            </select>
            <button
              class="px-3 py-2 rounded-md bg-[color:var(--tw-color-primary,#D4AF37)] text-black text-xs tracking-widest uppercase font-semibold">Lọc</button>
          </form>
          <div class="overflow-auto">
            <table class="table-v">
              <thead>
                <tr>
                  <th>Mã bàn</th>
                  <th>Khu</th>
                  <th>Sức chứa</th>
                  <th>Trạng thái</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="t" items="${availableTables}">
                  <tr>
                    <td>${t.tableId}</td>
                    <td>${t.area}</td>
                    <td>${t.capacity}</td>
                    <td>
                      <c:choose>
                        <c:when test="${t.status == 'AVAILABLE'}">
                          <span
                            class="inline-block px-2 py-0.5 text-xs rounded-full bg-emerald-500/20 text-emerald-400 ring-1 ring-emerald-500/30">AVAILABLE</span>
                        </c:when>
                        <c:when test="${t.status == 'RESERVED'}">
                          <span
                            class="inline-block px-2 py-0.5 text-xs rounded-full bg-yellow-500/20 text-yellow-400 ring-1 ring-yellow-500/30">RESERVED</span>
                        </c:when>
                        <c:when test="${t.status == 'OCCUPIED'}">
                          <span
                            class="inline-block px-2 py-0.5 text-xs rounded-full bg-red-500/20 text-red-400 ring-1 ring-red-500/30">OCCUPIED</span>
                        </c:when>
                        <c:otherwise>
                          <span
                            class="inline-block px-2 py-0.5 text-xs rounded-full bg-slate-500/20 text-slate-400">${t.status}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </section>
      </main>
    </body>

    </html>