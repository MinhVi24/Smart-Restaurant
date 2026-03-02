<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Maison D'Or - Thực Đơn Bít Tết Thượng Hạng</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&amp;family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                            "surface-dark": "#25231d",
                            "border-dark": "#37342a",
                            "text-secondary": "#b6b1a0"
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"],
                            "serif": ["Playfair Display", "serif"],
                        },
                        borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                    },
                },
            }
        </script>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 antialiased selection:bg-primary selection:text-white">
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-border-dark px-10 py-5 bg-background-dark/95 backdrop-blur-sm sticky top-0 z-50">
                <div class="flex items-center gap-4 text-white">
                    <div class="size-6 text-primary">
                        <span class="material-symbols-outlined text-3xl">diamond</span>
                    </div>
                    <h2 class="text-white text-2xl font-serif font-bold tracking-tight">Maison D'Or</h2>
                </div>
                <div class="flex flex-1 justify-end gap-8 items-center">
                    <nav class="hidden md:flex items-center gap-9">
                        <a class="text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Thực Đơn</a>
                        <a class="text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Đặt Bàn</a>
                        <a class="text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Về Chúng Tôi</a>
                        <a class="text-white hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Sự Kiện</a>
                    </nav>
                    <div class="flex gap-3">
                        <button class="flex min-w-[84px] cursor-pointer items-center justify-center overflow-hidden rounded-lg h-10 px-6 bg-primary hover:bg-[#c29f2f] transition-colors text-background-dark text-sm font-bold leading-normal tracking-[0.015em]">
                            <span class="truncate">Đặt Bàn</span>
                        </button>
                        <button class="flex size-10 cursor-pointer items-center justify-center overflow-hidden rounded-lg bg-surface-dark hover:bg-[#3d3a31] transition-colors text-white border border-border-dark">
                            <span class="material-symbols-outlined">shopping_bag</span>
                        </button>
                    </div>
                </div>
            </header>
            <main class="layout-container flex h-full grow flex-col items-center">
                <div class="w-full max-w-[1200px] px-4 md:px-10 py-12 flex flex-col gap-16">
                    <section class="flex flex-col gap-6 text-center md:text-left">
                        <div class="flex flex-col gap-4 max-w-3xl">
                            <span class="text-primary font-bold uppercase tracking-widest text-xs">Menu Bữa Tối</span>
                            <h1 class="text-white text-5xl md:text-6xl font-serif font-bold leading-tight">Nghệ Thuật Bít Tết Thượng Hạng</h1>
                            <p class="text-text-secondary text-lg font-light max-w-2xl leading-relaxed">
                                Trải nghiệm ẩm thực đẳng cấp với những phần cắt thượng hạng từ khắp nơi trên thế giới. Mỗi miếng bít tết là một kiệt tác của hương vị và kỹ thuật.
                            </p>
                        </div>
                    </section>
                    <section class="flex flex-col md:flex-row items-center justify-between gap-6 border-b border-border-dark pb-6">
                        <nav class="flex flex-wrap justify-center md:justify-start gap-2 md:gap-8">
                            <a class="text-primary font-bold border-b-2 border-primary pb-1 transition-colors hover:text-primary" href="#">Tất Cả</a>
                            <a class="text-text-secondary hover:text-primary transition-colors pb-1" href="#">Khai Vị</a>
                            <a class="text-text-secondary hover:text-primary transition-colors pb-1" href="#">Bít Tết</a>
                            <a class="text-text-secondary hover:text-primary transition-colors pb-1" href="#">Món Chính</a>
                            <a class="text-text-secondary hover:text-primary transition-colors pb-1" href="#">Món Phụ</a>
                            <a class="text-text-secondary hover:text-primary transition-colors pb-1" href="#">Đồ Uống</a>
                        </nav>
                        <div class="relative w-full md:w-64">
                            <input class="w-full bg-surface-dark border border-border-dark rounded-lg py-2 pl-4 pr-10 text-white placeholder-text-secondary focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary text-sm" placeholder="Tìm kiếm món ăn..." type="text"/>
                            <button class="absolute right-3 top-1/2 -translate-y-1/2 text-primary">
                                <span class="material-symbols-outlined text-[20px]">search</span>
                            </button>
                        </div>
                    </section>
                    <section class="@container">
                        <div class="group relative flex flex-col md:flex-row items-stretch overflow-hidden rounded-xl bg-surface-dark border border-border-dark hover:border-primary/30 transition-all duration-500 shadow-2xl">
                            <div class="relative w-full md:w-3/5 h-[400px] md:h-auto overflow-hidden">
                                <div class="absolute inset-0 bg-cover bg-center transition-transform duration-700 group-hover:scale-105" data-alt="Cận cảnh miếng bò Wagyu A5 vân mỡ đẹp mắt đã được nướng chín tới" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuA7LVpoRhSm4n2h3B1ihBU4JWifqivsBAl2JupaZ9adBuw9yRBk9rZ9BRUh-B5X19PlXa3sUqJqHW132peAAhCpiS__Ww5Jzgar5FDbf5aL89DbQgbm3uo5id03DCwY7SaV_e4kWi0Ai16OIGh3b3evpi6iXGDAOPsbaIMQnpCW9xBWal-AmDDOCE9ZDYKgHCkm4yqC1MmWGMKAY6jOBuRjB7UmLJprSIvcKkGAZ6PKtCB4RfplipjhEd4TT9nRb2qsOgzZI3tMTRDr");'></div>
                                <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent md:bg-gradient-to-r md:from-transparent md:to-surface-dark"></div>
                                <div class="absolute top-6 left-6 flex items-center gap-2 bg-primary/90 backdrop-blur-md px-4 py-1.5 rounded-full shadow-lg">
                                    <span class="material-symbols-outlined text-background-dark text-[18px]">verified</span>
                                    <span class="text-background-dark text-xs font-bold uppercase tracking-wider">Signature</span>
                                </div>
                            </div>
                            <div class="flex flex-col justify-center w-full md:w-2/5 p-8 md:p-12 relative z-10">
                                <div class="mb-2">
                                    <span class="text-primary text-sm tracking-widest uppercase font-bold">Miyazaki, Nhật Bản</span>
                                </div>
                                <h3 class="text-white text-3xl font-serif font-bold mb-4 leading-tight">Wagyu A5 Miyazaki</h3>
                                <p class="text-text-secondary text-base mb-6 leading-relaxed font-light">
                                    Bò Wagyu A5 thượng hạng từ tỉnh Miyazaki. Vân mỡ cẩm thạch hoàn hảo (BMS 11-12), tan chảy ngay trong miệng với hương vị umami đậm đà khó quên.
                                </p>
                                <div class="flex items-center gap-2 mb-8 text-sm text-text-secondary">
                                    <span class="material-symbols-outlined text-primary text-[18px]">wine_bar</span>
                                    <span>Gợi ý: Cabernet Sauvignon 2015</span>
                                </div>
                                <div class="mt-auto pt-6 border-t border-white/10 flex flex-col gap-4">
                                    <div class="flex justify-between items-end">
                                        <span class="text-text-secondary text-sm">Giá theo trọng lượng</span>
                                        <span class="text-primary text-2xl font-serif font-bold">2.500.000₫ <span class="text-sm font-sans font-normal text-text-secondary">/ 100g</span></span>
                                    </div>
                                    <button class="w-full mt-2 cursor-pointer items-center justify-center rounded-lg h-12 bg-primary hover:bg-[#c29f2f] text-background-dark text-sm font-bold uppercase tracking-wider transition-all flex gap-2 group/btn">
                                        <span>Thêm Vào Bữa Tiệc</span>
                                        <span class="material-symbols-outlined group-hover/btn:translate-x-1 transition-transform text-[18px]">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section>
                        <div class="flex items-end justify-between mb-8 pb-4">
                            <h2 class="text-white text-3xl font-serif font-bold">Bộ Sưu Tập Thượng Hạng</h2>
                            <a class="hidden sm:flex items-center gap-1 text-primary text-sm hover:underline" href="#">
                                Xem toàn bộ menu <span class="material-symbols-outlined text-[16px]">chevron_right</span>
                            </a>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="group flex gap-5 p-5 rounded-xl bg-surface-dark hover:bg-[#2e2b24] transition-colors border border-transparent hover:border-primary/20">
                                <div class="shrink-0 w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-gray-800 relative">
                                    <div class="w-full h-full bg-cover bg-center group-hover:scale-110 transition-transform duration-500" data-alt="Miếng thăn lưng bò Ribeye sống với vân mỡ đẹp" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDyNrvhpcYwK49mNvX2CrZUczutIwPTmi7v4u9FNiNnO1faW4RGeBaaA_Cd1yTB5lnFuWnxqoAN9GPle-43C6meVD7_M8dNF11L9MyntmsMB94aS-0Td5-pHiBnTjGQRmaEWCfZeo5wCLfSb8fGTqhTuAuoyZZT-HQdHFfL5bHuo_VC4sjdUueaK7xlmUtauj0XUze7Zf6UmdNvHtYh6z__20mIR8WQGywdQo_5GK313efZNQ311QCFkliT6nVCqJ5WvAx-oEiDBGwe");'></div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between">
                                    <div>
                                        <div class="flex justify-between items-start mb-1">
                                            <h3 class="text-white text-xl font-serif font-bold group-hover:text-primary transition-colors">Thăn Lưng Black Angus</h3>
                                        </div>
                                        <p class="text-text-secondary text-sm mb-2">Ribeye • USDA Prime • Dry-aged 45 ngày</p>
                                        <p class="text-gray-400 text-sm line-clamp-2">Hương vị hạt dẻ đặc trưng nhờ quá trình ủ khô, kết cấu mềm mại vừa phải.</p>
                                    </div>
                                    <div class="flex justify-between items-center mt-4 pt-3 border-t border-white/5">
                                        <span class="text-primary text-lg font-bold whitespace-nowrap">1.200.000₫</span>
                                        <button class="bg-primary/10 hover:bg-primary text-primary hover:text-background-dark px-3 py-1.5 rounded text-xs font-bold uppercase tracking-wider flex items-center gap-1 transition-colors">
                                            Thêm
                                            <span class="material-symbols-outlined text-[16px]">add_circle</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="group flex gap-5 p-5 rounded-xl bg-surface-dark hover:bg-[#2e2b24] transition-colors border border-transparent hover:border-primary/20">
                                <div class="shrink-0 w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-gray-800 relative">
                                    <div class="w-full h-full bg-cover bg-center group-hover:scale-110 transition-transform duration-500" data-alt="Miếng thăn nội bò Tenderloin đã nướng medium rare" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuA4Ob1pkbJdilsQlwRR9BxjeYdr1C2M92mdOjczrEPxG2yJ6eB2c5zIbr39ZIkgCv5fit3QQfSnJTGpxhhiIU66Osoc271yWhU-YCc-6IiY2LxuXo0SlcLMhLrdKhNRPOChGr0GQ6RoWekfqbTd3mIDcoA3nUX9zelg-rRBQUej17MoZEX6GelL9BBY41HbVzPPrhJ67skJqdzFedKrnTfpxmWJg0UjYwHC7X0tNC271x9t4pAqSpEcw_BEVgYZkhfk65MSFbZXbWUc");'></div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between">
                                    <div>
                                        <div class="flex justify-between items-start mb-1">
                                            <h3 class="text-white text-xl font-serif font-bold group-hover:text-primary transition-colors">Thăn Nội Tenderloin</h3>
                                        </div>
                                        <p class="text-text-secondary text-sm mb-2">Chateaubriand • Úc • Grass-fed</p>
                                        <p class="text-gray-400 text-sm line-clamp-2">Phần thịt mềm nhất, ít mỡ, hương vị thanh tao tinh tế. Phù hợp với người thích thịt nạc.</p>
                                    </div>
                                    <div class="flex justify-between items-center mt-4 pt-3 border-t border-white/5">
                                        <span class="text-primary text-lg font-bold whitespace-nowrap">1.450.000₫</span>
                                        <button class="bg-primary/10 hover:bg-primary text-primary hover:text-background-dark px-3 py-1.5 rounded text-xs font-bold uppercase tracking-wider flex items-center gap-1 transition-colors">
                                            Thêm
                                            <span class="material-symbols-outlined text-[16px]">add_circle</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="group flex gap-5 p-5 rounded-xl bg-surface-dark hover:bg-[#2e2b24] transition-colors border border-transparent hover:border-primary/20">
                                <div class="shrink-0 w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-gray-800 relative">
                                    <div class="w-full h-full bg-cover bg-center group-hover:scale-110 transition-transform duration-500" data-alt="Sườn bò Tomahawk khổng lồ nướng trên than" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCGrLh50Ld7gOVKPseWFYlQjmltDVenlFam3ZYYlBRsLrs3twckGm5hgCgnQhHsB3aUDIfiWfAaM8vlfCskGOyC9HwgxDsRX4Sb7ZQ9qcszN2mASzdurRzT4fhEz9H3PJPcAF4VlsdSCO-ZAizM6xaNEtV2SOYC0i_enwUJYUfGSxV0U7Cgh3JikYe93UV1cg4WJ0dL6ZV3VeaHZfnrWptBcS7_GY4dxllgNF_xvTYamzgcYUtnLsdd38XOugeMSbZX70bjXMgwFlzn");'></div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between">
                                    <div>
                                        <div class="flex justify-between items-start mb-1">
                                            <h3 class="text-white text-xl font-serif font-bold group-hover:text-primary transition-colors">Tomahawk Dát Vàng</h3>
                                        </div>
                                        <p class="text-text-secondary text-sm mb-2">Wagyu F1 • Úc • Gold Leaf 24K</p>
                                        <p class="text-gray-400 text-sm line-clamp-2">Trải nghiệm xa xỉ với sườn bò nguyên xương phủ vàng lá 24K. Ấn tượng thị giác mạnh mẽ.</p>
                                    </div>
                                    <div class="flex justify-between items-center mt-4 pt-3 border-t border-white/5">
                                        <span class="text-primary text-lg font-bold whitespace-nowrap">4.500.000₫</span>
                                        <button class="bg-primary/10 hover:bg-primary text-primary hover:text-background-dark px-3 py-1.5 rounded text-xs font-bold uppercase tracking-wider flex items-center gap-1 transition-colors">
                                            Thêm
                                            <span class="material-symbols-outlined text-[16px]">add_circle</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="group flex gap-5 p-5 rounded-xl bg-surface-dark hover:bg-[#2e2b24] transition-colors border border-transparent hover:border-primary/20">
                                <div class="shrink-0 w-24 h-24 sm:w-32 sm:h-32 rounded-lg overflow-hidden bg-gray-800 relative">
                                    <div class="w-full h-full bg-cover bg-center group-hover:scale-110 transition-transform duration-500" data-alt="Miếng thăn ngoại Striploin nướng xém cạnh" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAcmGdQRWakefDYTRG2JWgz-uHlwtva5aghyAzCnJGtj1hDFa2dMkJYi21_ZlPUWRmLuE7YfL6uPjfQOFrSpMpUd8QJeKkrpTpp5yHyehY1jfiV-kQVUsSpyi1lKMEEX-O9F6hg39DXr59NOjO7Yybu2ddDnWknjiOiSqPYik6kJHvttirX19DsnJQbZ9U3cfHQnqbbaP3zzhTSHBlBfrK2cby5bNrkdWA7K2kPouH20b0avJv2OF2GgisfzHCXvEVxrrr9TQkmdL_L");'></div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between">
                                    <div>
                                        <div class="flex justify-between items-start mb-1">
                                            <h3 class="text-white text-xl font-serif font-bold group-hover:text-primary transition-colors">Thăn Ngoại Striploin</h3>
                                        </div>
                                        <p class="text-text-secondary text-sm mb-2">New York Strip • Canada • Corn-fed</p>
                                        <p class="text-gray-400 text-sm line-clamp-2">Cân bằng hoàn hảo giữa độ mềm và hương vị bò đậm đà. Viền mỡ ngoài giòn tan.</p>
                                    </div>
                                    <div class="flex justify-between items-center mt-4 pt-3 border-t border-white/5">
                                        <span class="text-primary text-lg font-bold whitespace-nowrap">950.000₫</span>
                                        <button class="bg-primary/10 hover:bg-primary text-primary hover:text-background-dark px-3 py-1.5 rounded text-xs font-bold uppercase tracking-wider flex items-center gap-1 transition-colors">
                                            Thêm
                                            <span class="material-symbols-outlined text-[16px]">add_circle</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section class="grid md:grid-cols-2 gap-12 border-t border-border-dark pt-12">
                        <div>
                            <div class="flex items-center gap-3 mb-6">
                                <span class="material-symbols-outlined text-primary text-2xl">soup_kitchen</span>
                                <h3 class="text-white text-2xl font-serif font-bold">Món Ăn Kèm</h3>
                            </div>
                            <div class="grid gap-4">
                                <div class="flex justify-between items-center py-3 border-b border-white/5 hover:bg-white/5 px-2 rounded transition-colors group">
                                    <div>
                                        <p class="text-white font-medium">Khoai tây nghiền Truffle</p>
                                        <p class="text-text-secondary text-xs mt-0.5">Nấm Truffle đen, bơ Pháp</p>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <span class="text-primary font-bold">180.000₫</span>
                                        <button class="text-white/50 hover:text-primary transition-colors">
                                            <span class="material-symbols-outlined text-[20px]">add</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="flex justify-between items-center py-3 border-b border-white/5 hover:bg-white/5 px-2 rounded transition-colors group">
                                    <div>
                                        <p class="text-white font-medium">Măng tây nướng than hoa</p>
                                        <p class="text-text-secondary text-xs mt-0.5">Parmesan bào, dầu oliu chanh</p>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <span class="text-primary font-bold">150.000₫</span>
                                        <button class="text-white/50 hover:text-primary transition-colors">
                                            <span class="material-symbols-outlined text-[20px]">add</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="flex justify-between items-center py-3 border-b border-white/5 hover:bg-white/5 px-2 rounded transition-colors group">
                                    <div>
                                        <p class="text-white font-medium">Rau chân vịt xào kem</p>
                                        <p class="text-text-secondary text-xs mt-0.5">Kem tươi, tỏi phi</p>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <span class="text-primary font-bold">140.000₫</span>
                                        <button class="text-white/50 hover:text-primary transition-colors">
                                            <span class="material-symbols-outlined text-[20px]">add</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="flex items-center gap-3 mb-6">
                                <span class="material-symbols-outlined text-primary text-2xl">opacity</span>
                                <h3 class="text-white text-2xl font-serif font-bold">Sốt Đặc Trưng</h3>
                            </div>
                            <div class="grid grid-cols-2 gap-3">
                                <button class="p-4 rounded-lg bg-surface-dark border border-border-dark hover:border-primary text-left transition-all group">
                                    <p class="text-white font-medium group-hover:text-primary mb-1">Sốt Vang Đỏ</p>
                                    <p class="text-text-secondary text-xs">Red Wine Jus</p>
                                </button>
                                <button class="p-4 rounded-lg bg-surface-dark border border-border-dark hover:border-primary text-left transition-all group">
                                    <p class="text-white font-medium group-hover:text-primary mb-1">Sốt Tiêu Đen</p>
                                    <p class="text-text-secondary text-xs">Phú Quốc Peppercorn</p>
                                </button>
                                <button class="p-4 rounded-lg bg-surface-dark border border-border-dark hover:border-primary text-left transition-all group">
                                    <p class="text-white font-medium group-hover:text-primary mb-1">Sốt Nấm</p>
                                    <p class="text-text-secondary text-xs">Wild Mushroom</p>
                                </button>
                                <button class="p-4 rounded-lg bg-surface-dark border border-border-dark hover:border-primary text-left transition-all group">
                                    <p class="text-white font-medium group-hover:text-primary mb-1">Sốt Phô Mai Xanh</p>
                                    <p class="text-text-secondary text-xs">Blue Cheese</p>
                                </button>
                            </div>
                        </div>
                    </section>
                </div>
            </main>
            <footer class="flex justify-center bg-surface-dark border-t border-border-dark py-10 px-10">
                <div class="flex flex-col items-center gap-4 text-center">
                    <div class="flex items-center gap-2 text-white opacity-80">
                        <span class="material-symbols-outlined text-primary">diamond</span>
                        <span class="font-serif font-bold text-lg">Maison D'Or</span>
                    </div>
                    <p class="text-text-secondary text-sm">© 2024 Maison D'Or Luxury Steakhouse. All rights reserved.</p>
                </div>
            </footer>
        </div>

    </body></html>