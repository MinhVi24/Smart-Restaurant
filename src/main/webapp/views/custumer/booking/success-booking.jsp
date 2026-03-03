<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="dark" lang="vi"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Luxury Restaurant Booking - Hoàn Tất</title>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&amp;family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Theme Config -->
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#d4af35", // Champagne Gold
                        "primary-dark": "#b08d1e", 
                        "primary-light": "#eacc6b",
                        "background-light": "#f8f7f6",
                        "background-dark": "#1a1a1a", // Deep Charcoal
                        "surface-dark": "#232323",
                        "surface-light": "#ffffff",
                    },
                    fontFamily: {
                        "display": ["Newsreader", "serif"],
                        "serif": ["Playfair Display", "serif"],
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem", 
                        "lg": "0.5rem", 
                        "xl": "0.75rem", 
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
<style>
        /* Custom scrollbar for webkit */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #1a1a1a; 
        }
        ::-webkit-scrollbar-thumb {
            background: #37342a; 
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #d4af35; 
        }
        
        .gold-glow {
            box-shadow: 0 0 40px -10px rgba(212, 175, 53, 0.15);
        }

        .gold-gradient-text {
            background: linear-gradient(to bottom, #f3e5b5, #d4af35);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 flex flex-col min-h-screen">
<!-- Navigation Header -->
<header class="sticky top-0 z-50 w-full border-b border-[#37342a] bg-background-dark/95 backdrop-blur-md px-6 py-4">
<div class="mx-auto max-w-7xl flex items-center justify-between">
<!-- Brand -->
<div class="flex items-center gap-3">
<div class="size-8 text-primary">
<svg fill="currentColor" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"></path>
</svg>
</div>
<h1 class="text-xl font-serif font-bold tracking-widest text-primary uppercase">VESPER</h1>
</div>
<!-- Steps (Hidden on mobile, shown on md+) -->
<nav class="hidden md:flex items-center gap-12">
<a class="text-slate-500 hover:text-primary transition-colors text-sm font-medium tracking-wide" href="#">1. Chọn Bàn</a>
<div class="w-8 h-[1px] bg-[#37342a]"></div>
<a class="text-slate-500 hover:text-primary transition-colors text-sm font-medium tracking-wide" href="#">2. Thông Tin</a>
<div class="w-8 h-[1px] bg-[#37342a]"></div>
<a class="text-primary text-sm font-bold tracking-wide border-b border-primary pb-0.5" href="#">3. Hoàn Tất</a>
</nav>
<!-- User Actions -->
<div class="flex items-center gap-4">
<button class="p-2 text-slate-300 hover:text-primary transition-colors">
<span class="material-symbols-outlined">search</span>
</button>
<div class="hidden sm:flex items-center gap-3 pl-4 border-l border-[#37342a]">
<span class="text-sm text-slate-300">Xin chào, <strong>Minh</strong></span>
<div class="h-8 w-8 rounded-full bg-cover bg-center border border-primary/30" data-alt="User avatar" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC_0nZ97novH9UW7Qp8G_OD2Rj1wef1nGh6Qc1g6UNB7UkfSeFnni5FYb3xXSYOHnOst52e3tooxIzQk7VaeY1vz8XFfeiRNnHeUt2zUvwSycf7bEPknlcMcPYn4ANa8YwYCRAm8etYKnK2XBAOA6Lllx-R9jhp-9sMPch8Dch7Gk1CDEKrzSlhZASW3vLQmUunlUCvyGpWAhoc87jtLD5hx9PCzfHsE2DaiOV9jsVFSYE1i7qQvDyXy7foGtd2zneDncK-sFGUvu7J');">
</div>
</div>
</div>
</div>
</header>
<!-- Main Content Area -->
<main class="flex-grow flex items-center justify-center p-4 md:p-10 relative overflow-hidden">
<!-- Background Pattern/Watermark (Abstract geometric or logo) -->
<div class="absolute inset-0 z-0 opacity-[0.03] pointer-events-none" style="background-image: radial-gradient(#d4af35 1px, transparent 1px); background-size: 40px 40px;">
</div>
<div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-primary/5 rounded-full blur-3xl z-0 pointer-events-none"></div>
<!-- Confirmation Card -->
<div class="relative z-10 w-full max-w-3xl bg-surface-dark border border-[#37342a] shadow-2xl gold-glow rounded-xl overflow-hidden flex flex-col md:flex-row">
<!-- Left Side: Image Visual -->
<div class="hidden md:block w-1/3 relative">
<div class="absolute inset-0 bg-cover bg-center" data-alt="Elegant luxury dining table setting with golden cutlery and dark ambiance" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuASKJRw1yPQFFqCBqQZHt4PHCFQGUGF5_z8yc_uDq6O30VK96o9srQiomMX05MAQq7In9ZmGXbJ5TrqPNkVnWp7ewRGnS-V6BkSZ-I11j7pH0sNaAKuhG7e0pLfEkOcXGXWmeXSVGYJRGV6_-wD6GtcB_KjXenfR3O4CCS7hGQTBYWodKxxQfRoDyZJdHcKgmtCyjg-wJK21kI7-Tpv-SrLOGYX0_2ALmLaRzs8bpoifJCDSPbV7OtS3hYAFQmmD0xAZbCBjWJHv9Rb');">
</div>
<div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent"></div>
<div class="absolute bottom-6 left-6 right-6">
<p class="text-white/90 font-serif italic text-lg leading-snug">"Ẩm thực là nghệ thuật, và quý khách là nguồn cảm hứng."</p>
<p class="text-primary text-sm mt-2 font-medium">— Chef de Cuisine</p>
</div>
</div>
<!-- Right Side: Content -->
<div class="w-full md:w-2/3 p-8 md:p-10 flex flex-col items-center text-center">
<!-- Success Icon -->
<div class="mb-6 rounded-full bg-primary/10 p-4 ring-1 ring-primary/40">
<span class="material-symbols-outlined text-4xl text-primary">check_circle</span>
</div>
<!-- Title -->
<h2 class="text-3xl md:text-4xl font-serif font-bold text-slate-100 mb-3 gold-gradient-text">Đặt Bàn Thành Công</h2>
<p class="text-slate-400 text-sm md:text-base max-w-sm mb-8 leading-relaxed">
Cảm ơn quý khách đã lựa chọn VESPER. Bàn của quý khách đã được giữ trong vòng 15 phút.
                </p>
<!-- Booking Details Grid -->
<div class="w-full grid grid-cols-2 gap-x-4 gap-y-6 border-y border-[#37342a] py-6 mb-8">
<!-- Item 1 -->
<div class="flex flex-col items-start text-left pl-2">
<span class="text-[11px] uppercase tracking-widest text-primary/70 mb-1">Mã Đặt Bàn</span>
<span class="text-slate-100 font-medium text-lg">#RES-8829</span>
</div>
<!-- Item 2 -->
<div class="flex flex-col items-start text-left pl-2 md:border-l md:border-[#37342a]">
<span class="text-[11px] uppercase tracking-widest text-primary/70 mb-1">Ngày &amp; Giờ</span>
<div class="flex items-center gap-1.5 text-slate-100 font-medium text-lg">
<span>14/02/2024</span>
<span class="text-primary mx-1">•</span>
<span>20:00</span>
</div>
</div>
<!-- Item 3 -->
<div class="flex flex-col items-start text-left pl-2">
<span class="text-[11px] uppercase tracking-widest text-primary/70 mb-1">Vị Trí Bàn</span>
<span class="text-slate-100 font-medium text-base">Bàn 05 - Khu Vực VIP</span>
</div>
<!-- Item 4 -->
<div class="flex flex-col items-start text-left pl-2 md:border-l md:border-[#37342a]">
<span class="text-[11px] uppercase tracking-widest text-primary/70 mb-1">Thực Đơn Đã Chọn</span>
<span class="text-slate-100 font-medium text-base line-clamp-1">Menu Degustation (x2)</span>
</div>
</div>
<!-- Total Amount -->
<div class="flex flex-col items-center mb-8 w-full">
<span class="text-xs uppercase tracking-[0.2em] text-slate-500 mb-2">Tổng tiền tạm tính</span>
<span class="text-3xl md:text-4xl font-serif text-primary font-bold">12.000.000 VND</span>
</div>
<!-- Action Buttons -->
<div class="w-full flex flex-col gap-3">
<button class="w-full py-3.5 bg-primary hover:bg-primary-dark text-background-dark font-bold rounded-lg transition-all duration-300 shadow-lg shadow-primary/20 flex items-center justify-center gap-2 group">
<span>Trở Về Trang Chủ</span>
<span class="material-symbols-outlined text-lg group-hover:translate-x-1 transition-transform">arrow_forward</span>
</button>
<button class="w-full py-3.5 bg-transparent border border-primary/50 text-primary hover:bg-primary/5 hover:border-primary font-semibold rounded-lg transition-all duration-300 flex items-center justify-center gap-2">
<span class="material-symbols-outlined text-lg">download</span>
<span>Tải Xuống Xác Nhận</span>
</button>
<a class="mt-2 text-slate-400 hover:text-primary text-sm font-medium flex items-center justify-center gap-1.5 transition-colors duration-200" href="#">
<span class="material-symbols-outlined text-base">calendar_today</span>
                        Thêm Vào Lịch
                    </a>
</div>
</div>
</div>
<!-- Support Footer inside main to keep context close -->
<div class="absolute bottom-4 text-center">
<p class="text-slate-500 text-xs">Cần hỗ trợ? Liên hệ <a class="text-primary hover:underline" href="#">090 123 4567</a> hoặc <a class="text-primary hover:underline" href="#">concierge@maisondor.vn</a></p>
</div>
</main>
</body></html>