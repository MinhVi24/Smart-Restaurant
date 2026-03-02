<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đăng Nhập - Smart Restaurant</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />

            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <script>
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "primary": "#ae042f",
                                "primary-dark": "#8c0327",
                                "background-light": "#f8f5f6",
                                "background-dark": "#230f14",
                            },
                            fontFamily: {
                                "display": ["Plus Jakarta Sans"]
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
                body {
                    font-family: "Plus Jakarta Sans", sans-serif;
                }

                .bg-login-hero {
                    background-image: url(https://lh3.googleusercontent.com/aida-public/AB6AXuADgKRJo7OBrvd2iZ_7k1WjP668gL1ILVx-9sRSu-KwQeeZ0HC7FTeN6rwK4RPI6TkAN46sYVC64o0kvs0KCRMuQwKIRuEgp9JfP_O0OIV6Z9tqY2eHo4G3MPIFMUWN3sgp7wKKpjU4CeGh42TpvUicRYM4rJiNO_FCgoTqGfnHAbKSzbfn8bxZSuJyVplR0NmBAluog0xmgWIfLwKH3zyMdusIyKxwB_DWtFbumlMz4UytWUaYZFn1wPkoDbx-hrP4qDDSLAl6gAc);
                }

                .input-icon {
                    position: relative;
                }

                .input-icon i {
                    position: absolute;
                    left: 14px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #94a3b8;
                    font-size: 16px;
                    pointer-events: none;
                }

                .input-icon input {
                    padding-left: 42px;
                }

                .fade-in {
                    animation: fadeIn 0.6s ease-out;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(16px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .btn-hover {
                    transition: all 0.3s ease;
                }

                .btn-hover:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(174, 4, 47, 0.4);
                }
            </style>
        </head>

        <body
            class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

            <jsp:include page="/views/includes/header.jsp" />

            <main class="flex-1 flex overflow-hidden">

                <!-- Left: Hero Image -->
                <div class="hidden lg:block lg:w-1/2 bg-login-hero bg-cover bg-center relative">
                    <div class="absolute inset-0 bg-primary/20 backdrop-brightness-75"></div>
                    <div class="absolute bottom-12 left-12 right-12 text-white">
                        <h1 class="text-5xl font-extrabold mb-4 drop-shadow-lg">
                            Trải Nghiệm Ẩm Thực Tuyệt Vời
                        </h1>
                        <p class="text-xl opacity-90 drop-shadow-md">
                            Đăng nhập để quản lý đặt bàn và khám phá thực đơn đặc sắc.
                        </p>
                    </div>
                </div>

                <!-- Right: Login Form -->
                <div class="w-full lg:w-1/2 flex items-center justify-center p-8 md:p-16 lg:p-24 overflow-y-auto">
                    <div class="w-full max-w-[440px] flex flex-col gap-8 fade-in">

                        <div>
                            <h2 class="text-3xl font-extrabold">Chào Mừng Trở Lại</h2>
                            <p class="text-slate-500 mt-1">Nhập thông tin đăng nhập của bạn.</p>
                        </div>

                        <!-- Error message -->
                        <c:if test="${not empty error}">
                            <div class="bg-red-50 border-l-4 border-red-500 text-red-700 px-4 py-3 rounded-r-lg"
                                role="alert">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <span>${error}</span>
                                </div>
                            </div>
                        </c:if>

                        <!-- Success message after registration -->
                        <c:if test="${param.success == 'true'}">
                            <div class="bg-green-50 border-l-4 border-green-500 text-green-700 px-4 py-3 rounded-r-lg"
                                role="alert">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-check-circle"></i>
                                    <span>Đăng ký thành công! Vui lòng đăng nhập.</span>
                                </div>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post"
                            class="flex flex-col gap-5">

                            <!-- Tên đăng nhập → Users.username -->
                            <div>
                                <label class="text-sm font-semibold text-slate-700 dark:text-slate-300">Tên đăng
                                    nhập</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-user"></i>
                                    <input name="username" type="text"
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition-all"
                                        placeholder="Nhập tên đăng nhập" required />
                                </div>
                            </div>

                            <!-- Mật khẩu → Users.password_hash -->
                            <div>
                                <label class="text-sm font-semibold text-slate-700 dark:text-slate-300">Mật khẩu</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-lock"></i>
                                    <input name="password" type="password"
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition-all"
                                        placeholder="••••••••" required />
                                </div>
                            </div>

                            <div class="flex items-center justify-between">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" name="remember"
                                        class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary" />
                                    <span class="text-sm text-slate-600 dark:text-slate-400">Ghi nhớ đăng nhập</span>
                                </label>
                                <a href="#" class="text-sm text-primary font-semibold hover:underline">Quên mật
                                    khẩu?</a>
                            </div>

                            <button type="submit"
                                class="w-full bg-primary hover:bg-primary-dark text-white font-bold py-3.5 rounded-xl shadow-lg btn-hover">
                                <i class="fas fa-sign-in-alt mr-2"></i> Đăng Nhập
                            </button>

                        </form>

                        <div class="relative">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-slate-200 dark:border-slate-700"></div>
                            </div>
                            <div class="relative flex justify-center text-sm">
                                <span
                                    class="bg-background-light dark:bg-background-dark px-4 text-slate-500">hoặc</span>
                            </div>
                        </div>

                        <p class="text-center text-sm text-slate-600 dark:text-slate-400">
                            Chưa có tài khoản?
                            <a href="${pageContext.request.contextPath}/register"
                                class="text-primary font-bold hover:underline">
                                Tạo Tài Khoản
                            </a>
                        </p>

                    </div>
                </div>

            </main>

            <jsp:include page="/views/includes/footer.jsp" />

        </body>

        </html>