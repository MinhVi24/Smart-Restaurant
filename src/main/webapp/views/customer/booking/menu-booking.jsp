<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Luxury Restaurant Menu Selection</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700&amp;family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&amp;display=swap" rel="stylesheet"/>
        <!-- Material Symbols -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <!-- Tailwind Config -->
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#e2ba36", // Champagne Gold
                            "background-light": "#f8f7f6",
                            "background-dark": "#171611", // Deep Charcoal Black
                            "surface-dark": "#211d11",
                            "border-gold": "#383429",
                        },
                        fontFamily: {
                            display: ["Playfair Display", "serif"],
                            sans: ["Manrope", "sans-serif"],
                        },
                        borderRadius: {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "2xl": "1rem",
                            "full": "9999px"
                        },
                        backgroundImage: {
                            'gradient-gold': 'linear-gradient(135deg, #e2ba36 0%, #c49a18 100%)',
                            'glass-dark': 'linear-gradient(180deg, rgba(23, 22, 17, 0) 0%, rgba(23, 22, 17, 0.8) 50%, rgba(23, 22, 17, 1) 100%)',
                        }
                    },
                },
            }
        </script>
        <style>
            /* Custom scrollbar for menu list */
            .custom-scrollbar::-webkit-scrollbar {
                width: 4px;
            }
            .custom-scrollbar::-webkit-scrollbar-track {
                background: #211d11;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb {
                background: #383429;
                border-radius: 4px;
            }
            .custom-scrollbar::-webkit-scrollbar-thumb:hover {
                background: #e2ba36;
            }
            body {
                font-family: 'Manrope', sans-serif;
                background-color: #171611;
                color: #f8f7f6;
            }
            h1, h2, h3, h4, h5, h6, .font-serif {
                font-family: 'Playfair Display', serif;
            }
        </style>
    </head>
    <body class="bg-background-dark min-h-screen flex flex-col overflow-hidden">
        <!-- Top Navigation (Based on provided component) -->
        <div class="w-full bg-background-dark border-b border-border-gold z-50">
            <div class="px-4 md:px-10 py-3 flex items-center justify-between">
                <div class="flex items-center gap-4 text-white">
                    <div class="size-8 text-primary">
                        <span class="material-symbols-outlined text-3xl">restaurant_menu</span>
                    </div>
                    <h2 class="text-white text-lg font-bold leading-tight tracking-wide font-serif">LUXURIA DINING</h2>
                </div>
                <!-- Desktop Menu -->
                <div class="hidden md:flex flex-1 justify-end gap-8 items-center">
                    <div class="flex items-center gap-9">
                        <a class="text-white/70 hover:text-primary transition-colors text-sm font-medium" href="#">Trang chủ</a>
                        <a class="text-primary text-sm font-medium border-b border-primary" href="#">Thực đơn</a>
                        <a class="text-white/70 hover:text-primary transition-colors text-sm font-medium" href="#">Đặt bàn</a>
                        <a class="text-white/70 hover:text-primary transition-colors text-sm font-medium" href="#">Liên hệ</a>
                    </div>
                    <div class="flex gap-4">
                        <button class="flex items-center justify-center rounded-lg h-10 px-4 bg-transparent border border-border-gold hover:border-primary text-white hover:text-primary text-sm font-bold transition-all">
                            <span>Đăng nhập</span>
                        </button>
                        <button class="relative flex items-center justify-center rounded-lg h-10 w-10 bg-primary text-background-dark hover:bg-white transition-all">
                            <span class="material-symbols-outlined text-[20px]">shopping_cart</span>
                            <span class="absolute -top-1 -right-1 flex h-4 w-4 items-center justify-center rounded-full bg-red-500 text-[10px] text-white font-bold">2</span>
                        </button>
                    </div>
                </div>
                <!-- Mobile Menu Icon -->
                <div class="md:hidden text-white">
                    <span class="material-symbols-outlined">menu</span>
                </div>
            </div>
        </div>
        <!-- Breadcrumbs / Steps -->
        <div class="bg-surface-dark border-b border-border-gold px-4 md:px-10 py-4">
            <div class="flex flex-wrap gap-2 items-center justify-center md:justify-start">
                <a class="text-white/40 text-sm font-medium flex items-center gap-1" href="#">
                    <span class="material-symbols-outlined text-base">check_circle</span>
                    1. Chọn Bàn
                </a>
                <span class="text-white/20 text-sm mx-2">/</span>
                <span class="text-primary text-sm font-bold flex items-center gap-1">
                    <span class="bg-primary text-background-dark rounded-full w-5 h-5 flex items-center justify-center text-xs">2</span>
                    2. Chọn Thực Đơn
                </span>
                <span class="text-white/20 text-sm mx-2">/</span>
                <span class="text-white/40 text-sm font-medium">3. Xác Nhận</span>
            </div>
        </div>
        <!-- Main Content: Split Layout -->
        <div class="flex-1 flex flex-col md:flex-row overflow-hidden relative">
            <!-- Left Side: Menu List (Scrollable) -->
            <div class="w-full md:w-5/12 lg:w-4/12 flex flex-col bg-background-dark h-full border-r border-border-gold z-10 custom-scrollbar overflow-y-auto pb-24">
                <!-- Filter Categories -->
                <div class="sticky top-0 bg-background-dark/95 backdrop-blur-md z-20 border-b border-border-gold p-4">
                    <div class="flex gap-3 overflow-x-auto pb-2 no-scrollbar">
                        <button class="whitespace-nowrap flex items-center gap-2 px-4 py-2 rounded-full bg-primary text-background-dark font-bold text-sm shadow-lg shadow-primary/20">
                            <span class="material-symbols-outlined text-lg">tapas</span>
                            Khai vị
                        </button>
                        <button class="whitespace-nowrap flex items-center gap-2 px-4 py-2 rounded-full bg-surface-dark text-white/70 hover:text-white border border-border-gold hover:border-primary transition-colors text-sm font-medium">
                            <span class="material-symbols-outlined text-lg">restaurant</span>
                            Món chính
                        </button>
                        <button class="whitespace-nowrap flex items-center gap-2 px-4 py-2 rounded-full bg-surface-dark text-white/70 hover:text-white border border-border-gold hover:border-primary transition-colors text-sm font-medium">
                            <span class="material-symbols-outlined text-lg">icecream</span>
                            Tráng miệng
                        </button>
                        <button class="whitespace-nowrap flex items-center gap-2 px-4 py-2 rounded-full bg-surface-dark text-white/70 hover:text-white border border-border-gold hover:border-primary transition-colors text-sm font-medium">
                            <span class="material-symbols-outlined text-lg">wine_bar</span>
                            Rượu vang
                        </button>
                    </div>
                    <div class="mt-4 relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-white/40">search</span>
                        <input class="w-full bg-surface-dark border border-border-gold rounded-lg py-2.5 pl-10 pr-4 text-white placeholder-white/40 focus:outline-none focus:border-primary transition-colors text-sm" placeholder="Tìm kiếm món ăn..." type="text"/>
                    </div>
                </div>
                <!-- Menu Items List -->
                <div class="p-4 space-y-6">
                    <!-- Section Title -->
                    <h3 class="text-primary text-xl font-serif italic mb-4 px-2">Khai vị hảo hạng</h3>
                    <!-- Item 1 -->
                    <div class="group flex gap-4 p-3 rounded-xl hover:bg-surface-dark transition-all cursor-pointer border border-transparent hover:border-border-gold relative overflow-hidden">
                        <div class="w-24 h-24 shrink-0 rounded-lg overflow-hidden relative">
                            <img alt="Sò điệp áp chảo sốt kem" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" data-alt="Close up of pan seared scallops on a dark plate" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAUJrCoGBlyrN8WWw0cKRYb2vyNfJ8rpSjwC-ymQerIlYh8x8LG-OR1_2c_vLbtZnSAWhi4ovZouv4KFTxVZmMr_TyB6wAQta9xGyG8j4eEPQBQlngP50XauKacdZYEv37opj8PfnumAjCMe0azSaIdJ4kCgQeMLM4EHwFYiJaAjien4TLr-31P-4vow-BO69i1q35BThMqEqySyPsdwXV5NNlNkS7sP7r5cF-JicXoFwtxydmrrvKClWSeYpvNLkAO8kEy-WtzFWR5"/>
                        </div>
                        <div class="flex-1 flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start">
                                    <h4 class="text-white font-serif text-lg leading-snug group-hover:text-primary transition-colors">Sò Điệp Hokkaido Áp Chảo</h4>
                                    <span class="text-primary font-bold text-sm">850.000₫</span>
                                </div>
                                <p class="text-white/50 text-xs mt-1 line-clamp-2">Sốt kem bơ chanh, trứng cá tầm đen Caviar và lá thơm.</p>
                            </div>
                            <button class="self-end mt-2 flex items-center gap-1 text-xs font-bold text-primary uppercase tracking-wider hover:text-white transition-colors">
                                <span class="material-symbols-outlined text-sm">add</span> Thêm món
                            </button>
                        </div>
                    </div>
                    <!-- Item 2 (Active State Simulation) -->
                    <div class="group flex gap-4 p-3 rounded-xl bg-surface-dark border border-primary/30 cursor-pointer relative overflow-hidden">
                        <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary"></div>
                        <div class="w-24 h-24 shrink-0 rounded-lg overflow-hidden relative">
                            <img alt="Gà nướng thảo mộc" class="w-full h-full object-cover" data-alt="Roasted chicken with herbs on a ceramic plate" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCS6XGSrXEMEwxCZ6Zf39tL0jztb260kb0hJUt0g5Va3PmnmpLB_yTEpY4UlDwbXlPNEUMexH7Gi5nJ82DgprbD8gv5p2nzQSHgHniWqFhCo9SgQK7027cWkc1I785pO90_U0uj_T4rIyMeZh6vx1n4tnG62a3NtrDlBC3rB3zoEIbbq1Rfmw4_O4E270JneRNQzMIn2_KUOp84JkxbVeo-5cxM-FiguzHywJ3q_QT39DL-URd5zw02Zw-983n5nlqvaGY6kM8KV0uX"/>
                        </div>
                        <div class="flex-1 flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start">
                                    <h4 class="text-white font-serif text-lg leading-snug text-primary">Gan Ngỗng Pháp Áp Chảo</h4>
                                    <span class="text-primary font-bold text-sm">1.250.000₫</span>
                                </div>
                                <p class="text-white/50 text-xs mt-1 line-clamp-2">Kèm sốt quả mọng, bánh mì Brioche nướng giòn và nấm Truffle.</p>
                            </div>
                            <div class="self-end mt-2 flex items-center gap-3">
                                <div class="flex items-center bg-background-dark rounded-lg border border-border-gold h-7">
                                    <button class="px-2 text-white/50 hover:text-white">-</button>
                                    <span class="text-white text-xs font-bold px-1">1</span>
                                    <button class="px-2 text-white/50 hover:text-white">+</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Item 3 -->
                    <div class="group flex gap-4 p-3 rounded-xl hover:bg-surface-dark transition-all cursor-pointer border border-transparent hover:border-border-gold relative overflow-hidden">
                        <div class="w-24 h-24 shrink-0 rounded-lg overflow-hidden relative">
                            <img alt="Salad cá hồi hun khói" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" data-alt="Smoked salmon salad with avocado and greens" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZDUbzBh7Dj7PxVvL6j3F6BuS1wtR73N7alJz3zUOHmy6sWHcCqetqkyux8-8D3tqT2bsIiWQl_NNtkujOrIw4wCoZ0FYdVo3GWJZ5zXMui60cYm_t4pLFhI103FB5RYLhWK7b5EZ_mGFPjitS-1O2eMtMDnHAwQpyo_WveW0xq80cKZkaoqO95YUSUpjlQ0HOdcZMyH0b5v5TULu4k872Wc4CeirI9ysyTiL2OypiHUG04dk15VMH0312y-nuW1et1qT-JTZ52UNg"/>
                        </div>
                        <div class="flex-1 flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start">
                                    <h4 class="text-white font-serif text-lg leading-snug group-hover:text-primary transition-colors">Salad Cá Hồi Nauy</h4>
                                    <span class="text-primary font-bold text-sm">450.000₫</span>
                                </div>
                                <p class="text-white/50 text-xs mt-1 line-clamp-2">Cá hồi hun khói lạnh, bơ sáp, sốt chanh leo và rau mầm organic.</p>
                            </div>
                            <button class="self-end mt-2 flex items-center gap-1 text-xs font-bold text-primary uppercase tracking-wider hover:text-white transition-colors">
                                <span class="material-symbols-outlined text-sm">add</span> Thêm món
                            </button>
                        </div>
                    </div>
                    <!-- Item 4 -->
                    <div class="group flex gap-4 p-3 rounded-xl hover:bg-surface-dark transition-all cursor-pointer border border-transparent hover:border-border-gold relative overflow-hidden">
                        <div class="w-24 h-24 shrink-0 rounded-lg overflow-hidden relative">
                            <img alt="Súp bí đỏ kem tươi" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" data-alt="Pumpkin soup in a white bowl with cream swirl" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCcxYpTSUMNTxXZkqbpF7v1r7LmKWxO79X710F02xIVM1oMKiClxsXihm0jHzFkJ8JyyQzQE_HKk2Tl1JfcLILt7xAIy8tISUrrEKHkCC7vq2N-2P-atQbh9qVXrvbo5gOMiFQY5kMoWuLLj4m-_gnhHngmHC7O8iLnGXwg_ZjEFbTcFVGTpmxU8pUQXUcRn6VoEJh63wjs0gxHTFnl77w6zI9nAxfRHiVNwgNEIMSzBrH5Db7zQTRvoFp9LoNsSkMNmKPuut6q6WDM"/>
                        </div>
                        <div class="flex-1 flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start">
                                    <h4 class="text-white font-serif text-lg leading-snug group-hover:text-primary transition-colors">Súp Bí Đỏ Hạt Dẻ</h4>
                                    <span class="text-primary font-bold text-sm">280.000₫</span>
                                </div>
                                <p class="text-white/50 text-xs mt-1 line-clamp-2">Nấu chậm với kem tươi, hạt dẻ nướng và bánh mì croutons.</p>
                            </div>
                            <button class="self-end mt-2 flex items-center gap-1 text-xs font-bold text-primary uppercase tracking-wider hover:text-white transition-colors">
                                <span class="material-symbols-outlined text-sm">add</span> Thêm món
                            </button>
                        </div>
                    </div>
                    <!-- Item 5 -->
                    <div class="group flex gap-4 p-3 rounded-xl hover:bg-surface-dark transition-all cursor-pointer border border-transparent hover:border-border-gold relative overflow-hidden">
                        <div class="w-24 h-24 shrink-0 rounded-lg overflow-hidden relative">
                            <img alt="Thịt bò Carpaccio" class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500" data-alt="Beef Carpaccio with parmesan cheese and arugula" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCe20HjzdAOtPgfCM6SHalG8AQXeJk6R9KEA4jzYpY1Y4HfaeBP-VIwF-yb0sg3Jg16GhWYGxzeoya6b0bNTLgl7EN6V_XKENRHBHCB4cBmOzmdVRdKvFicnD8K6QO5mdK0nQZYDKfdi7YlJzIdo3zs2dI0_cW-ZV8BsjpGXceZvTYdxLwjSOiFHare-wPb3xQFYajuq4SHo42Ef2Fuq4jUI0pVyahH_i_nMPSXTPDdX0hfJVjqaYqhL-55jxIjyKJpsn_CMHbF1GLr"/>
                        </div>
                        <div class="flex-1 flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start">
                                    <h4 class="text-white font-serif text-lg leading-snug group-hover:text-primary transition-colors">Bò Wagyu Carpaccio</h4>
                                    <span class="text-primary font-bold text-sm">950.000₫</span>
                                </div>
                                <p class="text-white/50 text-xs mt-1 line-clamp-2">Thịt bò sống thái lát mỏng, phô mai Parmesan và dầu nấm Truffle.</p>
                            </div>
                            <button class="self-end mt-2 flex items-center gap-1 text-xs font-bold text-primary uppercase tracking-wider hover:text-white transition-colors">
                                <span class="material-symbols-outlined text-sm">add</span> Thêm món
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Right Side: Featured Dish Image (Hidden on Mobile, Visible on Desktop) -->
            <div class="hidden md:block md:w-7/12 lg:w-8/12 relative bg-surface-dark overflow-hidden">
                <img alt="Featured Dish Background" class="absolute inset-0 w-full h-full object-cover opacity-80" data-alt="High angle view of a gourmet dish on a dark table setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCc3rzkDGdEEb7xC19G7Bg0MRpjwpq-GI6tx6U32ESz4T5lJ2D6rNFTWAf-i0Z0xcCL3RBs61PdC1YehRpil19tecU5r0QvZMXkzyqhqwEa734Yv9bdWjzexr3d1hAOxqPAbfY9OMqDOSHCnt9mPd_YilyrHcr0ZPLuFCqHRVKRkqi80S7w3MSYrUtyJ8bZZl8oT6MOhCsxZ78expOM9rW0Jy6bn7LihSdtyBeioKWlRE7IizFsMDhh_FQJg_0euxc4sG_h3hUG9LTI"/>
                <!-- Overlay Gradient -->
                <div class="absolute inset-0 bg-glass-dark"></div>
                <!-- Dish Details Overlay -->
                <div class="absolute bottom-24 left-10 right-10 flex items-end justify-between">
                    <div class="max-w-xl">
                        <div class="flex items-center gap-3 mb-3">
                            <span class="px-3 py-1 rounded-full border border-primary/50 text-primary text-xs uppercase tracking-widest font-bold bg-black/40 backdrop-blur-sm">Signature Dish</span>
                            <div class="flex text-primary">
                                <span class="material-symbols-outlined text-sm fill-current">star</span>
                                <span class="material-symbols-outlined text-sm fill-current">star</span>
                                <span class="material-symbols-outlined text-sm fill-current">star</span>
                                <span class="material-symbols-outlined text-sm fill-current">star</span>
                                <span class="material-symbols-outlined text-sm fill-current">star</span>
                            </div>
                        </div>
                        <h1 class="text-5xl font-serif text-white font-bold mb-4 leading-tight drop-shadow-2xl">
                            Gan Ngỗng Pháp <br/> <span class="text-primary italic">Áp Chảo</span>
                        </h1>
                        <p class="text-white/80 text-lg font-light leading-relaxed mb-6 border-l-2 border-primary pl-4">
                            Gan ngỗng béo ngậy nhập khẩu trực tiếp từ Pháp, áp chảo vàng giòn bên ngoài, mềm tan bên trong. Phục vụ cùng sốt quả mọng chua ngọt cân bằng vị giác.
                        </p>
                        <div class="flex flex-wrap gap-4 text-sm text-white/60 font-medium">
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-primary text-base">spa</span> Foie Gras</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-primary text-base">eco</span> Organic Berries</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-primary text-base">local_fire_department</span> 350 Kcal</span>
                        </div>
                    </div>
                    <div class="flex flex-col items-end gap-2">
                        <span class="text-white/60 text-sm uppercase tracking-wider">Giá mỗi phần</span>
                        <span class="text-4xl font-serif text-white font-bold">1.250.000<span class="text-2xl align-top text-primary">₫</span></span>
                        <button class="mt-4 px-8 py-4 bg-primary hover:bg-white text-background-dark font-bold text-base rounded-lg transition-all shadow-[0_0_20px_rgba(226,186,54,0.3)] hover:shadow-[0_0_30px_rgba(226,186,54,0.5)] flex items-center gap-2">
                            Thêm vào thực đơn
                            <span class="material-symbols-outlined">arrow_forward</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Floating Footer Action Bar -->
        <div class="fixed bottom-0 left-0 right-0 bg-[#171611]/90 backdrop-blur-xl border-t border-border-gold py-4 px-6 md:px-12 z-50">
            <div class="max-w-[1400px] mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
                <!-- Selection Summary -->
                <div class="flex items-center gap-6 w-full md:w-auto justify-between md:justify-start">
                    <div class="flex items-center gap-3">
                        <div class="relative">
                            <span class="material-symbols-outlined text-3xl text-white/50">soup_kitchen</span>
                            <div class="absolute -top-1 -right-1 size-4 bg-primary rounded-full flex items-center justify-center text-[10px] text-background-dark font-bold">2</div>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-white/40 text-xs font-bold uppercase tracking-wider">Đã chọn</span>
                            <span class="text-white font-medium">2 món ăn</span>
                        </div>
                    </div>
                    <div class="w-px h-8 bg-white/10 hidden md:block"></div>
                    <div class="flex flex-col text-right md:text-left">
                        <span class="text-white/40 text-xs font-bold uppercase tracking-wider">Tạm tính</span>
                        <span class="text-primary text-xl font-bold font-serif">2.100.000₫</span>
                    </div>
                </div>
                <!-- Action Button -->
                <button class="w-full md:w-auto bg-gradient-gold hover:brightness-110 text-background-dark font-bold text-sm md:text-base py-3 px-8 rounded-lg shadow-lg flex items-center justify-center gap-2 transition-all transform active:scale-95">
                    Tiếp Tục Đến Hoàn Tất
                    <span class="material-symbols-outlined">check_circle</span>
                </button>
            </div>
        </div>
    </body></html>