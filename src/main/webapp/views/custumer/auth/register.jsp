<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Maison D'Or - Membership Registration</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700&amp;family=Playfair+Display:ital,wght@0,400;0,700;1,400&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#d4af35",
                            "primary-dark": "#b08d2b",
                            "primary-light": "#eacc68",
                            "background-light": "#f8f7f6",
                            "background-dark": "#1a1a1a",
                            "surface-dark": "#25231d",
                            "surface-border": "#37342a",
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
    <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 font-display antialiased selection:bg-primary selection:text-white">
        <div class="min-h-screen flex flex-col md:flex-row w-full overflow-hidden">
            <div class="relative hidden md:flex w-full md:w-1/2 lg:w-5/12 xl:w-1/3 flex-col justify-between overflow-hidden">
                <div class="absolute inset-0 z-0">
                    <img alt="Luxury dining table with candlelight and elegant setting" class="h-full w-full object-cover" data-alt="Luxury dining table with candlelight and elegant setting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZt6N1MHROg57XDGy0L227s960-y4CXQPWHE0juycgWNFVW1Ezz3DA6pGCqFkXcxvJ3QOHunYb0LiLMLDfZEt8TwNGXGxhc5GS1zKZpHBtI1J3-ah-RZ1j4tJcnOY1clgiC7SUBdVGWpshReozyk5eeOXUmjyHXWigCu6ecpy8VA6cu3X4TrdaaDjfyyiKHO-F9_uFr93SNFQaInsoiciMijpi7IpHkCmVrkWuXZ1vvB1989ceC9IbDBN0zytlgLNgsk6ye-CyWQ6z"/>
                    <div class="absolute inset-0 bg-gradient-to-t from-background-dark/90 via-background-dark/40 to-transparent"></div>
                </div>
                <div class="relative z-10 p-12 flex flex-col h-full justify-between">
                    <div>
                        <div class="flex items-center gap-3 text-primary mb-8">
                            <span class="material-symbols-outlined text-4xl">diamond</span>
                            <span class="text-white text-xl font-bold tracking-widest uppercase font-serif">Maison D'Or</span>
                        </div>
                    </div>
                    <div class="mb-12">
                        <h1 class="font-serif text-4xl lg:text-5xl font-medium text-white leading-tight mb-6">
                            Tham Gia Cộng Đồng <br/> <span class="text-primary italic">Thượng Lưu</span>
                        </h1>
                        <p class="text-slate-300 text-lg font-light leading-relaxed max-w-sm border-l-2 border-primary pl-4">
                            Trải nghiệm tinh hoa ẩm thực Pháp và những đặc quyền dành riêng cho hội viên tại Maison D'Or.
                        </p>
                    </div>
                    <div class="flex gap-6 text-slate-400 text-sm">
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary text-xl">verified</span>
                            <span>Đẳng cấp 5 sao</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary text-xl">star</span>
                            <span>Dịch vụ V.I.P</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flex-1 flex flex-col relative bg-background-light dark:bg-background-dark h-full min-h-screen overflow-y-auto">
                <header class="md:hidden flex items-center justify-between px-6 py-4 border-b border-surface-border">
                    <div class="flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary">diamond</span>
                        <span class="text-white font-serif font-bold">Maison D'Or</span>
                    </div>
                    <button class="text-primary text-sm font-bold">Đăng nhập</button>
                </header>
                <div class="flex-1 flex items-center justify-center p-6 md:p-12 lg:p-20">
                    <div class="w-full max-w-lg">
                        <div class="mb-8">
                            <h2 class="text-3xl font-serif text-slate-900 dark:text-white mb-2">Đăng Ký Hội Viên</h2>
                            <p class="text-slate-600 dark:text-slate-400">Hoàn tất thông tin để bắt đầu hành trình của bạn.</p>
                        </div>
                        <form action="#" class="space-y-6">
                            <div class="space-y-2">
                                <label class="block text-sm font-medium text-slate-700 dark:text-slate-300" for="fullname">Họ và tên</label>
                                <div class="relative">
                                    <input class="w-full h-12 px-4 rounded-lg bg-white dark:bg-surface-dark border border-slate-200 dark:border-surface-border text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all duration-200" id="fullname" placeholder="Nguyễn Văn A" type="text"/>
                                </div>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300" for="phone">Số điện thoại</label>
                                    <input class="w-full h-12 px-4 rounded-lg bg-white dark:bg-surface-dark border border-slate-200 dark:border-surface-border text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all duration-200" id="phone" placeholder="090 123 4567" type="tel"/>
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-slate-700 dark:text-slate-300" for="email">Email</label>
                                    <input class="w-full h-12 px-4 rounded-lg bg-white dark:bg-surface-dark border border-slate-200 dark:border-surface-border text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all duration-200" id="email" placeholder="example@email.com" type="email"/>
                                </div>
                            </div>
                            <div class="space-y-2">
                                <label class="block text-sm font-medium text-slate-700 dark:text-slate-300" for="password">Mật khẩu</label>
                                <div class="relative">
                                    <input class="w-full h-12 px-4 rounded-lg bg-white dark:bg-surface-dark border border-slate-200 dark:border-surface-border text-slate-900 dark:text-white placeholder-slate-400 focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-all duration-200" id="password" placeholder="••••••••" type="password"/>
                                    <button class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-primary transition-colors" type="button">
                                        <span class="material-symbols-outlined text-[20px]">visibility</span>
                                    </button>
                                </div>
                            </div>
                            <div class="pt-2">
                                <button class="w-full h-12 bg-primary hover:bg-primary-dark text-background-dark font-bold text-base rounded-lg shadow-[0_0_15px_rgba(212,175,53,0.3)] hover:shadow-[0_0_20px_rgba(212,175,53,0.5)] transition-all duration-300 flex items-center justify-center gap-2 group" type="button">
                                    <span>Đăng Ký Ngay</span>
                                    <span class="material-symbols-outlined text-lg transition-transform group-hover:translate-x-1">arrow_forward</span>
                                </button>
                            </div>
                            <div class="relative">
                                <div class="absolute inset-0 flex items-center">
                                    <div class="w-full border-t border-slate-200 dark:border-surface-border"></div>
                                </div>
                                <div class="relative flex justify-center text-sm">
                                    <span class="px-2 bg-background-light dark:bg-background-dark text-slate-500">hoặc</span>
                                </div>
                            </div>
                            <button class="w-full h-12 bg-white dark:bg-surface-dark border border-slate-200 dark:border-surface-border hover:border-primary dark:hover:border-primary text-slate-700 dark:text-slate-200 font-medium text-base rounded-lg transition-all duration-300 flex items-center justify-center gap-3 group" type="button">
                                <svg class="w-5 h-5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"></path>
                                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"></path>
                                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"></path>
                                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"></path>
                                </svg>
                                <span>Tiếp tục với Google</span>
                            </button>
                            <div class="text-center mt-6">
                                <p class="text-slate-600 dark:text-slate-400 text-sm">
                                    Đã có tài khoản? 
                                    <a class="text-primary hover:text-primary-light font-semibold hover:underline decoration-primary underline-offset-4 transition-all" href="#">Đăng nhập</a>
                                </p>
                            </div>
                        </form>
                        <div class="mt-12 pt-6 border-t border-slate-200 dark:border-surface-border flex justify-between items-center text-xs text-slate-500">
                            <span>© 2024 Maison D'Or</span>
                            <div class="flex gap-4">
                                <a class="hover:text-primary" href="#">Điều khoản</a>
                                <a class="hover:text-primary" href="#">Bảo mật</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body></html>