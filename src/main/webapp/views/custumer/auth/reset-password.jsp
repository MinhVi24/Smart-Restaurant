<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html class="dark" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Đặt Lại Mật Khẩu - Maison D'Or</title>
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
                                "primary": "#d4af35",
                                "primary-dark": "#b08d1e",
                                "primary-light": "#eacc6b",
                                "background-light": "#f8f7f6",
                                "background-dark": "#1a1a1a",
                                "surface-dark": "#232323",
                                "surface-light": "#ffffff",
                            },
                            fontFamily: {
                                "display": ["Newsreader", "serif"],
                                "serif": ["Playfair Display", "serif"],
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
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
                            <h1 class="text-xl font-serif font-bold tracking-widest text-primary uppercase">Maison d'Or
                            </h1>
                        </a>
                    </div>
                </div>
            </header>
            <main class="flex-grow flex items-center justify-center p-4 md:p-10 relative overflow-hidden min-h-screen">
                <div class="absolute inset-0 z-0 opacity-[0.03] pointer-events-none"
                    style="background-image: radial-gradient(#d4af35 1px, transparent 1px); background-size: 40px 40px;">
                </div>
                <div
                    class="absolute top-1/2 left-1/4 -translate-y-1/2 w-[600px] h-[600px] bg-primary/5 rounded-full blur-3xl z-0 pointer-events-none">
                </div>
                <div class="relative z-10 w-full max-w-md">
                    <div class="bg-surface-dark border border-[#37342a] shadow-2xl gold-glow rounded-xl p-8 md:p-12">
                        <div class="text-center mb-8">
                            <div
                                class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 mb-6">
                                <span class="material-symbols-outlined text-primary text-3xl">password</span>
                            </div>
                            <h3 class="text-2xl md:text-3xl font-serif font-bold gold-gradient-text mb-2">Đặt Lại Mật
                                Khẩu</h3>
                            <p class="text-slate-400 text-sm">Nhập mật khẩu mới cho tài khoản của bạn</p>
                        </div>

                        <%-- Thông báo lỗi --%>
                            <c:if test="${not empty error}">
                                <div
                                    class="mb-6 p-3 bg-red-500/10 border border-red-500/30 rounded-lg text-red-400 text-sm text-center">
                                    ${error}
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/reset-password" method="POST"
                                class="space-y-6">
                                <input type="hidden" name="token" value="${token}" />

                                <div class="group">
                                    <label class="block text-xs uppercase tracking-widest text-primary/70 mb-2"
                                        for="newPassword">Mật khẩu mới</label>
                                    <div class="relative">
                                        <input
                                            class="w-full bg-surface-dark border-b border-[#37342a] focus:border-primary px-0 py-3 text-slate-100 placeholder-slate-600 focus:ring-0 transition-colors duration-300"
                                            id="newPassword" name="newPassword" placeholder="Ít nhất 6 ký tự"
                                            type="password" minlength="6" required />
                                    </div>
                                </div>

                                <div class="group">
                                    <label class="block text-xs uppercase tracking-widest text-primary/70 mb-2"
                                        for="confirmPassword">Xác nhận mật khẩu</label>
                                    <div class="relative">
                                        <input
                                            class="w-full bg-surface-dark border-b border-[#37342a] focus:border-primary px-0 py-3 text-slate-100 placeholder-slate-600 focus:ring-0 transition-colors duration-300"
                                            id="confirmPassword" name="confirmPassword"
                                            placeholder="Nhập lại mật khẩu mới" type="password" minlength="6"
                                            required />
                                    </div>
                                </div>

                                <button
                                    class="w-full mt-4 py-3.5 bg-primary hover:bg-primary-dark text-background-dark font-bold tracking-wide rounded-sm transition-all duration-300 shadow-lg shadow-primary/10 flex items-center justify-center gap-2 group uppercase text-sm"
                                    type="submit">
                                    <span class="material-symbols-outlined text-lg">check_circle</span>
                                    <span>Xác Nhận Mật Khẩu Mới</span>
                                </button>
                            </form>

                            <div class="mt-8 text-center">
                                <a class="text-primary/70 hover:text-primary text-sm transition-colors inline-flex items-center gap-1"
                                    href="${pageContext.request.contextPath}/login">
                                    <span class="material-symbols-outlined text-base">arrow_back</span>
                                    <span>Quay lại Đăng nhập</span>
                                </a>
                            </div>
                    </div>
                </div>
                <div class="absolute bottom-6 text-center w-full pointer-events-none">
                    <p class="text-slate-600 text-[10px] uppercase tracking-[0.2em]">Maison D'Or • Est. 2024</p>
                </div>
            </main>
        </body>

        </html>