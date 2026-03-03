<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Dashboard - Maison D'Or Executive Suite</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600&family=Material+Icons+Round&display=swap" rel="stylesheet"/>
    <style type="text/tailwindcss">
        @layer base {
            body {
                font-family: 'Inter', sans-serif;
                background: #0D0D0D;
            }
        }
        @layer components {
            .font-display {
                font-family: 'Playfair Display', serif;
            }
            .glass-card {
                background: rgba(22, 22, 22, 0.7);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(212, 175, 55, 0.1);
            }
        }
    </style>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#D4AF37",
                    },
                },
            },
        };
    </script>
</head>
<body class="text-stone-300 min-h-screen">
    <!-- Header -->
    <header class="border-b border-stone-800 px-8 py-4">
        <div class="flex items-center justify-between">
            <div>
                <h1 class="text-4xl font-display font-bold text-white tracking-tight">Dashboard</h1>
                <div class="flex items-center gap-2 mt-2 text-stone-400 text-sm">
                    <span class="w-2 h-2 rounded-full bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.6)]"></span>
                    Maison D'Or Executive Suite • Cập nhật realtime
                </div>
            </div>
            
            <!-- Date Filter -->
            <div class="flex items-center gap-4">
                <div class="flex bg-stone-900/50 p-1 rounded-xl">
                    <button class="px-6 py-2 rounded-lg bg-primary text-black font-bold text-sm">Ngày</button>
                    <button class="px-6 py-2 rounded-lg text-stone-500 text-sm font-medium hover:text-stone-200">Tuần</button>
                    <button class="px-6 py-2 rounded-lg text-stone-500 text-sm font-medium hover:text-stone-200">Tháng</button>
                    <button class="px-6 py-2 rounded-lg text-stone-500 text-sm font-medium hover:text-stone-200">Năm</button>
                </div>
                <div class="flex items-center gap-2 bg-stone-900 border border-stone-800 px-4 py-2 rounded-xl">
                    <span class="material-icons-round text-primary text-xl">calendar_today</span>
                    <span class="text-sm font-medium">24 Tháng 10, 2023</span>
                </div>
                <button class="w-10 h-10 flex items-center justify-center bg-stone-900 border border-stone-800 rounded-xl hover:rotate-180 transition-transform duration-500">
                    <span class="material-icons-round text-primary">sync</span>
                </button>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="p-8">
        <div class="grid grid-cols-12 gap-6">
            <!-- Left Column -->
            <div class="col-span-3 space-y-6">
                <!-- Revenue Card -->
                <div class="glass-card bg-stone-900 p-6 rounded-3xl">
                    <div class="flex justify-between items-start mb-6">
                        <div>
                            <p class="text-[10px] uppercase tracking-wider text-stone-500 font-bold mb-1">DOANH THU (24H)</p>
                            <h3 class="text-4xl font-display font-bold text-primary">
                                <c:choose>
                                    <c:when test="${not empty todayRevenue}">
                                        ${String.format('%,.0f', todayRevenue)}đ
                                    </c:when>
                                    <c:otherwise>
                                        125.450.000đ
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <p class="text-[10px] text-stone-500 mt-2 italic">So với cùng giờ hôm qua</p>
                        </div>
                        <div class="bg-green-500/10 text-green-500 px-2 py-1 rounded text-xs font-bold flex items-center gap-1 border border-green-500/20">
                            <span class="material-icons-round text-xs">trending_up</span>
                            +18%
                        </div>
                    </div>
                    <div class="h-20 mb-6 flex items-end gap-1">
                        <div class="flex-1 bg-stone-800/50 rounded-t h-[40%]"></div>
                        <div class="flex-1 bg-stone-800/50 rounded-t h-[60%]"></div>
                        <div class="flex-1 bg-stone-800/50 rounded-t h-[50%]"></div>
                        <div class="flex-1 bg-stone-800/50 rounded-t h-[80%]"></div>
                        <div class="flex-1 bg-primary/40 rounded-t h-[90%]"></div>
                        <div class="flex-1 bg-primary rounded-t h-[70%]"></div>
                        <div class="flex-1 bg-primary/20 rounded-t h-[100%]"></div>
                    </div>
                    <div class="grid grid-cols-3 gap-2 border-t border-stone-800 pt-4">
                        <div class="text-center">
                            <p class="text-[9px] uppercase text-stone-500 mb-1">VIP ROOM</p>
                            <p class="text-lg font-display font-bold">45%</p>
                        </div>
                        <div class="text-center border-x border-stone-800">
                            <p class="text-[9px] uppercase text-stone-500 mb-1">MAIN HALL</p>
                            <p class="text-lg font-display font-bold">35%</p>
                        </div>
                        <div class="text-center">
                            <p class="text-[9px] uppercase text-stone-500 mb-1">TERRACE</p>
                            <p class="text-lg font-display font-bold">20%</p>
                        </div>
                    </div>
                </div>

                <!-- AI Prediction -->
                <div class="glass-card bg-stone-900 p-6 rounded-3xl border-t-2 border-t-purple-500/50">
                    <div class="flex items-center gap-2 mb-6">
                        <span class="material-icons-round text-purple-400">auto_awesome</span>
                        <p class="text-[11px] font-bold uppercase tracking-wider text-stone-400">AI Dự báo khách</p>
                    </div>
                    <div class="flex items-end gap-3 mb-6">
                        <span class="text-5xl font-display font-bold text-white">128</span>
                        <span class="text-xs text-stone-500 mb-1">khách dự kiến (19h-21h)</span>
                    </div>
                    <div class="h-24 mb-6">
                        <svg class="w-full h-full opacity-50" preserveAspectRatio="none" viewBox="0 0 400 100">
                            <path d="M0,80 C100,20 150,120 250,50 C300,10 350,80 400,30 L400,100 L0,100 Z" fill="url(#grad)"/>
                            <defs>
                                <linearGradient id="grad" x1="0%" x2="0%" y1="0%" y2="100%">
                                    <stop offset="0%" style="stop-color:rgba(168, 85, 247, 0.4);stop-opacity:1"/>
                                    <stop offset="100%" style="stop-color:rgba(168, 85, 247, 0);stop-opacity:0"/>
                                </linearGradient>
                            </defs>
                            <path d="M0,80 C100,20 150,120 250,50 C300,10 350,80 400,30" fill="none" stroke="#A855F7" stroke-width="2"/>
                        </svg>
                    </div>
                    <p class="text-[10px] text-stone-500 italic text-center">
                        Dữ liệu từ SmartAI phân tích lịch sử & thời tiết
                    </p>
                </div>
            </div>

            <!-- Middle Column -->
            <div class="col-span-6 space-y-6">
                <!-- Top Selling Items -->
                <div class="glass-card bg-stone-900 p-8 rounded-3xl">
                    <div class="flex justify-between items-center mb-10">
                        <h3 class="text-xl font-display font-bold tracking-tight">Món Bán Chạy <span class="text-stone-500 font-normal italic text-base">(Signature)</span></h3>
                        <div class="flex items-center gap-2 bg-stone-800 px-3 py-1.5 rounded-full">
                            <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse"></span>
                            <span class="text-[10px] font-bold text-stone-500 uppercase">DINING (18:00–22:00)</span>
                        </div>
                    </div>
                    <div class="space-y-10">
                        <c:choose>
                            <c:when test="${not empty topItems}">
                                <c:forEach var="item" items="${topItems}">
                                    <div>
                                        <div class="flex justify-between items-end mb-2">
                                            <div>
                                                <h4 class="font-bold">${item.itemName}</h4>
                                                <p class="text-xs text-stone-500">Món đặc trưng</p>
                                            </div>
                                            <div class="text-right">
                                                <span class="text-primary font-display font-bold text-lg">${item.orderCount}</span>
                                                <span class="text-[10px] text-stone-500 uppercase ml-1">orders</span>
                                            </div>
                                        </div>
                                        <div class="h-1.5 bg-stone-800 rounded-full">
                                            <div class="h-full bg-primary rounded-full" style="width: ${(item.orderCount / 50) * 100}%"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <div class="flex justify-between items-end mb-2">
                                        <div>
                                            <h4 class="font-bold">Wagyu A5 Striploin</h4>
                                            <p class="text-xs text-stone-500">Premium Marble Score 12</p>
                                        </div>
                                        <div class="text-right">
                                            <span class="text-primary font-display font-bold text-lg">42</span>
                                            <span class="text-[10px] text-stone-500 uppercase ml-1">orders</span>
                                        </div>
                                    </div>
                                    <div class="h-1.5 bg-stone-800 rounded-full">
                                        <div class="h-full bg-primary rounded-full w-[85%]"></div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- VIP Table Status -->
                <div class="glass-card bg-stone-900 p-6 rounded-3xl">
                    <div class="flex justify-between items-center mb-6">
                        <p class="text-[10px] uppercase tracking-wider text-stone-500 font-bold">TRẠNG THÁI BÀN VIP</p>
                        <button class="text-[10px] border border-stone-800 px-3 py-1 rounded-full text-stone-500 font-bold uppercase">CHI TIẾT</button>
                    </div>
                    <div class="grid grid-cols-4 gap-4">
                        <div class="bg-stone-800/50 p-4 rounded-2xl text-center">
                            <p class="text-2xl font-display font-bold text-primary mb-1">${not empty reservedCount ? reservedCount : '04'}</p>
                            <p class="text-[10px] text-stone-500">Reserved</p>
                        </div>
                        <div class="bg-stone-800/50 p-4 rounded-2xl text-center">
                            <p class="text-2xl font-display font-bold text-blue-400 mb-1">${not empty occupiedCount ? occupiedCount : '08'}</p>
                            <p class="text-[10px] text-stone-500">Seated</p>
                        </div>
                        <div class="bg-stone-800/50 p-4 rounded-2xl text-center border border-primary/20">
                            <p class="text-2xl font-display font-bold text-green-400 mb-1">${not empty availableCount ? availableCount : '15'}</p>
                            <p class="text-[10px] text-stone-500">Available</p>
                        </div>
                        <div class="bg-stone-800/50 p-4 rounded-2xl text-center">
                            <p class="text-2xl font-display font-bold text-orange-400 mb-1">01</p>
                            <p class="text-[10px] text-stone-500">Cleaning</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-span-3">
                <div class="glass-card bg-stone-900 p-6 rounded-3xl h-full">
                    <div class="flex items-center justify-between mb-8">
                        <div>
                            <p class="text-[10px] uppercase tracking-wider text-stone-500 font-bold mb-1">CẢNH BÁO NGUYÊN LIỆU</p>
                            <p class="text-[10px] text-stone-400 italic">Kho trung tâm - Wine Cellar</p>
                        </div>
                        <div class="w-8 h-8 rounded-full bg-red-500/10 flex items-center justify-center border border-red-500/20">
                            <span class="material-icons-round text-red-500 text-sm">priority_high</span>
                        </div>
                    </div>
                    <div class="space-y-6">
                        <div class="p-5 rounded-2xl border-l-4 border-l-red-500 bg-red-500/5">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-display font-bold leading-tight">Château Margaux 2015</h4>
                                <div class="text-right">
                                    <p class="text-xl font-display font-bold text-red-500">03</p>
                                    <p class="text-[10px] text-stone-500 font-bold uppercase">BTLS</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2 text-red-500">
                                <span class="w-1.5 h-1.5 rounded-full bg-red-500 animate-pulse"></span>
                                <span class="text-[10px] font-black uppercase tracking-widest">RESTOCK NOW</span>
                            </div>
                        </div>
                        <div class="p-5 rounded-2xl border-l-4 border-l-orange-400 bg-orange-500/5">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-display font-bold leading-tight">Truffle Đen (Pháp)</h4>
                                <div class="text-right">
                                    <p class="text-xl font-display font-bold text-orange-400">250g</p>
                                    <p class="text-[10px] text-stone-500 font-bold uppercase">WEIGHT</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2 text-orange-400">
                                <span class="w-1.5 h-1.5 rounded-full bg-orange-400"></span>
                                <span class="text-[10px] font-black uppercase tracking-widest">LOW STOCK</span>
                            </div>
                        </div>
                        <div class="p-5 rounded-2xl border-l-4 border-l-primary bg-primary/5">
                            <div class="flex justify-between items-start mb-3">
                                <h4 class="font-display font-bold leading-tight">Gold Leaf Edible</h4>
                                <div class="text-right">
                                    <p class="text-xl font-display font-bold text-primary">10</p>
                                    <p class="text-[10px] text-stone-500 font-bold uppercase">SHEETS</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2 text-primary">
                                <span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
                                <span class="text-[10px] font-black uppercase tracking-widest">MONITOR</span>
                            </div>
                            <p class="text-[9px] text-stone-500 mt-2 italic">Dự kiến đủ cho 5 món tráng miệng</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bottom Section -->
        <div class="mt-6 glass-card bg-stone-900 p-8 rounded-3xl">
            <div class="flex justify-between items-center mb-10">
                <h3 class="text-xl font-display font-bold tracking-tight">Hiệu quả đặt bàn Online</h3>
                <span class="text-xs text-stone-500 font-medium uppercase tracking-widest">TUẦN HIỆN TẠI</span>
            </div>
            <div class="grid grid-cols-2 gap-12">
                <div>
                    <p class="text-[11px] font-bold text-stone-500 uppercase tracking-widest mb-4">TỶ LỆ GIỮ CỌC</p>
                    <div class="flex items-end gap-4 mb-4">
                        <span class="text-6xl font-display font-bold">98%</span>
                        <div class="bg-green-500/10 text-green-500 px-2 py-1 rounded-lg text-sm font-bold mb-2">+ 2%</div>
                    </div>
                    <p class="text-xs text-stone-500 italic mb-6">Khách hàng cao cấp, uy tín cao. Không có trường hợp hủy cọc bất thường tại Vesper.</p>
                    <div class="h-1 bg-stone-800 rounded-full">
                        <div class="h-full bg-green-500 rounded-full w-[98%]"></div>
                    </div>
                </div>
                <div>
                    <p class="text-[11px] font-bold text-stone-500 uppercase tracking-widest mb-4">TỶ LỆ NO-SHOW</p>
                    <div class="flex items-end gap-4 mb-4">
                        <span class="text-6xl font-display font-bold">0.5%</span>
                        <div class="bg-green-500/10 text-green-500 px-2 py-1 rounded-lg text-sm font-bold mb-2">- 0.8%</div>
                    </div>
                    <p class="text-xs text-stone-500 italic mb-6">Hệ thống nhắc hẹn tự động hoạt động tối ưu. Hầu như không có khách bỏ bàn.</p>
                    <div class="h-1 bg-stone-800 rounded-full">
                        <div class="h-full bg-primary rounded-full w-[5%]"></div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
