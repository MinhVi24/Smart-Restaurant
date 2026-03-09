<%-- 
    Document   : home
    Created on : Mar 3, 2026, 8:57:41 PM
    Author     : TRUNG TIN
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="dark" lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vesper Web Sidebar Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script>
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              primary: "#D4AF37",
              "background-dark": "#0A0A0A",
              "card-dark": "#141411",
              "gold-muted": "rgba(212, 175, 55, 0.15)",
            },
            fontFamily: {
              display: ["Cinzel", "serif"],
              sans: ["Inter", "sans-serif"],
            },
          },
        },
      };
    </script>
    <style type="text/tailwindcss">
      @layer base {
        body {
          @apply bg-background-dark text-slate-200 antialiased overflow-hidden;
          font-family: 'Inter', sans-serif;
        }
      }
      .luxury-text-shadow { text-shadow: 0 0 30px rgba(212, 175, 55, 0.5); }
      .watermark-center {
        position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
        font-size: 15vw; font-family: 'Cinzel', serif; color: transparent;
        -webkit-text-stroke: 1.5px rgba(212, 175, 55, 0.08);
        pointer-events: none; z-index: 0; user-select: none; text-transform: uppercase;
        font-weight: 700; letter-spacing: 0.2em;
      }
      .nav-item { @apply flex flex-col items-center justify-center gap-1 w-full h-20 rounded-lg mx-2 my-2 transition-all duration-300 hover:bg-white/5; }
      .nav-item.active { @apply bg-primary/10 ring-1 ring-primary/30; }
      .nav-item.active .material-symbols-outlined, .nav-item.active .nav-label { @apply text-primary opacity-100; }
      .nav-label { @apply text-[10px] uppercase tracking-[0.2em] font-medium text-slate-400 text-center px-2; }
      /* Ẩn scrollbar trong sidebar */
      .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
      .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
    <style>
      body { min-height: max(884px, 100dvh); }
    </style>
  </head>
  <body class="h-screen flex">
    <aside class="w-32 md:w-40 border-r border-gold-border flex flex-col items-center z-30 bg-background-dark/95 backdrop-blur-2xl">
      <div class="py-10 mb-4">
        <div class="w-14 h-14 border-2 border-primary/40 rounded-full flex items-center justify-center shadow-[0_0_15px_rgba(212,175,55,0.2)]">
          <span class="font-display font-bold text-primary text-2xl">V</span>
        </div>
      </div>
      <nav class="flex-1 flex flex-col w-full overflow-y-hidden no-scrollbar">
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
        <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/kitchen-board">
          <span class="material-symbols-outlined text-2xl">soup_kitchen</span>
          <span class="nav-label">Bảng bếp</span>
        </a>
        <a class="nav-item opacity-80 hover:opacity-100" href="${pageContext.request.contextPath}/staff/payments">
          <span class="material-symbols-outlined text-2xl">payments</span>
          <span class="nav-label">Thanh toán</span>
        </a>
        <div class="mt-auto pt-6 border-t border-gold-muted/30">
          <a class="nav-item opacity-60 hover:opacity-100" href="${pageContext.request.contextPath}/profile">
            <span class="material-symbols-outlined text-lg">settings</span>
            <span class="nav-label !text-[8px]">Cài đặt</span>
          </a>
          <a class="nav-item opacity-60 hover:opacity-100 mb-4" href="${pageContext.request.contextPath}/logout">
            <span class="material-symbols-outlined text-lg">logout</span>
            <span class="nav-label !text-[8px]">Đăng xuất</span>
          </a>
        </div>
      </nav>
    </aside>
    <main class="flex-1 flex flex-col relative z-10 overflow-hidden bg-background-dark">
      <div class="watermark-center">VESPER</div>
      <header class="px-12 py-8 flex items-center justify-between z-20">
        <div class="flex flex-col">
          <p class="text-[10px] tracking-[0.5em] text-primary/60 uppercase mb-1">Internal Dashboard</p>
          <h1 class="font-display text-lg tracking-[0.2em] text-primary uppercase">Staff Console</h1>
        </div>
        <div class="flex items-center gap-8">
          <div class="hidden md:flex flex-col items-end">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest leading-none mb-1">Hệ thống</p>
            <p class="text-xs text-emerald-500 font-medium flex items-center gap-1.5">
              <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
              Đang hoạt động
            </p>
          </div>
          <div class="flex items-center gap-4 pl-8 border-l border-gold-muted">
            <div class="text-right">
              <p class="text-xs text-white font-medium uppercase tracking-wider">Nhân viên</p>
              <p class="text-[10px] text-primary/70 uppercase tracking-widest">Ca tối</p>
            </div>
            <div class="w-10 h-10 rounded-full bg-gold-muted border border-primary/20 flex items-center justify-center">
              <span class="material-symbols-outlined text-primary text-xl">person</span>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="ml-4 inline-flex items-center gap-2 px-3 py-2 rounded-md bg-red-600 text-white text-xs tracking-widest uppercase font-semibold hover:bg-red-500 transition">
              <span class="material-symbols-outlined text-sm">logout</span>
              <span>Đăng xuất</span>
            </a>
          </div>
        </div>
      </header>
      <div class="flex-1 flex flex-col items-center justify-center p-12 text-center relative z-20">
        <div class="max-w-2xl">
          <h2 class="font-display text-6xl text-primary luxury-text-shadow mb-6">Chào em</h2>
          <div class="flex items-center justify-center gap-4 mb-8">
            <div class="h-px w-16 bg-gradient-to-r from-transparent to-primary/50"></div>
            <span class="font-display text-xl tracking-[0.3em] text-slate-300 uppercase">Nhân viên Vesper</span>
            <div class="h-px w-16 bg-gradient-to-l from-transparent to-primary/50"></div>
          </div>
          <p class="text-slate-400 text-sm tracking-[0.15em] font-light max-w-md mx-auto leading-relaxed uppercase">
            Vui lòng chọn một chức năng từ thanh điều hướng bên trái để bắt đầu quản lý dịch vụ tối nay.
          </p>
        </div>
      </div>
      <footer class="px-12 py-10 flex justify-between items-end text-[9px] tracking-[0.4em] uppercase text-slate-600 font-medium z-20">
        <div class="flex flex-col gap-1">
          <span>Vesper Fine Dining & Lounge</span>
          <span>Version 2.4.1 Premium Edition</span>
        </div>
        <div class="flex flex-col items-end gap-1">
          <span>Est. 2024</span>
          <span class="text-primary/40">Excellence in Service</span>
        </div>
      </footer>
    </main>
  </body>
</html>
