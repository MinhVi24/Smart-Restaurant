<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Quản lí Tài khoản - Vesper</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&amp;family=Inter:wght@300;400;500;600&amp;family=Material+Icons+Round&amp;display=swap" rel="stylesheet"/>
        <style type="text/tailwindcss">
            @layer base {
                body {
                    font-family: 'Inter', sans-serif;
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
                .sidebar-active {
                    background: linear-gradient(90deg, rgba(212, 175, 55, 0.15) 0%, rgba(212, 175, 55, 0) 100%);
                    border-left: 3px solid #D4AF37;
                }
            }
            :root {
                --primary: #D4AF37;
                --background-dark: #0D0D0D;
                --card-dark: #161616;
            }
            ::-webkit-scrollbar {
                width: 6px;
            }
            ::-webkit-scrollbar-track {
                background: #0D0D0D;
            }
            ::-webkit-scrollbar-thumb {
                background: #333;
                border-radius: 10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #D4AF37;
            }
        </style>
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#D4AF37",
                            "background-light": "#F8F5F0",
                            "background-dark": "#0D0D0D",
                            "card-dark": "#161616",
                            "accent-gold": "#D4AF37",
                            "accent-red": "#FF4D4D",
                        },
                        fontFamily: {
                            display: ["Playfair Display", "serif"],
                            sans: ["Inter", "sans-serif"],
                        },
                        borderRadius: {
                            DEFAULT: "12px",
                        },
                    },
                },
            };
        </script>
    </head>
    <body class="bg-background-light dark:bg-background-dark text-slate-800 dark:text-stone-300 min-h-screen flex">
        <!-- Shared Sidebar -->
           <jsp:include page="/views/admin/includes/sidebar.jsp" />
        <main class="flex-1 overflow-y-auto bg-stone-50 dark:bg-background-dark p-8">
            <header class="mb-10">
                <h2 class="text-5xl font-display font-bold text-stone-900 dark:text-stone-100 tracking-tight">Quản lí Tài khoản</h2>
                <div class="flex items-center gap-2 mt-3 text-stone-500 dark:text-stone-400 text-sm">
                    <span class="w-2 h-2 rounded-full bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.6)]"></span>
                    Vesper Executive Suite
                </div>
            </header>
            
            <div class="glass-card bg-white dark:bg-card-dark p-8 rounded-3xl">
                <div class="text-center py-20">
                    <span class="material-icons-round text-primary text-6xl mb-4">manage_accounts</span>
                    <h3 class="text-2xl font-display font-bold dark:text-stone-100 mb-2">Trang Quản lí Tài khoản</h3>
                    <p class="text-stone-500">Chức năng đang được phát triển</p>
                </div>
            </div>
        </main>
    </body>
</html>
