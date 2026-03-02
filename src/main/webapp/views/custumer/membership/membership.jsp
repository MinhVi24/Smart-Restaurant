<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Maison D'Or Membership Dashboard</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&amp;family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#d4af35",
                            "primary-light": "#e8c85e",
                            "primary-dark": "#a38622",
                            "background-light": "#f8f7f6",
                            "background-dark": "#171612", // Adjusted to match the component's deep charcoal feel
                            "card-dark": "#201d16", // Slightly lighter for cards
                            "card-border": "#37342a",
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"],
                            "serif": ["Playfair Display", "serif"],
                        },
                        borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "2xl": "1rem", "full": "9999px"},
                    },
                },
            }
        </script>
        <style>
            .gold-gradient-text {
                background: linear-gradient(135deg, #FFF 0%, #d4af35 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }
            .gold-glow {
                box-shadow: 0 0 20px rgba(212, 175, 53, 0.15);
            }
            .scrollbar-hide::-webkit-scrollbar {
                display: none;
            }
            .scrollbar-hide {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 antialiased selection:bg-primary/30">
        <div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
            <!-- Header -->
            <header class="sticky top-0 z-50 flex items-center justify-between border-b border-solid border-slate-200 dark:border-[#37342a] bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-sm px-6 py-4 lg:px-10">
                <div class="flex items-center gap-4">
                    <div class="size-8 text-primary">
                        <span class="material-symbols-outlined text-[32px]">diamond</span>
                    </div>
                    <h1 class="text-slate-900 dark:text-white text-xl lg:text-2xl font-bold font-serif tracking-tight">Maison D'Or</h1>
                </div>
                <nav class="hidden md:flex flex-1 justify-center gap-8 lg:gap-12">
                    <a class="text-slate-600 hover:text-primary dark:text-slate-300 dark:hover:text-primary text-sm font-medium transition-colors" href="#">Trang chủ</a>
                    <a class="text-slate-600 hover:text-primary dark:text-slate-300 dark:hover:text-primary text-sm font-medium transition-colors" href="#">Thực đơn</a>
                    <a class="text-slate-600 hover:text-primary dark:text-slate-300 dark:hover:text-primary text-sm font-medium transition-colors" href="#">Đặt bàn</a>
                    <a class="text-primary font-bold text-sm leading-normal border-b-2 border-primary pb-1" href="#">Hội viên</a>
                </nav>
                <div class="flex items-center gap-4">
                    <div class="hidden md:flex flex-col items-end mr-2">
                        <span class="text-xs text-slate-500 dark:text-slate-400 font-medium uppercase tracking-wider">Thành viên Vàng</span>
                        <span class="text-sm font-bold text-slate-900 dark:text-white">Nguyễn Hoàng</span>
                    </div>
                    <button class="relative group overflow-hidden rounded-full p-0.5 bg-gradient-to-br from-primary to-primary-dark">
                        <div class="bg-slate-200 dark:bg-zinc-800 rounded-full p-0.5 size-10 flex items-center justify-center overflow-hidden">
                            <img alt="Profile portrait of a man" class="size-full object-cover" data-alt="Profile portrait of a man" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDdTgMH6Z5xBe8QOhv5-5GIKftjOZ21W38qqYVtMdzOlNsb_8CHEk7o2oYH1BscuBOmnw90Ey4fwt-zrlawe44oqU595-Omx6Qi_Izbh346025ncxfSsfonscA-04OUWZKjzJKNHoXDOE6B8nlNEwqESCLjtp-FaZ7zocCMGeoogFfK_Km-du-zdLHRKD6WkWvPzXlUn0RzFw5trT75H0w7iO6f34NjlO3161nTfwAhhNDncwwOz9C53A3WF4aig7u6xBP7pJUoS3jw"/>
                        </div>
                    </button>
                    <button class="md:hidden text-slate-900 dark:text-white">
                        <span class="material-symbols-outlined">menu</span>
                    </button>
                </div>
            </header>
            <main class="flex-1 w-full max-w-[1440px] mx-auto px-4 py-8 lg:p-10 lg:pt-12">
                <!-- Welcome Section -->
                <div class="mb-10 flex flex-col md:flex-row md:items-end justify-between gap-4 animate-fade-in">
                    <div>
                        <h2 class="text-3xl md:text-5xl font-serif font-medium text-slate-900 dark:text-white mb-2">
                            Chào mừng trở lại,<br/> <span class="gold-gradient-text italic font-serif">Nguyễn Hoàng</span>
                        </h2>
                        <p class="text-slate-500 dark:text-[#b6b1a0] text-sm md:text-base max-w-lg mt-2">
                            Tận hưởng những đặc quyền ẩm thực thượng hạng dành riêng cho hội viên đẳng cấp.
                        </p>
                    </div>
                    <div class="flex gap-3">
                        <button class="flex items-center gap-2 px-6 py-3 rounded-full border border-slate-200 dark:border-[#37342a] bg-white dark:bg-card-dark hover:border-primary/50 text-slate-900 dark:text-white transition-all text-sm font-medium shadow-sm">
                            <span class="material-symbols-outlined text-[20px]">calendar_month</span>
                            Lịch sử
                        </button>
                        <button class="flex items-center gap-2 px-6 py-3 rounded-full bg-primary hover:bg-primary-light text-slate-900 font-bold transition-all text-sm shadow-lg shadow-primary/20">
                            <span class="material-symbols-outlined text-[20px]">restaurant</span>
                            Đặt bàn ngay
                        </button>
                    </div>
                </div>
                <!-- Grid Layout -->
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-8">
                    <!-- Left Column (Points & Progress) -->
                    <div class="lg:col-span-5 flex flex-col gap-6">
                        <!-- Points Card -->
                        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-[#2a261c] to-[#1a1915] border border-[#37342a] shadow-2xl p-8 group">
                            <!-- Background glow effect -->
                            <div class="absolute -top-24 -right-24 size-64 bg-primary/10 rounded-full blur-3xl group-hover:bg-primary/20 transition-all duration-700"></div>
                            <div class="relative z-10 flex justify-between items-start mb-8">
                                <div>
                                    <p class="text-primary text-sm font-bold tracking-widest uppercase mb-1">Điểm Tích Lũy</p>
                                    <div class="flex items-baseline gap-2">
                                        <span class="text-5xl lg:text-6xl font-serif text-white">12,500</span>
                                        <span class="text-primary/80 text-lg">pts</span>
                                    </div>
                                </div>
                                <div class="size-12 rounded-full bg-primary/10 flex items-center justify-center border border-primary/20">
                                    <span class="material-symbols-outlined text-primary text-2xl">stars</span>
                                </div>
                            </div>
                            <div class="relative z-10 space-y-4">
                                <div class="flex justify-between items-end">
                                    <div>
                                        <p class="text-white font-medium mb-1">Hạng Vàng (Gold)</p>
                                        <p class="text-[#b6b1a0] text-xs">Cần thêm 4,000 điểm để thăng hạng</p>
                                    </div>
                                    <span class="text-primary font-bold text-sm">75%</span>
                                </div>
                                <div class="h-1.5 w-full bg-slate-700/50 rounded-full overflow-hidden">
                                    <div class="h-full bg-gradient-to-r from-primary-dark via-primary to-primary-light w-[75%] rounded-full shadow-[0_0_10px_rgba(212,175,53,0.5)]"></div>
                                </div>
                                <div class="flex justify-between text-xs text-[#b6b1a0] pt-2 border-t border-white/5 mt-6">
                                    <span>Hạng hiện tại: Vàng</span>
                                    <span class="flex items-center gap-1 text-white">
                                        Tiếp theo: Kim Cương 
                                        <span class="material-symbols-outlined text-[14px]">arrow_forward</span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <!-- Recent Bookings -->
                        <div class="flex-1 bg-white dark:bg-card-dark rounded-2xl p-6 border border-slate-200 dark:border-[#37342a] shadow-sm flex flex-col">
                            <div class="flex justify-between items-center mb-6">
                                <h3 class="text-xl font-serif font-medium text-slate-900 dark:text-white">Lịch sử đặt bàn</h3>
                                <a class="text-xs text-primary hover:text-primary-light uppercase font-bold tracking-wider" href="#">Xem tất cả</a>
                            </div>
                            <div class="flex-1 space-y-4 overflow-y-auto max-h-[400px] pr-2 custom-scrollbar">
                                <!-- Booking Item 1 -->
                                <div class="flex items-center gap-4 p-4 rounded-xl bg-slate-50 dark:bg-[#2c2920] border border-transparent hover:border-primary/30 transition-all group cursor-pointer">
                                    <div class="flex flex-col items-center justify-center w-14 h-14 bg-white dark:bg-[#37342a] rounded-lg shadow-sm border border-slate-100 dark:border-white/5">
                                        <span class="text-xs text-slate-500 dark:text-slate-400 uppercase font-bold">T10</span>
                                        <span class="text-lg font-bold text-slate-900 dark:text-white font-serif">24</span>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between items-start">
                                            <h4 class="text-slate-900 dark:text-white font-medium">Bữa tối lãng mạn</h4>
                                            <span class="px-2.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-bold uppercase border border-emerald-500/20">Hoàn tất</span>
                                        </div>
                                        <div class="flex items-center gap-3 mt-1 text-xs text-slate-500 dark:text-[#b6b1a0]">
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">schedule</span> 19:30</span>
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">table_restaurant</span> Bàn 04</span>
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">group</span> 2 người</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Booking Item 2 -->
                                <div class="flex items-center gap-4 p-4 rounded-xl bg-slate-50 dark:bg-[#2c2920] border border-transparent hover:border-primary/30 transition-all group cursor-pointer">
                                    <div class="flex flex-col items-center justify-center w-14 h-14 bg-white dark:bg-[#37342a] rounded-lg shadow-sm border border-slate-100 dark:border-white/5">
                                        <span class="text-xs text-slate-500 dark:text-slate-400 uppercase font-bold">T11</span>
                                        <span class="text-lg font-bold text-slate-900 dark:text-white font-serif">02</span>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between items-start">
                                            <h4 class="text-slate-900 dark:text-white font-medium">Tiệc Doanh Nhân</h4>
                                            <span class="px-2.5 py-0.5 rounded-full bg-primary/10 text-primary text-[10px] font-bold uppercase border border-primary/20">Sắp tới</span>
                                        </div>
                                        <div class="flex items-center gap-3 mt-1 text-xs text-slate-500 dark:text-[#b6b1a0]">
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">schedule</span> 11:30</span>
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">meeting_room</span> Phòng VIP 1</span>
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">group</span> 6 người</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Booking Item 3 -->
                                <div class="flex items-center gap-4 p-4 rounded-xl bg-slate-50 dark:bg-[#2c2920] border border-transparent hover:border-primary/30 transition-all group cursor-pointer opacity-70 hover:opacity-100">
                                    <div class="flex flex-col items-center justify-center w-14 h-14 bg-white dark:bg-[#37342a] rounded-lg shadow-sm border border-slate-100 dark:border-white/5">
                                        <span class="text-xs text-slate-500 dark:text-slate-400 uppercase font-bold">T09</span>
                                        <span class="text-lg font-bold text-slate-900 dark:text-white font-serif">15</span>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex justify-between items-start">
                                            <h4 class="text-slate-900 dark:text-white font-medium">Thưởng trà chiều</h4>
                                            <span class="px-2.5 py-0.5 rounded-full bg-slate-500/10 text-slate-500 text-[10px] font-bold uppercase border border-slate-500/20">Đã hủy</span>
                                        </div>
                                        <div class="flex items-center gap-3 mt-1 text-xs text-slate-500 dark:text-[#b6b1a0]">
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">schedule</span> 15:00</span>
                                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-[14px]">deck</span> Sân thượng</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Right Column (Offers & Concierge) -->
                    <div class="lg:col-span-7 flex flex-col gap-6">
                        <!-- Exclusive Offers Section -->
                        <div class="flex flex-col gap-4">
                            <div class="flex justify-between items-baseline px-1">
                                <h3 class="text-xl font-serif font-medium text-slate-900 dark:text-white">Ưu đãi đặc quyền</h3>
                                <div class="flex gap-2">
                                    <button class="size-8 rounded-full border border-slate-200 dark:border-[#37342a] flex items-center justify-center hover:bg-slate-100 dark:hover:bg-[#37342a] text-slate-500 dark:text-white transition-colors">
                                        <span class="material-symbols-outlined text-[18px]">arrow_back</span>
                                    </button>
                                    <button class="size-8 rounded-full border border-slate-200 dark:border-[#37342a] flex items-center justify-center hover:bg-slate-100 dark:hover:bg-[#37342a] text-slate-500 dark:text-white transition-colors">
                                        <span class="material-symbols-outlined text-[18px]">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                            <!-- Offers Horizontal Scroll -->
                            <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-hide snap-x">
                                <!-- Offer Card 1 -->
                                <div class="min-w-[280px] md:min-w-[320px] snap-center rounded-xl overflow-hidden group relative h-[400px] cursor-pointer">
                                    <img alt="Glass of red wine on a dark table" class="absolute inset-0 size-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Glass of red wine on a dark table" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCXOBV5rEAODpLF8QGQ-YVQSEOtehqumNZiOJMaYRp2x8LxwHjmZRm-YchZIAIhKJLip0K_OjjoslhmTWdte7NU9XPCA7VIvN0y61HpA5CrAqpZTmjNaAdpqKorIVuA-LYVf2b-6JoCeG79C6O3-1SpD5NOxy89aP-0-GKkB3Vt5DpYyCbD6wX3OJLexnKpWY1mbCPR4X1V_njgVujNdLmq2CYRJPzT2kS7GygAEYSSNed2-O84KKnLo9IE0hR8jgCRB6lYylH936em"/>
                                    <div class="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent opacity-80 group-hover:opacity-90 transition-opacity"></div>
                                    <div class="absolute top-4 left-4">
                                        <span class="px-3 py-1 bg-primary text-[#171612] text-xs font-bold uppercase tracking-wider rounded-sm">Hội viên Vàng</span>
                                    </div>
                                    <div class="absolute bottom-0 left-0 p-6 w-full">
                                        <h4 class="text-2xl font-serif text-white mb-2 leading-tight">Tiệc Rượu Vang<br/>Tư Gia</h4>
                                        <p class="text-gray-300 text-sm mb-4 line-clamp-2">Trải nghiệm bộ sưu tập vang cổ điển ngay tại không gian riêng tư của bạn.</p>
                                        <span class="inline-flex items-center gap-1 text-primary text-sm font-bold uppercase tracking-wider group-hover:gap-2 transition-all">
                                            Chi tiết <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </span>
                                    </div>
                                </div>
                                <!-- Offer Card 2 -->
                                <div class="min-w-[280px] md:min-w-[320px] snap-center rounded-xl overflow-hidden group relative h-[400px] cursor-pointer">
                                    <img alt="Fine dining dish plating" class="absolute inset-0 size-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Fine dining dish plating" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBrNACXh0F1CvmMX4GJ_dhaNwkyXODRneGyVSMBH4f9M2DWHQbD2j--BNV7H3Pj602xXnFqdcxJhrE90W6r8IiDMQZ0PLtumlaLVG4WHosqSUtN3g7_8U23zWhTxqcvu4OvLXsrQEkIglrRiPfwqcsTsnJLp-zIxG4WvWU3ICtRzquRxRmn_KfykT93Fh3sdD2xOmbnR396e0zlOtwNdQBcqh5QAtn_Zdp6z5VHzPCYdQ3lpWH0bAGjKS6RfefKoqW54m6wtFaSxpPA"/>
                                    <div class="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent opacity-80 group-hover:opacity-90 transition-opacity"></div>
                                    <div class="absolute top-4 left-4">
                                        <span class="px-3 py-1 bg-white/20 backdrop-blur-md text-white border border-white/30 text-xs font-bold uppercase tracking-wider rounded-sm">Tất cả hạng</span>
                                    </div>
                                    <div class="absolute bottom-0 left-0 p-6 w-full">
                                        <h4 class="text-2xl font-serif text-white mb-2 leading-tight">Giảm 15% <br/>Thực đơn Tasting</h4>
                                        <p class="text-gray-300 text-sm mb-4 line-clamp-2">Khám phá hành trình vị giác với thực đơn 8 món đặc biệt từ Chef Pierre.</p>
                                        <span class="inline-flex items-center gap-1 text-primary text-sm font-bold uppercase tracking-wider group-hover:gap-2 transition-all">
                                            Chi tiết <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </span>
                                    </div>
                                </div>
                                <!-- Offer Card 3 -->
                                <div class="min-w-[280px] md:min-w-[320px] snap-center rounded-xl overflow-hidden group relative h-[400px] cursor-pointer">
                                    <img alt="Luxurious private dining room" class="absolute inset-0 size-full object-cover transition-transform duration-700 group-hover:scale-110" data-alt="Luxurious private dining room" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD37-CnG4bM7LAgcrssIjQoXwtS44ZUc4ihv8jKo8oTlm-1CXccMgOurgqQ0uonk8O0YubDFvvYWdEgfV_1Tf_Fa72avnbdvWPbUZ4n2566oXKp8oJ8Nx4jpVPKPaPlnbjOS1mRBqkUlOItkVoo7T9-2Z_eP619FtabN8Op40oaOuxkVBpqdrxUGDwXJvBoLg3BPun89EtnOw6vz7Qlw-JQE9SpvkywsGVMUFiIGTWbjWWkx-DVdyBgXvpSJ3Ffa3vIhKIm8rXKRcmO"/>
                                    <div class="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent opacity-80 group-hover:opacity-90 transition-opacity"></div>
                                    <div class="absolute bottom-0 left-0 p-6 w-full">
                                        <h4 class="text-2xl font-serif text-white mb-2 leading-tight">Phòng VIP <br/>Miễn phí</h4>
                                        <p class="text-gray-300 text-sm mb-4 line-clamp-2">Ưu đãi phòng riêng cho nhóm từ 4 người trở lên vào các tối trong tuần.</p>
                                        <span class="inline-flex items-center gap-1 text-primary text-sm font-bold uppercase tracking-wider group-hover:gap-2 transition-all">
                                            Chi tiết <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Concierge & Quick Stats Row -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 flex-1">
                            <!-- Concierge Card -->
                            <div class="rounded-2xl bg-[#201d16] border border-[#37342a] p-6 flex flex-col justify-between relative overflow-hidden group">
                                <!-- Pattern overlay -->
                                <div class="absolute inset-0 opacity-5 pointer-events-none" style="background-image: radial-gradient(#d4af35 1px, transparent 1px); background-size: 20px 20px;"></div>
                                <div>
                                    <div class="flex items-center gap-3 mb-4">
                                        <div class="size-10 rounded-full bg-primary/20 flex items-center justify-center text-primary">
                                            <span class="material-symbols-outlined">concierge</span>
                                        </div>
                                        <h3 class="text-lg font-serif font-medium text-white">Liên hệ Quản Gia</h3>
                                    </div>
                                    <p class="text-[#b6b1a0] text-sm mb-6">Đội ngũ chăm sóc khách hàng VIP sẵn sàng hỗ trợ bạn 24/7 cho mọi yêu cầu đặc biệt.</p>
                                </div>
                                <div class="flex flex-col gap-3 relative z-10">
                                    <button class="w-full py-3 bg-primary hover:bg-primary-light text-slate-900 font-bold rounded-lg transition-colors flex items-center justify-center gap-2">
                                        <span class="material-symbols-outlined text-[20px]">call</span>
                                        Gọi ngay
                                    </button>
                                    <button class="w-full py-3 bg-transparent border border-[#37342a] hover:bg-[#37342a] text-[#b6b1a0] hover:text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2">
                                        <span class="material-symbols-outlined text-[20px]">chat</span>
                                        Nhắn tin
                                    </button>
                                </div>
                            </div>
                            <!-- Quick Actions / Stats -->
                            <div class="rounded-2xl bg-white dark:bg-card-dark border border-slate-200 dark:border-[#37342a] p-6 flex flex-col gap-4">
                                <h3 class="text-lg font-serif font-medium text-slate-900 dark:text-white mb-2">Thông tin nhanh</h3>
                                <div class="flex items-center justify-between p-3 rounded-lg bg-slate-50 dark:bg-[#2c2920] border border-transparent hover:border-primary/20 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-slate-400 dark:text-slate-500">redeem</span>
                                        <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Voucher khả dụng</span>
                                    </div>
                                    <span class="text-lg font-bold text-slate-900 dark:text-white">3</span>
                                </div>
                                <div class="flex items-center justify-between p-3 rounded-lg bg-slate-50 dark:bg-[#2c2920] border border-transparent hover:border-primary/20 transition-colors">
                                    <div class="flex items-center gap-3">
                                        <span class="material-symbols-outlined text-slate-400 dark:text-slate-500">cake</span>
                                        <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Sinh nhật</span>
                                    </div>
                                    <span class="text-sm font-medium text-slate-500 dark:text-[#b6b1a0]">12/11</span>
                                </div>
                                <div class="mt-auto pt-2">
                                    <a class="flex items-center justify-between text-sm text-slate-500 dark:text-[#b6b1a0] hover:text-primary dark:hover:text-primary transition-colors group" href="#">
                                        <span>Cài đặt tài khoản</span>
                                        <span class="material-symbols-outlined text-[18px] group-hover:translate-x-1 transition-transform">arrow_forward</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script>
            // Simple logic to ensure the page loads with dark mode preference if set, though configured in tailwind-config as 'class'
            // Since we are forcing dark mode in the html tag as per instructions, this is just for potential toggling later.
        </script>
    </body></html>