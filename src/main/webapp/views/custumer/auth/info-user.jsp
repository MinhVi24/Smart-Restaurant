<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Maison D'Or - User Profile</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#d4af35",
                            "background-light": "#f8f7f6",
                            "background-dark": "#201d12",
                            "charcoal": "#1a1a1a",
                            "surface": "#2a271f",
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"]
                        },
                        borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                    },
                },
            }
        </script>
        <style>
            /* Custom scrollbar for a cleaner look */
            ::-webkit-scrollbar {
                width: 8px;
            }
            ::-webkit-scrollbar-track {
                background: #201d12;
            }
            ::-webkit-scrollbar-thumb {
                background: #37342a;
                border-radius: 4px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #d4af35;
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 font-display min-h-screen flex flex-col overflow-x-hidden">
        <!-- Top Navigation Bar -->
        <header class="sticky top-0 z-50 w-full bg-[#171612] border-b border-[#37342a] px-4 sm:px-10 py-3 shadow-lg">
            <div class="max-w-[1280px] mx-auto flex items-center justify-between">
                <!-- Logo Section -->
                <div class="flex items-center gap-4 text-white">
                    <div class="size-8 text-primary">
                        <svg fill="currentColor" viewbox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 4H17.3334V17.3334H30.6666V30.6666H44V44H4V4Z"></path>
                        </svg>
                    </div>
                    <h2 class="text-white text-xl font-bold leading-tight tracking-[-0.015em]">Maison D'Or</h2>
                </div>
                <!-- Navigation Links -->
                <div class="hidden lg:flex items-center gap-9">
                    <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Trang chủ</a>
                    <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Thực đơn</a>
                    <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Đặt bàn</a>
                    <a class="text-white/80 hover:text-primary transition-colors text-sm font-medium leading-normal" href="#">Tin tức</a>
                </div>
                <!-- User Actions -->
                <div class="flex items-center gap-4 relative">
                    <!-- Notifications -->
                    <button class="relative flex items-center justify-center size-10 rounded-full bg-[#37342a] text-white hover:bg-[#4a4639] transition-colors group">
                        <span class="material-symbols-outlined text-[20px] group-hover:text-primary transition-colors">notifications</span>
                        <span class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border border-[#37342a]"></span>
                    </button>
                    <!-- User Profile Trigger & Dropdown Wrapper -->
                    <div class="relative group">
                        <!-- Trigger Button -->
                        <button class="flex items-center gap-3 pl-4 pr-2 py-1.5 bg-[#2a271f] hover:bg-[#37342a] border border-[#37342a] hover:border-primary/50 rounded-full transition-all duration-300 group-hover:ring-2 group-hover:ring-primary/20">
                            <span class="text-sm font-bold text-primary truncate max-w-[100px] hidden sm:block">Nguyễn Hoàng</span>
                            <div class="size-8 rounded-full bg-cover bg-center border border-primary/30" data-alt="User profile picture of a man in a suit" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDb4JFUtpKpHPsnpusJIiGHnQLHJgDdvds2SUzLYVNXgR92AkvhhqfHMHl_pyWJz3sqRSTfENvbgYc09J-5bpM6tsn2hngsC_PFI4yq5_Nz7_eMauSDbhdrOfQwSRlawgEADwukVrvlj2f-VQmZZWXlswQkaKwxCj3enP_HcI1QdFEL4U1hA1E4mLmGSAxnU-3H13v-SnCI2ULN2WzrbNkop3K74SAYW8rOdxUB3v3tKjRmJNii44VlebhT-1ahYKCvoL7IBGjwmJOc');"></div>
                            <span class="material-symbols-outlined text-white/50 text-sm group-hover:text-primary transition-transform duration-300 group-hover:rotate-180">expand_more</span>
                        </button>
                        <!-- Dropdown Menu -->
                        <!-- Note: In a real app, JS would toggle visibility. Here we simulate the open state or use hover for demo purposes -->
                        <div class="absolute right-0 top-full mt-2 w-72 origin-top-right rounded-xl bg-charcoal border border-primary/30 shadow-[0_10px_40px_-10px_rgba(0,0,0,0.8)] backdrop-blur-sm z-50 overflow-hidden transform opacity-0 scale-95 group-hover:opacity-100 group-hover:scale-100 transition-all duration-200 visible pointer-events-none group-hover:pointer-events-auto">
                            <!-- Dropdown Header -->
                            <div class="px-5 py-4 border-b border-white/10 bg-gradient-to-r from-primary/10 to-transparent">
                                <p class="text-xs font-medium text-primary uppercase tracking-wider mb-1">Thành viên vàng</p>
                                <p class="text-sm font-bold text-white truncate">nguyenhoang@example.com</p>
                            </div>
                            <!-- Dropdown Items -->
                            <div class="py-2">
                                <a class="flex items-center gap-3 px-5 py-3 text-sm text-gray-200 hover:bg-white/5 hover:text-primary transition-all group/item border-l-2 border-transparent hover:border-primary" href="#">
                                    <span class="material-symbols-outlined text-[20px] text-gray-400 group-hover/item:text-primary transition-colors">person</span>
                                    <span class="font-medium">Hồ Sơ Cá Nhân</span>
                                </a>
                                <a class="flex items-center gap-3 px-5 py-3 text-sm text-gray-200 hover:bg-white/5 hover:text-primary transition-all group/item border-l-2 border-transparent hover:border-primary" href="#">
                                    <span class="material-symbols-outlined text-[20px] text-gray-400 group-hover/item:text-primary transition-colors">calendar_month</span>
                                    <span class="font-medium">Lịch Sử Đặt Bàn</span>
                                </a>
                                <a class="flex items-center gap-3 px-5 py-3 text-sm text-gray-200 hover:bg-white/5 hover:text-primary transition-all group/item border-l-2 border-transparent hover:border-primary" href="#">
                                    <span class="material-symbols-outlined text-[20px] text-gray-400 group-hover/item:text-primary transition-colors">shopping_bag</span>
                                    <span class="font-medium">Đơn Hàng Của Tôi</span>
                                    <span class="ml-auto bg-primary text-background-dark text-[10px] font-bold px-1.5 py-0.5 rounded">2</span>
                                </a>
                                <a class="flex items-center gap-3 px-5 py-3 text-sm text-gray-200 hover:bg-white/5 hover:text-primary transition-all group/item border-l-2 border-transparent hover:border-primary" href="#">
                                    <span class="material-symbols-outlined text-[20px] text-gray-400 group-hover/item:text-primary transition-colors">stars</span>
                                    <span class="font-medium">Ưu Đãi Hội Viên</span>
                                </a>
                                <a class="flex items-center gap-3 px-5 py-3 text-sm text-gray-200 hover:bg-white/5 hover:text-primary transition-all group/item border-l-2 border-transparent hover:border-primary" href="#">
                                    <span class="material-symbols-outlined text-[20px] text-gray-400 group-hover/item:text-primary transition-colors">settings</span>
                                    <span class="font-medium">Cài Đặt Tài Khoản</span>
                                </a>
                            </div>
                            <!-- Dropdown Footer -->
                            <div class="border-t border-white/10 p-2">
                                <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-400/80 hover:bg-red-500/10 hover:text-red-400 rounded-lg transition-all group/item" href="#">
                                    <span class="material-symbols-outlined text-[20px] group-hover/item:text-red-400 transition-colors">logout</span>
                                    <span class="font-medium">Đăng Xuất</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content Area (Background Context) -->
        <main class="flex-1 w-full max-w-[1280px] mx-auto px-4 sm:px-10 py-8 grid grid-cols-1 lg:grid-cols-12 gap-8">
            <!-- Sidebar Navigation (Mockup) -->
            <aside class="hidden lg:block lg:col-span-3 space-y-2 sticky top-28 h-fit">
                <h3 class="text-primary font-bold text-lg mb-6 px-4">Tài Khoản</h3>
                <nav class="space-y-1">
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg bg-[#2a271f] text-primary border border-primary/20" href="#">
                        <span class="material-symbols-outlined text-[20px]">person</span>
                        <span class="text-sm font-semibold">Hồ Sơ Cá Nhân</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-400 hover:text-white hover:bg-[#2a271f] transition-all" href="#">
                        <span class="material-symbols-outlined text-[20px]">calendar_month</span>
                        <span class="text-sm font-medium">Lịch Sử Đặt Bàn</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-400 hover:text-white hover:bg-[#2a271f] transition-all" href="#">
                        <span class="material-symbols-outlined text-[20px]">shopping_bag</span>
                        <span class="text-sm font-medium">Đơn Hàng Của Tôi</span>
                    </a>
                    <a class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-400 hover:text-white hover:bg-[#2a271f] transition-all" href="#">
                        <span class="material-symbols-outlined text-[20px]">stars</span>
                        <span class="text-sm font-medium">Ưu Đãi Hội Viên</span>
                    </a>
                </nav>
            </aside>
            <!-- Main Profile Content -->
            <section class="lg:col-span-9 space-y-6">
                <!-- Hero Banner for Profile -->
                <div class="relative w-full h-48 rounded-xl overflow-hidden bg-background-dark border border-[#37342a]">
                    <div class="absolute inset-0 bg-gradient-to-r from-background-dark via-background-dark/80 to-transparent z-10"></div>
                    <div class="absolute inset-0 bg-cover bg-center opacity-40" data-alt="Abstract luxury golden pattern background" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBQO8brhS83Vi7By8jrG4exAFhR6CbOtZl0_CG95LNNATA8Ff0P3MlmhxsIvag-f8wenH4x4taFydcDq0NbIaI3fHDA0U0HbgPAGD0h6AaxN3EG9RU7F5weCOVaFngeAt-a_P2-kNP6oEG2lnocYWLydLpWfmKVXZupKMkYAqUYE9YgUELkfERuwHgWMGW4KQEvmlcDoGwHgy7NhK3aUc82FbZnu1nuhgnuOKM-ugA66HQUIoBcGwbHfK846iCgFo2YiGba0h-5LTXi');"></div>
                    <div class="relative z-20 h-full flex items-center px-8">
                        <div class="flex items-center gap-6">
                            <div class="size-24 rounded-full border-4 border-[#2a271f] overflow-hidden shadow-2xl">
                                <img alt="Nguyen Hoang profile" class="w-full h-full object-cover" data-alt="User profile picture" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDwS4MHyipqrSMzQg7UXWwxMq0--odEYxqMkzHw2rRIgEFYcpbEgu2ff1ZLz850mrL3H0NToygexo2uPY7HRGuQDEOTMjI1TqenWjVPVijwpFOUlZhRKK9PrwjfhhAe2u44I5mqQqEHCE_B-PDFJ-AfpMILVhWXrYOUeykfEMGz4eSgruuNf_Hpo2B33jQEZLZfxDIBTnIxl1ae8MDbkny7qNSXvOW_vyKsrIHOIm2XfTzjUlKp5gmh-heWTAnO42RmNKZSp_cgCW9S"/>
                            </div>
                            <div>
                                <h1 class="text-2xl font-bold text-white mb-1">Xin chào, Nguyễn Hoàng</h1>
                                <div class="flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary text-sm">workspace_premium</span>
                                    <p class="text-primary text-sm font-medium">Thành viên Vàng • 1,250 điểm</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Profile Details Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Personal Info Card -->
                    <div class="bg-[#171612] border border-[#37342a] rounded-xl p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-bold text-white">Thông Tin Cá Nhân</h3>
                            <button class="text-primary text-sm hover:underline">Chỉnh sửa</button>
                        </div>
                        <div class="space-y-4">
                            <div class="flex flex-col gap-1">
                                <span class="text-xs text-gray-500 uppercase tracking-wide">Họ và tên</span>
                                <span class="text-white font-medium">Nguyễn Văn Hoàng</span>
                            </div>
                            <div class="flex flex-col gap-1">
                                <span class="text-xs text-gray-500 uppercase tracking-wide">Email</span>
                                <span class="text-white font-medium">nguyenhoang@example.com</span>
                            </div>
                            <div class="flex flex-col gap-1">
                                <span class="text-xs text-gray-500 uppercase tracking-wide">Số điện thoại</span>
                                <span class="text-white font-medium">+84 909 123 456</span>
                            </div>
                        </div>
                    </div>
                    <!-- Recent Activity Card -->
                    <div class="bg-[#171612] border border-[#37342a] rounded-xl p-6 flex flex-col">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-lg font-bold text-white">Hoạt Động Gần Đây</h3>
                            <a class="text-primary text-sm hover:underline" href="#">Xem tất cả</a>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="flex items-center gap-4 p-3 bg-[#2a271f] rounded-lg border border-white/5">
                                <div class="size-10 rounded-full bg-primary/20 flex items-center justify-center text-primary shrink-0">
                                    <span class="material-symbols-outlined text-[20px]">restaurant</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-white text-sm font-medium truncate">Đặt bàn tối nay</p>
                                    <p class="text-gray-400 text-xs">19:30 - Maison D'Or Center</p>
                                </div>
                                <span class="text-xs text-primary font-bold bg-primary/10 px-2 py-1 rounded">Sắp tới</span>
                            </div>
                            <div class="flex items-center gap-4 p-3 rounded-lg hover:bg-white/5 transition-colors">
                                <div class="size-10 rounded-full bg-white/5 flex items-center justify-center text-gray-400 shrink-0">
                                    <span class="material-symbols-outlined text-[20px]">check_circle</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-white text-sm font-medium truncate">Đơn hàng #39201</p>
                                    <p class="text-gray-400 text-xs">Hoàn thành • 12/10/2023</p>
                                </div>
                                <span class="text-gray-500 text-xs">2.500.000đ</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </body></html>