<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Vesper Luxury Restaurant Table Selection</title>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700&amp;family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
    tailwind.config = {
        darkMode: "class",
        theme: {
            extend: {
                colors: {
                    "primary": "#d4af35",
                    "champagne-gold": "#E5D192",
                    "background-light": "#f8f7f6",
                    "background-dark": "#121212",
                    "surface-dark": "#1a1a1a",
                    "accent-gold": "#C6A34F",
                },
                fontFamily: {
                    "display": ["Manrope", "sans-serif"],
                    "serif": ["Playfair Display", "serif"],
                },
                borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "2xl": "1rem", "full": "9999px"},
                boxShadow: {
                    'glow': '0 0 15px rgba(212, 175, 53, 0.3)',
                }
            },
        },
    }
</script>
<style type="text/tailwindcss">
    .glass-panel {
        @apply bg-[#1a1a1a]/70 backdrop-blur-xl border border-primary/10;
    }

    .gold-gradient-text {
        background: linear-gradient(135deg, #FFF5D1 0%, #D4AF37 50%, #B8860B 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .table-shape {
        transition: all 0.3s ease;
    }

    .table-shape:hover .tooltip {
        opacity: 1;
        transform: translateY(-8px) translateX(-50%);
        visibility: visible;
    }

    .no-scrollbar::-webkit-scrollbar {
        display: none;
    }

    .no-scrollbar {
        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .vesper-logo-motif {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .vesper-logo-motif::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        border: 1px solid #d4af35;
        transform: rotate(45deg);
    }
</style>

<style>
    .nav-link {
        font-family: Manrope, sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.15em;
        text-transform: uppercase;
        transition: 0.3s;
        color: rgba(255,255,255,0.6);
    }

    .nav-link:hover {
        color: #E5D192;
    }

    .nav-active {
        position: relative;
        color: #E5D192 !important;
    }

    .nav-active::after {
        content: "";
        position: absolute;
        bottom: -8px;
        left: 0;
        width: 100%;
        height: 1px;
        background: #E5D192;
    }
</style>
<header class="sticky top-0 z-50 bg-[#0f0f0f] border-b border-[#d4af35]/20 w-full shadow-2xl">

    <div class="w-full px-10 h-20 flex items-center justify-between">

        <!-- LOGO -->
        <div class="flex items-center gap-4 cursor-pointer">
            <div class="w-10 h-10 relative flex items-center justify-center">
                <div class="absolute w-full h-full border border-[#d4af35] rotate-45"></div>
                <span class="text-[#E5D192] text-2xl font-serif z-10">V</span>
            </div>
            <h1 class="text-[#E5D192] text-2xl font-serif tracking-[0.2em] uppercase">
                Vesper
            </h1>
        </div>

        <!-- MENU -->
        <nav class="flex items-center gap-10 text-sm font-medium tracking-wide">

            <!-- Trang chủ -->
            <a href="${pageContext.request.contextPath}/views/customer/home/home.jsp"
               class="relative pb-2 transition-all duration-300
               ${activePage == 'home' ? 'text-yellow-400 after:absolute after:left-0 after:bottom-0 after:w-full after:h-[2px] after:bg-yellow-400' : 'text-gray-400 hover:text-yellow-400'}">
                TRANG CHỦ
            </a>

            <!-- Đặt bàn -->
            <a href="${pageContext.request.contextPath}/views/customer/booking/booking.jsp"
               class="relative pb-2 transition-all duration-300
               ${activePage == 'booking' ? 'text-yellow-400 after:absolute after:left-0 after:bottom-0 after:w-full after:h-[2px] after:bg-yellow-400' : 'text-gray-400 hover:text-yellow-400'}">
                ĐẶT BÀN
            </a>

            <!-- Thực đơn -->
            <a href="${pageContext.request.contextPath}/views/customer/menu/menu.jsp"
               class="relative pb-2 transition-all duration-300
               ${activePage == 'menu' ? 'text-yellow-400 after:absolute after:left-0 after:bottom-0 after:w-full after:h-[2px] after:bg-yellow-400' : 'text-gray-400 hover:text-yellow-400'}">
                THỰC ĐƠN
            </a>

            <!-- Về chúng tôi -->
            <a href="${pageContext.request.contextPath}/views/customer/about/about.jsp"
               class="relative pb-2 transition-all duration-300
               ${activePage == 'about' ? 'text-yellow-400 after:absolute after:left-0 after:bottom-0 after:w-full after:h-[2px] after:bg-yellow-400' : 'text-gray-400 hover:text-yellow-400'}">
                VỀ CHÚNG TÔI
            </a>

            <!-- Hội viên -->
            <a href="${pageContext.request.contextPath}/views/customer/membership/membership.jsp"
               class="relative pb-2 transition-all duration-300
               ${activePage == 'member' ? 'text-yellow-400 after:absolute after:left-0 after:bottom-0 after:w-full after:h-[2px] after:bg-yellow-400' : 'text-gray-400 hover:text-yellow-400'}">
                HỘI VIÊN
            </a>

        </nav>

        <!-- BUTTON RIGHT -->
        <div>
            <a href="${pageContext.request.contextPath}/views/customer/auth/login.jsp"
               class="text-[#D4AF37] hover:text-white border border-[#D4AF37] 
               hover:bg-[#D4AF37]/10 px-6 py-2 rounded-sm 
               text-sm font-medium tracking-wider 
               transition-all uppercase">
                Đăng Nhập
            </a>
        </div>

    </div>

</header>