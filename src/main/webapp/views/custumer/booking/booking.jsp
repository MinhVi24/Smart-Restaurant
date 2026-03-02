<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Luxury Restaurant Table Selection</title>
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700&amp;family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&amp;display=swap" rel="stylesheet"/>
        <!-- Material Symbols -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <!-- Tailwind Configuration -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#d4af35",
                            "background-light": "#f8f7f6",
                            "background-dark": "#171612",
                            "surface-dark": "#201d16",
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
        <style>
            /* Custom styles for specific luxury effects */
            .glass-panel {
                background: rgba(32, 29, 22, 0.7);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 1px solid rgba(212, 175, 53, 0.1);
            }

            .gold-gradient-text {
                background: linear-gradient(135deg, #fff 0%, #d4af35 50%, #fff 100%);
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

            /* Hide scrollbar for clean look */
            .no-scrollbar::-webkit-scrollbar {
                display: none;
            }
            .no-scrollbar {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
        <!-- Header / Sticky Navbar -->
        <header class="sticky top-0 z-50 glass-panel border-b border-white/5 w-full">
            <div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
                <!-- Logo -->
                <div class="flex items-center gap-3">
                    <span class="material-symbols-outlined text-primary text-3xl">diamond</span>
                    <div>
                        <h1 class="font-serif text-xl font-bold tracking-widest text-white uppercase">Lumina</h1>
                        <p class="text-[10px] tracking-[0.3em] text-primary/80 uppercase">Fine Dining</p>
                    </div>
                </div>
                <!-- Step Indicator -->
                <nav class="hidden md:flex items-center gap-4">
                    <a class="flex items-center gap-2 group" href="#">
                        <span class="flex items-center justify-center w-6 h-6 rounded-full bg-primary text-background-dark text-xs font-bold">1</span>
                        <span class="text-primary font-medium text-sm tracking-wide border-b border-primary">Chọn Bàn</span>
                    </a>
                    <div class="w-8 h-[1px] bg-white/10"></div>
                    <a class="flex items-center gap-2 group opacity-50" href="#">
                        <span class="flex items-center justify-center w-6 h-6 rounded-full border border-white/30 text-white/50 text-xs font-bold">2</span>
                        <span class="text-white/50 font-medium text-sm tracking-wide group-hover:text-white transition-colors">Chọn Thực Đơn</span>
                    </a>
                    <div class="w-8 h-[1px] bg-white/10"></div>
                    <span class="flex items-center gap-2 opacity-50">
                        <span class="flex items-center justify-center w-6 h-6 rounded-full border border-white/30 text-white/50 text-xs font-bold">3</span>
                        <span class="text-white/50 font-medium text-sm tracking-wide">Hoàn Tất</span>
                    </span>
                </nav>
                <!-- User/Menu -->
                <div class="flex items-center gap-6">
                    <button class="text-white/70 hover:text-primary transition-colors">
                        <span class="material-symbols-outlined">search</span>
                    </button>
                    <button class="bg-primary/10 hover:bg-primary/20 text-primary border border-primary/30 px-5 py-2 rounded-lg text-sm font-semibold tracking-wide transition-all">
                        Đăng Nhập
                    </button>
                </div>
            </div>
        </header>
        <!-- Main Content -->
        <main class="flex-grow flex flex-col max-w-7xl mx-auto w-full px-4 sm:px-6 py-8 relative">
            <!-- Filter Section -->
            <section class="mb-10 w-full">
                <h2 class="font-serif text-3xl md:text-4xl text-center mb-2 text-white">Đặt Bàn Thượng Hạng</h2>
                <p class="text-center text-white/50 text-sm mb-8 tracking-wide font-light">Trải nghiệm ẩm thực đẳng cấp 5 sao tại không gian sang trọng bậc nhất</p>
                <div class="glass-panel p-1 rounded-2xl max-w-4xl mx-auto">
                    <div class="flex flex-col md:flex-row items-center gap-2 p-3">
                        <!-- Date Picker -->
                        <div class="flex-1 w-full relative group">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-primary">calendar_today</span>
                            </div>
                            <select class="block w-full pl-12 pr-10 py-3 bg-surface-dark/50 border border-white/10 rounded-xl text-white focus:ring-1 focus:ring-primary focus:border-primary sm:text-sm cursor-pointer hover:bg-white/5 transition-colors appearance-none">
                                <option>Thứ Sáu, 24 Tháng 5</option>
                                <option>Thứ Bảy, 25 Tháng 5</option>
                                <option>Chủ Nhật, 26 Tháng 5</option>
                            </select>
                            <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-white/30 text-sm">expand_more</span>
                            </div>
                        </div>
                        <div class="hidden md:block w-[1px] h-10 bg-white/10"></div>
                        <!-- Time Picker -->
                        <div class="flex-1 w-full relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-primary">schedule</span>
                            </div>
                            <select class="block w-full pl-12 pr-10 py-3 bg-surface-dark/50 border border-white/10 rounded-xl text-white focus:ring-1 focus:ring-primary focus:border-primary sm:text-sm cursor-pointer hover:bg-white/5 transition-colors appearance-none">
                                <option>19:00 - Bữa Tối</option>
                                <option>19:30 - Bữa Tối</option>
                                <option>20:00 - Bữa Tối</option>
                            </select>
                            <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-white/30 text-sm">expand_more</span>
                            </div>
                        </div>
                        <div class="hidden md:block w-[1px] h-10 bg-white/10"></div>
                        <!-- Guest Picker -->
                        <div class="flex-1 w-full relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-primary">group</span>
                            </div>
                            <select class="block w-full pl-12 pr-10 py-3 bg-surface-dark/50 border border-white/10 rounded-xl text-white focus:ring-1 focus:ring-primary focus:border-primary sm:text-sm cursor-pointer hover:bg-white/5 transition-colors appearance-none">
                                <option>2 Khách</option>
                                <option>4 Khách</option>
                                <option>6 Khách</option>
                                <option>VIP Private</option>
                            </select>
                            <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                                <span class="material-symbols-outlined text-white/30 text-sm">expand_more</span>
                            </div>
                        </div>
                        <!-- Search Button -->
                        <button class="w-full md:w-auto bg-primary text-surface-dark font-bold px-8 py-3 rounded-xl hover:bg-white transition-all shadow-glow">
                            Tìm Bàn
                        </button>
                    </div>
                </div>
            </section>
            <!-- Interactive Floor Plan -->
            <section class="flex-1 relative overflow-hidden rounded-3xl border border-white/5 bg-surface-dark/30 shadow-2xl mb-24">
                <!-- Background Texture/Image -->
                <div class="absolute inset-0 z-0 opacity-20 bg-[url('https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&amp;w=2574&amp;auto=format&amp;fit=crop')] bg-cover bg-center mix-blend-overlay" data-alt="Abstract luxurious marble texture background"></div>
                <!-- Zone Tabs -->
                <div class="relative z-10 flex border-b border-white/10 bg-surface-dark/80 backdrop-blur-sm">
                    <button class="flex-1 py-4 text-center border-b-2 border-primary text-primary font-serif font-medium tracking-wider relative">
                        <span class="block text-sm sm:text-base">Khu Vực Cửa Sổ</span>
                        <span class="text-[10px] text-primary/60 uppercase tracking-widest">City View</span>
                    </button>
                    <button class="flex-1 py-4 text-center border-b-2 border-transparent text-white/40 hover:text-white font-serif font-medium tracking-wider transition-colors">
                        <span class="block text-sm sm:text-base">Khu Vườn Nhiệt Đới</span>
                        <span class="text-[10px] opacity-60 uppercase tracking-widest">Garden Lounge</span>
                    </button>
                    <button class="flex-1 py-4 text-center border-b-2 border-transparent text-white/40 hover:text-white font-serif font-medium tracking-wider transition-colors">
                        <span class="block text-sm sm:text-base">Khu Vực VIP</span>
                        <span class="text-[10px] opacity-60 uppercase tracking-widest">Private Dining</span>
                    </button>
                </div>
                <!-- Map Layout -->
                <div class="relative z-10 w-full h-[500px] p-8 overflow-auto no-scrollbar">
                    <div class="relative min-w-[800px] h-full mx-auto max-w-[1000px]">
                        <!-- Decorative Elements representing walls/windows -->
                        <div class="absolute top-0 left-0 right-0 h-2 bg-gradient-to-b from-white/10 to-transparent rounded-full"></div>
                        <div class="absolute bottom-10 left-0 w-full text-center text-white/20 text-xs tracking-[0.5em] uppercase font-light">City Skyline View</div>
                        <!-- Legend -->
                        <div class="absolute top-4 right-4 flex flex-col gap-2 p-3 rounded-lg bg-black/40 backdrop-blur-md border border-white/5">
                            <div class="flex items-center gap-2">
                                <div class="w-3 h-3 rounded-full border border-primary/50 bg-primary/20"></div>
                                <span class="text-[10px] text-white/70 uppercase tracking-wider">Trống</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <div class="w-3 h-3 rounded-full bg-primary shadow-glow"></div>
                                <span class="text-[10px] text-white/70 uppercase tracking-wider">Đang chọn</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <div class="w-3 h-3 rounded-full bg-surface-dark border border-white/10 opacity-50"></div>
                                <span class="text-[10px] text-white/70 uppercase tracking-wider">Đã đặt</span>
                            </div>
                        </div>
                        <!-- Tables Grid (Organic Layout) -->
                        <!-- Row 1: Window Seats -->
                        <div class="absolute top-12 left-20">
                            <button class="table-shape group relative w-16 h-16 rounded-full border border-primary/40 hover:border-primary hover:bg-primary/10 flex items-center justify-center">
                                <div class="w-10 h-10 rounded-full bg-white/5"></div>
                                <span class="absolute text-xs text-primary font-medium">A1</span>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Bàn số A1 - City View</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 2 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                        </div>
                        <div class="absolute top-8 left-60">
                            <!-- Selected State -->
                            <button class="table-shape group relative w-20 h-20 rounded-full bg-primary shadow-glow flex items-center justify-center transform scale-110">
                                <div class="w-12 h-12 rounded-full bg-black/10"></div>
                                <span class="absolute text-sm text-surface-dark font-bold">A2</span>
                                <!-- Checkmark indicator for selected -->
                                <div class="absolute -top-1 -right-1 w-6 h-6 bg-white rounded-full flex items-center justify-center shadow-lg">
                                    <span class="material-symbols-outlined text-primary text-sm font-bold">check</span>
                                </div>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Bàn số A2 - City View</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 4 người</p>
                                    <p class="text-primary text-[10px] mt-1 uppercase tracking-wider">Đang Chọn</p>
                                </div>
                            </button>
                        </div>
                        <div class="absolute top-12 left-[28rem]">
                            <!-- Booked State -->
                            <button class="table-shape w-16 h-16 rounded-full bg-surface-dark border border-white/5 flex items-center justify-center opacity-40 cursor-not-allowed">
                                <div class="w-10 h-10 rounded-full bg-white/5"></div>
                                <span class="absolute text-xs text-white/30 font-medium">A3</span>
                            </button>
                        </div>
                        <div class="absolute top-12 right-20">
                            <button class="table-shape group relative w-16 h-16 rounded-full border border-primary/40 hover:border-primary hover:bg-primary/10 flex items-center justify-center">
                                <div class="w-10 h-10 rounded-full bg-white/5"></div>
                                <span class="absolute text-xs text-primary font-medium">A4</span>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Bàn số A4 - City View</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 2 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                        </div>
                        <!-- Row 2: Larger Tables -->
                        <div class="absolute top-48 left-32">
                            <button class="table-shape group relative w-32 h-20 rounded-2xl border border-primary/40 hover:border-primary hover:bg-primary/10 flex items-center justify-center">
                                <div class="w-24 h-12 rounded-lg bg-white/5 border border-white/5"></div>
                                <span class="absolute text-xs text-primary font-medium">B1</span>
                                <!-- Chairs representation -->
                                <div class="absolute -top-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/10 rounded-full"></div>
                                </div>
                                <div class="absolute -bottom-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/10 rounded-full"></div>
                                </div>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Bàn số B1 - Central</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 6 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                        </div>
                        <div class="absolute top-48 left-[24rem]">
                            <button class="table-shape w-32 h-20 rounded-2xl bg-surface-dark border border-white/5 flex items-center justify-center opacity-40 cursor-not-allowed">
                                <div class="w-24 h-12 rounded-lg bg-white/5 border border-white/5"></div>
                                <span class="absolute text-xs text-white/30 font-medium">B2</span>
                                <div class="absolute -top-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/5 rounded-full"></div>
                                </div>
                                <div class="absolute -bottom-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/5 rounded-full"></div>
                                </div>
                            </button>
                        </div>
                        <div class="absolute top-48 right-32">
                            <button class="table-shape group relative w-32 h-20 rounded-2xl border border-primary/40 hover:border-primary hover:bg-primary/10 flex items-center justify-center">
                                <div class="w-24 h-12 rounded-lg bg-white/5 border border-white/5"></div>
                                <span class="absolute text-xs text-primary font-medium">B3</span>
                                <div class="absolute -top-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/10 rounded-full"></div>
                                </div>
                                <div class="absolute -bottom-2 left-1/2 -translate-x-1/2 flex gap-4">
                                    <div class="w-8 h-2 bg-white/10 rounded-full"></div>
                                </div>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Bàn số B3 - Central</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 6 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                        </div>
                        <!-- Row 3: Booths -->
                        <div class="absolute bottom-12 left-1/2 -translate-x-1/2 flex gap-16">
                            <button class="table-shape group relative w-24 h-24 rounded-t-3xl border-2 border-primary/20 hover:border-primary hover:bg-primary/5 flex flex-col items-center justify-end pb-2">
                                <span class="absolute top-4 text-[10px] text-primary/50 font-serif tracking-widest uppercase">Booth</span>
                                <div class="w-16 h-12 rounded-t-xl bg-white/5 border border-white/5 mb-1"></div>
                                <span class="text-xs text-primary font-medium">C1</span>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Booth C1 - Private</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 4 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                            <button class="table-shape group relative w-24 h-24 rounded-t-3xl border-2 border-primary/20 hover:border-primary hover:bg-primary/5 flex flex-col items-center justify-end pb-2">
                                <span class="absolute top-4 text-[10px] text-primary/50 font-serif tracking-widest uppercase">Booth</span>
                                <div class="w-16 h-12 rounded-t-xl bg-white/5 border border-white/5 mb-1"></div>
                                <span class="text-xs text-primary font-medium">C2</span>
                                <!-- Tooltip -->
                                <div class="tooltip invisible opacity-0 absolute bottom-full left-1/2 mb-3 w-40 bg-surface-dark/95 border border-primary/30 p-3 rounded-lg shadow-xl backdrop-blur-xl z-50 transition-all duration-300 pointer-events-none">
                                    <p class="text-primary font-bold text-sm mb-1">Booth C2 - Private</p>
                                    <p class="text-white/70 text-xs">Sức chứa: 4 người</p>
                                    <p class="text-green-400 text-[10px] mt-1 uppercase tracking-wider">Đang Trống</p>
                                </div>
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <!-- Floating Footer Action Bar -->
        <div class="fixed bottom-0 left-0 right-0 z-40 p-4">
            <div class="max-w-4xl mx-auto glass-panel bg-[#171612]/95 border-t border-primary/30 rounded-2xl shadow-2xl p-4 md:p-6 transform translate-y-0 transition-transform duration-500">
                <div class="flex flex-col md:flex-row items-center justify-between gap-6">
                    <!-- Selected Info -->
                    <div class="flex items-center gap-6 w-full md:w-auto">
                        <div class="w-16 h-16 rounded-lg bg-[url('https://images.unsplash.com/photo-1550966871-3ed3c47e2ce2?q=80&amp;w=2670&amp;auto=format&amp;fit=crop')] bg-cover bg-center shrink-0 border border-white/10 hidden sm:block" data-alt="Close up of fine dining table setting"></div>
                        <div>
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="text-primary font-serif font-bold text-lg">Bàn A2</h3>
                                <span class="px-2 py-0.5 rounded-full bg-primary/20 text-primary text-[10px] font-bold uppercase tracking-wider border border-primary/20">Khu Vực Cửa Sổ</span>
                            </div>
                            <div class="flex items-center gap-4 text-sm text-white/70">
                                <span class="flex items-center gap-1">
                                    <span class="material-symbols-outlined text-[16px]">calendar_month</span> 24/05
                                </span>
                                <span class="flex items-center gap-1">
                                    <span class="material-symbols-outlined text-[16px]">schedule</span> 19:30
                                </span>
                                <span class="flex items-center gap-1">
                                    <span class="material-symbols-outlined text-[16px]">group</span> 4 Người
                                </span>
                            </div>
                        </div>
                    </div>
                    <!-- Action Button -->
                    <button class="w-full md:w-auto flex items-center justify-center gap-2 bg-primary hover:bg-white text-surface-dark font-bold py-4 px-8 rounded-xl transition-all shadow-glow group">
                        <span class="uppercase tracking-widest text-sm">Tiếp Tục Chọn Món</span>
                        <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                    </button>
                </div>
            </div>
        </div>
    </body></html>