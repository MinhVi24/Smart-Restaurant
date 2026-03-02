<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html class="light" lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Đăng Ký - Smart Restaurant</title>

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
                                "primary": "#ee7c2b",
                                "primary-dark": "#d5691f",
                                "background-light": "#f8f7f6",
                                "background-dark": "#221810",
                            },
                            fontFamily: {
                                "display": ["Plus Jakarta Sans", "sans-serif"]
                            }
                        }
                    }
                }
            </script>
            <style>
                body {
                    font-family: "Plus Jakarta Sans", sans-serif;
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
                    box-shadow: 0 8px 25px rgba(238, 124, 43, 0.4);
                }
            </style>
        </head>

        <body
            class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

            <jsp:include page="/views/includes/header.jsp" />

            <main class="flex-1 flex overflow-hidden">

                <!-- Left: Form -->
                <div
                    class="w-full lg:w-1/2 flex flex-col justify-center px-6 md:px-16 lg:px-24 py-12 bg-white dark:bg-background-dark">
                    <div class="max-w-md w-full mx-auto fade-in">

                        <div class="mb-8">
                            <h1 class="text-4xl font-black mb-2">Tạo Tài Khoản</h1>
                            <p class="text-slate-500 dark:text-slate-400 text-lg">
                                Tham gia cộng đồng ẩm thực của chúng tôi ngay hôm nay.
                            </p>
                        </div>

                        <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">

                            <c:if test="${not empty error}">
                                <div class="bg-red-50 border-l-4 border-red-500 text-red-700 px-4 py-3 rounded-r-lg"
                                    role="alert">
                                    <div class="flex items-center gap-2">
                                        <i class="fas fa-exclamation-circle"></i>
                                        <span>${error}</span>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Họ tên → Customers.full_name -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Họ và tên</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-user"></i>
                                    <input name="fullname" type="text" required
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="Nguyễn Văn A" />
                                </div>
                            </div>

                            <!-- Tên đăng nhập → Users.username -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Tên đăng
                                    nhập</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-at"></i>
                                    <input name="username" type="text" required
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="nguyenvana" />
                                </div>
                            </div>

                            <!-- Email → Users.email -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Email</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-envelope"></i>
                                    <input name="email" type="email"
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="email@example.com" />
                                </div>
                            </div>

                            <!-- Số điện thoại → Customers.phone -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Số điện
                                    thoại</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-phone"></i>
                                    <input name="phone" type="tel"
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="0901 234 567" />
                                </div>
                            </div>

                            <!-- Mật khẩu → Users.password_hash (qua BCrypt) -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Mật khẩu</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-lock"></i>
                                    <input id="passwordInput" name="password" type="password" required
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="••••••••" />
                                </div>
                            </div>

                            <!-- Xác nhận mật khẩu -->
                            <div>
                                <label class="text-sm font-bold text-slate-700 dark:text-slate-300">Xác nhận mật
                                    khẩu</label>
                                <div class="input-icon mt-1">
                                    <i class="fas fa-lock"></i>
                                    <input id="confirmPasswordInput" name="confirmPassword" type="password" required
                                        class="w-full px-4 py-3 rounded-xl border border-slate-200 dark:border-slate-700 dark:bg-slate-800 focus:ring-2 focus:ring-primary/30 focus:border-primary outline-none transition-all"
                                        placeholder="••••••••" />
                                </div>
                                <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Mật khẩu xác nhận không
                                    khớp.</p>
                            </div>

                            <div class="space-y-3 pt-1">
                                <label class="flex items-start gap-3 cursor-pointer group">
                                    <input name="agree" type="checkbox" required
                                        class="mt-1 w-5 h-5 text-primary rounded border-slate-300 focus:ring-primary" />
                                    <span
                                        class="text-sm text-slate-600 dark:text-slate-400 group-hover:text-slate-900 dark:group-hover:text-slate-200 transition-colors">
                                        Tôi đồng ý với <a href="#"
                                            class="text-primary font-semibold hover:underline">Điều khoản sử dụng</a>.
                                    </span>
                                </label>
                            </div>

                            <button type="submit" id="submitBtn"
                                class="w-full bg-primary text-white py-4 rounded-xl font-bold text-lg shadow-lg btn-hover mt-2">
                                <i class="fas fa-user-plus mr-2"></i> Tạo Tài Khoản
                            </button>

                        </form>

                        <div class="mt-8 text-center">
                            <p class="text-slate-500 dark:text-slate-400">
                                Đã có tài khoản?
                                <a href="${pageContext.request.contextPath}/login"
                                    class="text-primary font-bold hover:underline ml-1">
                                    Đăng Nhập
                                </a>
                            </p>
                        </div>

                    </div>
                </div>

                <!-- Right: Hero Image -->
                <div class="hidden lg:block lg:w-1/2 relative">
                    <div class="absolute inset-0 bg-cover bg-center"
                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAL6iXtthaLGR9mSTgdRB0CmISWWDcQdSbYGHeQa8S8htDEdPJy8PsNp2kVXy9r-PPBcSChd5zteF1wRsmJjEPykPt1-56RusilVN9vb6VYxZHkyTmFlGsyzfBawA0fHlrM6yf7FXhMWy6RcKBl1nqeBdOpP7hvXZC5O_5-U_szYzciESHvQqOPnzgoDmszEtO0-PybBI_iNbbFyT31G0-XbWnmICePrFIe6t-kLEPij78v254KpW8e7Yo4LYI0lPUuva9xLYfEFhU');">
                    </div>
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                    <div class="absolute bottom-12 left-12 right-12 text-white">
                        <h2 class="text-4xl font-extrabold mb-3 drop-shadow-lg">Khám Phá Ẩm Thực</h2>
                        <p class="text-lg opacity-90 drop-shadow-md">Đặt bàn dễ dàng, thưởng thức món ngon mỗi ngày.</p>
                    </div>
                </div>

            </main>

            <jsp:include page="/views/includes/footer.jsp" />

            <script>
                // Client-side password match validation
                const pw = document.getElementById('passwordInput');
                const cpw = document.getElementById('confirmPasswordInput');
                const err = document.getElementById('passwordError');
                const btn = document.getElementById('submitBtn');

                function checkMatch() {
                    if (cpw.value && pw.value !== cpw.value) {
                        err.classList.remove('hidden');
                        cpw.classList.add('border-red-400');
                        cpw.classList.remove('border-slate-200');
                    } else {
                        err.classList.add('hidden');
                        cpw.classList.remove('border-red-400');
                        cpw.classList.add('border-slate-200');
                    }
                }
                pw.addEventListener('input', checkMatch);
                cpw.addEventListener('input', checkMatch);

                document.querySelector('form').addEventListener('submit', function (e) {
                    if (pw.value !== cpw.value) {
                        e.preventDefault();
                        err.classList.remove('hidden');
                        cpw.focus();
                    }
                });
            </script>

        </body>

        </html>