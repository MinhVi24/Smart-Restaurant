<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>

        <html class="dark" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>SmartResto - Hương Vị Đánh Thức Mọi Giác Quan</title>
            <link href="https://fonts.googleapis.com" rel="preconnect" />
            <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
            <link
                href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&amp;family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <script id="tailwind-config">
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "primary": "#e8bd30",
                                "background-light": "#f8f8f6",
                                "background-dark": "#181611",
                                "charcoal": "#211d11",
                                "champagne": "#e8bd30",
                                "cream": "#f5f5f0",
                                "neutral-dark": "#383529",
                            },
                            fontFamily: {
                                "display": ["Manrope", "sans-serif"],
                                "serif": ["Playfair Display", "serif"],
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                        },
                    },
                }
            </script>
        </head>

        <body
            class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-cream font-display antialiased selection:bg-primary selection:text-charcoal overflow-x-hidden">
            <div class="relative min-h-screen w-full flex flex-col">
                <!-- Sticky Navbar -->
                <header
                    class="fixed top-0 left-0 right-0 z-50 transition-all duration-300 bg-background-dark/90 backdrop-blur-md border-b border-white/5">
                    <div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
                        <!-- Logo -->
                        <div class="flex items-center gap-3">
                            <div class="size-8 text-primary">
                                <span class="material-symbols-outlined text-[32px]">restaurant_menu</span>
                            </div>
                            <h2 class="text-white text-xl font-bold tracking-wide font-serif">SmartResto</h2>
                        </div>
                        <!-- Navigation -->
                        <nav class="hidden md:flex items-center gap-10">
                            <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium uppercase tracking-widest"
                                href="${pageContext.request.contextPath}/">Trang chủ</a>
                            <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium uppercase tracking-widest"
                                href="${pageContext.request.contextPath}/menu">Thực đơn</a>
                            <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium uppercase tracking-widest"
                                href="${pageContext.request.contextPath}/views/custumer/booking/booking.jsp">Đặt Bàn</a>
                        </nav>
                        <!-- CTA -->
                        <div class="flex items-center gap-4">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser}">
                                    <span class="text-white/80 text-sm font-medium">Xin chào,
                                        ${sessionScope.loggedInUser.username}</span>
                                    <a href="${pageContext.request.contextPath}/logout"
                                        class="bg-red-500/80 hover:bg-red-600 text-white font-bold text-sm px-5 py-2.5 rounded-lg transition-all">Đăng
                                        xuất</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login"
                                        class="text-white/80 hover:text-primary transition-colors text-sm font-medium">Đăng
                                        nhập</a>
                                    <a href="${pageContext.request.contextPath}/register"
                                        class="bg-primary hover:bg-primary/90 text-charcoal font-bold text-sm px-6 py-2.5 rounded-lg transition-all transform hover:scale-105 shadow-[0_0_15px_rgba(232,189,48,0.3)]">Đăng
                                        Ký</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </header>
                <!-- Hero Section -->
                <div class="relative h-[90vh] w-full flex items-center justify-center overflow-hidden">
                    <!-- Background Image with Overlay -->
                    <div class="absolute inset-0 z-0 bg-cover bg-center bg-no-repeat"
                        data-alt="Luxurious dark restaurant interior with moody lighting and elegant table settings"
                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDFC70mvT56mQvj-N9vVsK-cO9IrFwrd89XXUSePRx0CrDO0eBNCDFV8X6SWhptmqXEGpAJ12El5B8gpRiUnTf27MU1fL-YzP1Dq8Wn0t96Gd_pIO_sBm7dozTrHV5RIc5JehQBzGBUK1u9JDnHBhDb6UlewWPMYHK9F-39oq8uFLZ8-hZZW4G8j7vnh7Ftg63IwjjUB6xsJSqWQZyeSdD6d874FLMxwwfIA4T5Hw9ogYziaNA55m2Eu406a5peC3McVE4aaQKDQnH-');">
                    </div>
                    <div class="absolute inset-0 z-0 bg-gradient-to-b from-black/70 via-black/50 to-background-dark">
                    </div>
                    <!-- Content -->
                    <div
                        class="relative z-10 container mx-auto px-6 text-center flex flex-col items-center gap-8 mt-16">
                        <div class="space-y-4 max-w-4xl mx-auto animate-fade-in-up">
                            <h2 class="text-primary text-sm md:text-base font-bold tracking-[0.2em] uppercase">
                                Nghệ Thuật Ẩm Thực &amp; Công Nghệ Tương Lai
                            </h2>
                            <h1
                                class="text-white text-5xl md:text-7xl lg:text-8xl font-serif font-medium leading-tight tracking-tight drop-shadow-2xl">
                                Hương Vị Đánh Thức <br /><span class="italic text-white/90">Mọi Giác Quan</span>
                            </h1>
                        </div>
                        <div class="pt-4">
                            <a href="${pageContext.request.contextPath}/views/custumer/booking/booking.jsp"
                                class="group inline-flex items-center justify-center gap-3 bg-primary text-charcoal text-base md:text-lg font-bold px-8 py-4 rounded-lg transition-all hover:shadow-[0_0_30px_rgba(232,189,48,0.5)] transform hover:-translate-y-1">
                                <span class="material-symbols-outlined">view_in_ar</span>
                                <span>Đặt Bàn Ngay</span>
                            </a>
                            <p class="mt-4 text-white/60 text-sm font-light">Đặt bàn trực quan - Chọn chỗ ngồi yêu thích
                            </p>
                        </div>
                    </div>
                    <!-- Scroll Indicator -->
                    <div class="absolute bottom-10 left-1/2 -translate-x-1/2 text-white/50 animate-bounce">
                        <span class="material-symbols-outlined text-3xl">keyboard_arrow_down</span>
                    </div>
                </div>
                <!-- Main Content Container -->
                <main class="flex flex-col flex-1 w-full max-w-[1440px] mx-auto">
                    <!-- Menu Section -->
                    <section class="py-20 px-6 md:px-10 lg:px-20">
                        <div class="flex flex-col md:flex-row justify-between items-end mb-12 gap-6">
                            <div>
                                <span
                                    class="text-primary text-sm font-bold tracking-widest uppercase mb-2 block">Premium
                                    Selection</span>
                                <h2 class="text-white text-4xl md:text-5xl font-serif font-medium">Thực Đơn Giới Hạn
                                </h2>
                            </div>
                            <a href="${pageContext.request.contextPath}/menu"
                                class="hidden md:flex items-center gap-2 text-white/80 hover:text-primary transition-colors border-b border-transparent hover:border-primary pb-0.5">
                                <span class="text-sm font-bold uppercase tracking-wider">Xem Toàn Bộ Thực Đơn</span>
                                <span class="material-symbols-outlined text-sm">arrow_forward</span>
                            </a>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                            <!-- Dish Card 1 -->
                            <div
                                class="group relative bg-neutral-dark/30 rounded-xl overflow-hidden hover:bg-neutral-dark/50 transition-colors border border-white/5 hover:border-primary/30">
                                <div class="relative aspect-[4/3] overflow-hidden">
                                    <div
                                        class="absolute top-4 right-4 z-20 bg-red-500/90 text-white text-[10px] font-bold px-2 py-1 rounded shadow-lg backdrop-blur-sm flex items-center gap-1 animate-pulse">
                                        <span class="material-symbols-outlined text-[12px]">timer</span>
                                        <span>Chỉ còn 3 phần</span>
                                    </div>
                                    <div class="bg-cover bg-center w-full h-full transition-transform duration-700 group-hover:scale-110"
                                        data-alt="Premium Wagyu beef steak plated artistically with herbs"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAkZJ9nP-Zb5SjOBqdpPRXWVXoOKQ4XHuOhN9bsoX1wR-H0Z62PB5KBGOvBJ4fGWLQNrpwiF3RyYfLm9y9TZacwxTbhWd3t3EBeIYUePhnbYph8seQiR8giNEmHVBw88Hol8T0axdslBLlfKjnkIzS_9joxl3Dkxu1WtV5acWKwVg9-3QIq_f6tBy_keUTHNeV46_n-scfmWTiitvHL8Pos1b772352bK3pPSe71p2OEKhi57sz4XkxSX5g6bW-7Ue1V878Sq_lJzZ6');">
                                    </div>
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60 group-hover:opacity-40 transition-opacity">
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-2">
                                        <h3
                                            class="text-white text-xl font-bold font-serif group-hover:text-primary transition-colors">
                                            Bò Wagyu Thượng Hạng</h3>
                                        <span class="text-primary font-bold text-lg">2.500k</span>
                                    </div>
                                    <p class="text-white/60 text-sm line-clamp-2 mb-4">Thịt bò A5 nhập khẩu trực tiếp từ
                                        Nhật Bản, nướng trên đá nóng núi lửa, kèm sốt nấm Truffle đen.</p>
                                    <button
                                        class="w-full py-2 border border-white/20 rounded hover:bg-white hover:text-charcoal text-white text-sm font-bold transition-all uppercase tracking-wide">
                                        Đặt món ngay
                                    </button>
                                </div>
                            </div>
                            <!-- Dish Card 2 -->
                            <div
                                class="group relative bg-neutral-dark/30 rounded-xl overflow-hidden hover:bg-neutral-dark/50 transition-colors border border-white/5 hover:border-primary/30">
                                <div class="relative aspect-[4/3] overflow-hidden">
                                    <div
                                        class="absolute top-4 right-4 z-20 bg-primary/90 text-charcoal text-[10px] font-bold px-2 py-1 rounded shadow-lg backdrop-blur-sm flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[12px]">star</span>
                                        <span>Signature</span>
                                    </div>
                                    <div class="bg-cover bg-center w-full h-full transition-transform duration-700 group-hover:scale-110"
                                        data-alt="Alaskan lobster tail with buttery sauce and garnish"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAiinzKMEPoTctjCrMP_LBPnNMYhrNjjhLT2H55aYsWCvY0aDzy1BTi4I1B6OwnfcbOficctUc9WygxqMuoZ2LpQ1t6-DQs1V3j2JjW01hStN9ERga0UzyHWIVzx8_e1Ti51Y0pJswnpVll7YLwxsLQDGKH3LnU66ItR3cF2DOx_ktxr-IoDUIPJfXsqnFNerC_FQRpCSsPq6hO06lHPik6xqSDU0sjiBw7vZ-Wjtv4pRh4y71VrhhyB_ZvGNQcFNj5mHe7n7kutEfc');">
                                    </div>
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60 group-hover:opacity-40 transition-opacity">
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-2">
                                        <h3
                                            class="text-white text-xl font-bold font-serif group-hover:text-primary transition-colors">
                                            Tôm Hùm Alaska Sốt Bơ</h3>
                                        <span class="text-primary font-bold text-lg">3.200k</span>
                                    </div>
                                    <p class="text-white/60 text-sm line-clamp-2 mb-4">Tôm hùm tươi sống bắt tại bể, chế
                                        biến theo phong cách Pháp với sốt bơ tỏi và rượu vang trắng.</p>
                                    <button
                                        class="w-full py-2 border border-white/20 rounded hover:bg-white hover:text-charcoal text-white text-sm font-bold transition-all uppercase tracking-wide">
                                        Đặt món ngay
                                    </button>
                                </div>
                            </div>
                            <!-- Dish Card 3 -->
                            <div
                                class="group relative bg-neutral-dark/30 rounded-xl overflow-hidden hover:bg-neutral-dark/50 transition-colors border border-white/5 hover:border-primary/30">
                                <div class="relative aspect-[4/3] overflow-hidden">
                                    <div
                                        class="absolute top-4 right-4 z-20 bg-neutral-500/90 text-white text-[10px] font-bold px-2 py-1 rounded shadow-lg backdrop-blur-sm flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[12px]">block</span>
                                        <span>Hết hàng</span>
                                    </div>
                                    <div class="bg-cover bg-center w-full h-full grayscale opacity-70 transition-transform duration-700 group-hover:scale-105"
                                        data-alt="Pan seared foie gras with berry reduction"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCaMVj6IhjrjvAvcsD9PgZ1KHqPhLebbhVJUKXZrRS5_RH1rlqETd3Y_fx8AwDbd8J1JEYyntnfk-2c93_wlj5XKBwRcYV8e81t4wFQM8pMX65KEY9Z3mUtl42fDMUQVBSxXfCL_XDjyn3Nu1Z1ANixDV8V0EVX3Ck9wkqOj_kjmY96ztH_3DLUXjuMa_nXCZWVad4zjHj99tfG9FiBhLv2xZmRrkch5QwQW_SBBwZS3a7AUENs3EkgUJiiBADPoljy8kWVTR3ECGLq');">
                                    </div>
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60">
                                    </div>
                                </div>
                                <div class="p-6 opacity-60">
                                    <div class="flex justify-between items-start mb-2">
                                        <h3 class="text-white text-xl font-bold font-serif">Gan Ngỗng Áp Chảo</h3>
                                        <span class="text-primary font-bold text-lg">1.800k</span>
                                    </div>
                                    <p class="text-white/60 text-sm line-clamp-2 mb-4">Gan ngỗng béo ngậy tan chảy, kết
                                        hợp hoàn hảo với sốt việt quất chua nhẹ cân bằng vị giác.</p>
                                    <button
                                        class="w-full py-2 border border-white/10 rounded bg-white/5 text-white/40 text-sm font-bold cursor-not-allowed uppercase tracking-wide"
                                        disabled="">
                                        Hết hàng hôm nay
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="mt-8 md:hidden flex justify-center">
                            <a href="${pageContext.request.contextPath}/menu"
                                class="flex items-center gap-2 text-white/80 hover:text-primary transition-colors border border-white/20 px-6 py-3 rounded-lg w-full justify-center">
                                <span class="text-sm font-bold uppercase tracking-wider">Xem Toàn Bộ Thực Đơn</span>
                            </a>
                        </div>
                    </section>
                    <!-- Ambience Section -->
                    <section class="py-20 px-0 md:px-10 lg:px-20 bg-charcoal/30">
                        <div class="container mx-auto">
                            <div class="text-center mb-16 px-6">
                                <span
                                    class="text-primary text-sm font-bold tracking-widest uppercase mb-2 block">Atmosphere</span>
                                <h2 class="text-white text-4xl md:text-5xl font-serif font-medium">Không Gian Đẳng Cấp
                                </h2>
                                <p class="text-white/60 mt-4 max-w-2xl mx-auto">Tận hưởng không gian sang trọng với tầm
                                    nhìn panorama tuyệt đẹp hoặc sự riêng tư tuyệt đối tại các phòng VIP.</p>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-8 h-auto md:h-[600px]">
                                <!-- Zone 1: City View -->
                                <div
                                    class="group relative overflow-hidden rounded-none md:rounded-2xl h-[400px] md:h-full">
                                    <div class="absolute inset-0 bg-cover bg-center transition-transform duration-1000 group-hover:scale-110"
                                        data-alt="Rooftop dining area with panoramic city skyline view at night"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDiP2Y9nLnYirYey4qWsCYfp-CG8rkV1rQPvvIc99yW7fQmSG3tKiGsmPhq95AGETJqz5T8TEr3QvEw1U-qX37tmkzRNneH4BGHMwo8X0ABgN5e2Ssn6nzi4rqrrgdLJVJjl0G6cnTZ4OtvzDi5iu30kRe-3Xl-QFwO4mM3OqB_XhZ_h_4SkCRKO6hHlmj9O4MklxTa4XPDLtIx3xWaifTdqbqZAQfkTfUrterVOtLa2TmGL3V-cpumeFsMQa2rS5enPdHKIL5t_mKM');">
                                    </div>
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent">
                                    </div>
                                    <div class="absolute bottom-0 left-0 p-8 md:p-12 w-full">
                                        <h3 class="text-white text-3xl font-serif font-medium mb-3">Sky Lounge &amp;
                                            City View</h3>
                                        <p
                                            class="text-white/70 mb-6 max-w-md transform translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-500">
                                            Thưởng thức bữa tối dưới ánh sao với tầm nhìn 360 độ bao quát thành phố sôi
                                            động.
                                        </p>
                                        <button
                                            class="flex items-center gap-2 text-primary font-bold uppercase text-sm tracking-widest group-hover:gap-4 transition-all">
                                            <span>Khám phá khu vực này</span>
                                            <span class="material-symbols-outlined text-lg">arrow_forward</span>
                                        </button>
                                    </div>
                                </div>
                                <!-- Zone 2: VIP -->
                                <div
                                    class="group relative overflow-hidden rounded-none md:rounded-2xl h-[400px] md:h-full">
                                    <div class="absolute inset-0 bg-cover bg-center transition-transform duration-1000 group-hover:scale-110"
                                        data-alt="Private VIP dining room with dark wood paneling and chandelier"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuA9DlCmPuER3J-n8wkEeQHnoqFMRQLa0sXSvTVxdgoyujGkC4P6dNfQEscD4FwqAaNAaVHVkfXb6b02nKNFWS301ZO2TXhSONnP9Ondvutxi1fVMi8wLwG7RUuhsrH7s28fY76j_cBLk3IzgqXVb7u7jkNwJJVdeJzk8YZtm7FJ7sMLIwDcXP0tiJQGFUAOaSU6YKTjJ-e38PuzA6mC13ghJzbBQdGih2Sybyo8p80kSGuBuQBUEhDGc4OJjjk3jnjwlVQo4dd03ze4');">
                                    </div>
                                    <div
                                        class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/20 to-transparent">
                                    </div>
                                    <div class="absolute bottom-0 left-0 p-8 md:p-12 w-full">
                                        <h3 class="text-white text-3xl font-serif font-medium mb-3">Private VIP Rooms
                                        </h3>
                                        <p
                                            class="text-white/70 mb-6 max-w-md transform translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-500">
                                            Không gian riêng tư, kín đáo, hoàn hảo cho các cuộc họp kinh doanh hoặc tiệc
                                            thân mật.
                                        </p>
                                        <button
                                            class="flex items-center gap-2 text-primary font-bold uppercase text-sm tracking-widest group-hover:gap-4 transition-all">
                                            <span>Đặt phòng VIP</span>
                                            <span class="material-symbols-outlined text-lg">arrow_forward</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <!-- Testimonial / Social Proof (Extra touch for completeness) -->
                    <section class="py-20 px-6 bg-background-dark border-t border-white/5">
                        <div class="max-w-4xl mx-auto text-center">
                            <span class="material-symbols-outlined text-primary text-5xl mb-6">format_quote</span>
                            <h3
                                class="text-2xl md:text-4xl text-white font-serif italic font-light leading-relaxed mb-8">
                                "Một trải nghiệm ẩm thực vượt xa sự mong đợi. Sự kết hợp giữa công nghệ đặt bàn 3D và
                                hương vị tuyệt hảo tạo nên đẳng cấp khác biệt."
                            </h3>
                            <div class="flex items-center justify-center gap-4">
                                <div class="size-12 rounded-full overflow-hidden bg-gray-600">
                                    <img alt="Portrait of food critic" class="w-full h-full object-cover"
                                        data-alt="Portrait of a smiling man in a suit"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuA_2-UG78mJTvS53W_4svcs2T_yWfyHTRqPbqL70ve87VgSLj_p8z712fEMGyhG0XKIQdiIqAIaGsJhNaTy1TNZL7ytpAgcvkGl7BAicAnSzS34kHUjMtoDPSeOR_jAndZkNxbApRLAMMGUVixBAqKPBP-fK_um70fb0QN2DlgxaHxp_cUUZLomvLkQ4jethgEw7CBVtHhdbnSXmp0j8OGCPOZILBCf3PYs9PtjfwtGFH573HyK931qhktw4pXKnvWygmeO-jNJCJ6J" />
                                </div>
                                <div class="text-left">
                                    <p class="text-white font-bold text-sm uppercase">Hoàng Minh Quân</p>
                                    <p class="text-primary text-xs">Food Critic - Tạp chí Ẩm Thực</p>
                                </div>
                            </div>
                        </div>
                    </section>
                </main>
                <!-- Footer -->
                <footer class="bg-[#12100c] border-t border-white/5 pt-16 pb-8">
                    <div class="container mx-auto px-6 lg:px-20">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
                            <div class="col-span-1 md:col-span-1">
                                <div class="flex items-center gap-3 mb-6">
                                    <div class="size-6 text-primary">
                                        <span class="material-symbols-outlined">restaurant_menu</span>
                                    </div>
                                    <h2 class="text-white text-lg font-bold tracking-wide font-serif">SmartResto</h2>
                                </div>
                                <p class="text-white/50 text-sm leading-relaxed">
                                    Nơi hội tụ tinh hoa ẩm thực và công nghệ hiện đại, mang đến trải nghiệm 5 sao chuẩn
                                    mực mới.
                                </p>
                            </div>
                            <div>
                                <h4 class="text-white font-bold uppercase tracking-widest text-xs mb-6">Liên kết nhanh
                                </h4>
                                <ul class="space-y-3">
                                    <li><a class="text-white/60 hover:text-primary transition-colors text-sm"
                                            href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                                    <li><a class="text-white/60 hover:text-primary transition-colors text-sm"
                                            href="${pageContext.request.contextPath}/menu">Thực đơn</a></li>
                                    <li><a class="text-white/60 hover:text-primary transition-colors text-sm"
                                            href="${pageContext.request.contextPath}/views/custumer/booking/booking.jsp">Đặt
                                            bàn</a></li>
                                    <li><a class="text-white/60 hover:text-primary transition-colors text-sm"
                                            href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                                </ul>
                            </div>
                            <div>
                                <h4 class="text-white font-bold uppercase tracking-widest text-xs mb-6">Liên hệ</h4>
                                <ul class="space-y-3">
                                    <li class="flex items-start gap-3 text-white/60 text-sm">
                                        <span
                                            class="material-symbols-outlined text-base mt-0.5 text-primary">location_on</span>
                                        <span>Tầng 68, Tòa nhà Landmark,<br />Quận 1, TP. Hồ Chí Minh</span>
                                    </li>
                                    <li class="flex items-center gap-3 text-white/60 text-sm">
                                        <span class="material-symbols-outlined text-base text-primary">call</span>
                                        <span>+84 909 123 456</span>
                                    </li>
                                    <li class="flex items-center gap-3 text-white/60 text-sm">
                                        <span class="material-symbols-outlined text-base text-primary">mail</span>
                                        <span>booking@smartresto.vn</span>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <h4 class="text-white font-bold uppercase tracking-widest text-xs mb-6">Giờ mở cửa</h4>
                                <ul class="space-y-2">
                                    <li class="flex justify-between text-white/60 text-sm">
                                        <span>Thứ 2 - Thứ 6</span>
                                        <span class="text-white">10:00 - 23:00</span>
                                    </li>
                                    <li class="flex justify-between text-white/60 text-sm">
                                        <span>Thứ 7 - Chủ Nhật</span>
                                        <span class="text-white">09:00 - 00:00</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div
                            class="border-t border-white/5 pt-8 flex flex-col md:flex-row justify-between items-center gap-4">
                            <p class="text-white/30 text-xs">© 2024 SmartResto. All rights reserved.</p>
                            <div class="flex gap-6">
                                <a class="text-white/30 hover:text-white transition-colors" href="#"><i
                                        class="fa-brands fa-facebook"></i>Facebook</a>
                                <a class="text-white/30 hover:text-white transition-colors" href="#">Instagram</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </body>

        </html>