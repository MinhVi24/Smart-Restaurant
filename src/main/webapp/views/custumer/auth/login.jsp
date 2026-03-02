<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html class="dark" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Luxury Membership Login - Maison D'Or</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link href="https://fonts.googleapis.com" rel="preconnect" />
            <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
            <link
                href="https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&amp;family=Playfair+Display:ital,wght@0,400..900;1,400..900&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
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

                input:-webkit-autofill,
                input:-webkit-autofill:hover,
                input:-webkit-autofill:focus,
                input:-webkit-autofill:active {
                    -webkit-box-shadow: 0 0 0 30px #232323 inset !important;
                    -webkit-text-fill-color: white !important;
                    caret-color: #d4af35;
                }
            </style>
        </head>

        <body
            class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 flex flex-col min-h-screen">
            <header
                class="fixed top-0 z-50 w-full border-b border-[#37342a] bg-background-dark/90 backdrop-blur-md px-6 py-4">
                <div class="mx-auto max-w-7xl flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="size-8 text-primary">
                            <svg fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z">
                                </path>
                            </svg>
                        </div>
                        <a href="${pageContext.request.contextPath}/">
                            <h1 class="text-xl font-serif font-bold tracking-widest text-primary uppercase">Maison
                                d'Or</h1>
                        </a>
                    </div>
                    <nav class="hidden md:flex items-center gap-8">
                        <a class="text-slate-300 hover:text-primary transition-colors text-sm font-medium tracking-wide"
                            href="${pageContext.request.contextPath}/menu">Thực Đơn</a>
                        <a class="text-slate-300 hover:text-primary transition-colors text-sm font-medium tracking-wide"
                            href="${pageContext.request.contextPath}/views/custumer/booking/booking.jsp">Đặt Bàn</a>
                        <a class="text-slate-300 hover:text-primary transition-colors text-sm font-medium tracking-wide"
                            href="${pageContext.request.contextPath}/register">Đăng Ký</a>
                    </nav>
                </div>
            </header>
            <main class="flex-grow flex items-center justify-center p-4 md:p-10 relative overflow-hidden min-h-screen">
                <div class="absolute inset-0 z-0 opacity-[0.03] pointer-events-none"
                    style="background-image: radial-gradient(#d4af35 1px, transparent 1px); background-size: 40px 40px;">
                </div>
                <div
                    class="absolute top-1/2 left-1/4 -translate-y-1/2 w-[600px] h-[600px] bg-primary/5 rounded-full blur-3xl z-0 pointer-events-none">
                </div>
                <div
                    class="relative z-10 w-full max-w-5xl bg-surface-dark border border-[#37342a] shadow-2xl gold-glow rounded-xl overflow-hidden flex flex-col md:flex-row min-h-[600px]">
                    <div class="hidden md:block w-1/2 relative">
                        <div class="absolute inset-0 bg-cover bg-center"
                            style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuASKJRw1yPQFFqCBqQZHt4PHCFQGUGF5_z8yc_uDq6O30VK96o9srQiomMX05MAQq7In9ZmGXbJ5TrqPNkVnWp7ewRGnS-V6BkSZ-I11j7pH0sNaAKuhG7e0pLfEkOcXGXWmeXSVGYJRGV6_-wD6GtcB_KjXenfR3O4CCS7hGQTBYWodKxxQfRoDyZJdHcKgmtCyjg-wJK21kI7-Tpv-SrLOGYX0_2ALmLaRzs8bpoifJCDSPbV7OtS3hYAFQmmD0xAZbCBjWJHv9Rb");'>
                        </div>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent">
                        </div>
                        <div class="absolute bottom-12 left-10 right-10">
                            <div class="w-12 h-[1px] bg-primary mb-6"></div>
                            <h2 class="text-4xl font-serif text-slate-100 mb-4 leading-tight">Đặc Quyền<br />Thượng
                                Lưu</h2>
                            <p class="text-slate-300/80 font-light text-sm leading-relaxed max-w-xs">
                                Trở thành hội viên để tận hưởng những ưu đãi ẩm thực độc bản và không gian riêng tư
                                đẳng cấp tại Maison d'Or.
                            </p>
                        </div>
                    </div>
                    <div class="w-full md:w-1/2 p-8 md:p-14 flex flex-col justify-center relative">
                        <div class="max-w-sm mx-auto w-full">
                            <div class="mb-10 text-center">
                                <h3 class="text-2xl md:text-3xl font-serif font-bold gold-gradient-text mb-2">Đăng
                                    Nhập</h3>
                                <p class="text-slate-400 text-sm">Chào mừng quý khách trở lại</p>
                            </div>

                            <%-- Hiển thị thông báo lỗi --%>
                                <c:if test="${not empty error}">
                                    <div
                                        class="mb-6 p-3 bg-red-500/10 border border-red-500/30 rounded-lg text-red-400 text-sm text-center">
                                        ${error}
                                    </div>
                                </c:if>

                                <%-- Hiển thị thông báo đăng ký thành công --%>
                                    <c:if test="${param.success == 'true'}">
                                        <div
                                            class="mb-6 p-3 bg-green-500/10 border border-green-500/30 rounded-lg text-green-400 text-sm text-center">
                                            Đăng ký thành công! Vui lòng đăng nhập.
                                        </div>
                                    </c:if>

                                    <%-- Hiển thị thông báo đổi mật khẩu thành công --%>
                                        <c:if test="${param.reset == 'success'}">
                                            <div
                                                class="mb-6 p-3 bg-green-500/10 border border-green-500/30 rounded-lg text-green-400 text-sm text-center">
                                                Đổi mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.
                                            </div>
                                        </c:if>

                                        <form action="${pageContext.request.contextPath}/login" method="POST"
                                            class="space-y-6">
                                            <div class="group">
                                                <label
                                                    class="block text-xs uppercase tracking-widest text-primary/70 mb-2"
                                                    for="username">Tên đăng nhập</label>
                                                <div class="relative">
                                                    <input
                                                        class="w-full bg-surface-dark border-b border-[#37342a] focus:border-primary px-0 py-3 text-slate-100 placeholder-slate-600 focus:ring-0 transition-colors duration-300"
                                                        id="username" name="username" placeholder="Nhập tên đăng nhập"
                                                        type="text" required />
                                                </div>
                                            </div>
                                            <div class="group">
                                                <div class="flex justify-between items-center mb-2">
                                                    <label
                                                        class="block text-xs uppercase tracking-widest text-primary/70"
                                                        for="password">Mật khẩu</label>
                                                    <a class="text-xs text-primary/70 hover:text-primary transition-colors"
                                                        href="${pageContext.request.contextPath}/forgot-password">Quên
                                                        mật khẩu?</a>
                                                </div>
                                                <div class="relative">
                                                    <input
                                                        class="w-full bg-surface-dark border-b border-[#37342a] focus:border-primary px-0 py-3 text-slate-100 placeholder-slate-600 focus:ring-0 transition-colors duration-300"
                                                        id="password" name="password" placeholder="••••••••"
                                                        type="password" required />
                                                </div>
                                            </div>
                                            <button
                                                class="w-full mt-8 py-3.5 bg-primary hover:bg-primary-dark text-background-dark font-bold tracking-wide rounded-sm transition-all duration-300 shadow-lg shadow-primary/10 flex items-center justify-center gap-2 group uppercase text-sm"
                                                type="submit">
                                                <span>Đăng Nhập</span>
                                                <span
                                                    class="material-symbols-outlined text-lg group-hover:translate-x-1 transition-transform">arrow_forward</span>
                                            </button>
                                        </form>
                                        <div class="relative my-8">
                                            <div class="absolute inset-0 flex items-center">
                                                <div class="w-full border-t border-[#37342a]"></div>
                                            </div>
                                            <div class="relative flex justify-center text-sm">
                                                <span
                                                    class="bg-surface-dark px-2 text-slate-500 text-xs uppercase tracking-widest">Hoặc
                                                    tiếp tục với</span>
                                            </div>
                                        </div>
                                        <div class="grid grid-cols-1 gap-4">
                                            <a href="https://accounts.google.com/o/oauth2/auth?client_id=819113969220-ng9cco5jvgiugtekfq9aoluj194j2e9f.apps.googleusercontent.com&redirect_uri=http://localhost:8080/Smart-Restaurant/login-google&response_type=code&scope=email%20profile"
                                                class="flex items-center justify-center gap-3 py-2.5 bg-white border border-transparent hover:bg-gray-50 rounded-sm text-gray-800 transition-all duration-300 group w-full shadow-sm">
                                                <svg class="w-5 h-5" viewBox="0 0 24 24"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <path
                                                        d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                                                        fill="#4285F4"></path>
                                                    <path
                                                        d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                                                        fill="#34A853"></path>
                                                    <path
                                                        d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                                                        fill="#FBBC05"></path>
                                                    <path
                                                        d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                                                        fill="#EA4335"></path>
                                                </svg>
                                                <span class="text-sm font-medium tracking-wide font-sans">Đăng nhập
                                                    với Google</span>
                                            </a>
                                        </div>
                                        <div class="mt-8 text-center">
                                            <p class="text-slate-400 text-sm">
                                                Chưa có tài khoản?
                                                <a class="text-primary hover:text-primary-light font-medium ml-1 transition-colors relative after:content-[''] after:absolute after:bottom-0 after:left-0 after:w-0 after:h-[1px] after:bg-primary after:transition-all hover:after:w-full"
                                                    href="${pageContext.request.contextPath}/register">
                                                    Đăng ký ngay
                                                </a>
                                            </p>
                                        </div>
                        </div>
                    </div>
                </div>
                <div class="absolute bottom-6 text-center w-full pointer-events-none">
                    <p class="text-slate-600 text-[10px] uppercase tracking-[0.2em]">Maison D'Or • Est. 2024</p>
                </div>
            </main>
        </body>

        </html>