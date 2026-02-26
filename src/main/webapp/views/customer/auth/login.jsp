<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login - RestaurantSmart</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: "#ae042f",
                            "background-light": "#f8f5f6"
                        },
                        fontFamily: {
                            display: ["Plus Jakarta Sans", "sans-serif"]
                        }
                    }
                }
            }
        </script>

        <style>
            body {
                font-family: "Plus Jakarta Sans", sans-serif;
            }

            .bg-login-hero {
                background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuADgKRJo7OBrvd2iZ_7k1WjP668gL1ILVx-9sRSu-KwQeeZ0HC7FTeN6rwK4RPI6TkAN46sYVC64o0kvs0KCRMuQwKIRuEgp9JfP_O0OIV6Z9tqY2eHo4G3MPIFMUWN3sgp7wKKpjU4CeGh42TpvUicRYM4rJiNO_FCgoTqGfnHAbKSzbfn8bxZSuJyVplR0NmBAluog0xmgWIfLwKH3zyMdusIyKxwB_DWtFbumlMz4UytWUaYZFn1wPkoDbx-hrP4qDDSLAl6gAc");
            }
        </style>
    </head>

    <body class="bg-white text-slate-900 min-h-screen flex flex-col">
        <jsp:include page="/views/includes/header.jsp"/>

        <main class="flex flex-1 min-h-[650px]">            <div class="hidden lg:block lg:w-1/2 relative bg-login-hero bg-cover bg-center">
                <div class="absolute inset-0 bg-primary/10"></div>

                <div class="absolute bottom-10 left-10 right-6 text-white">
                    <h1 class="text-3xl font-bold mb-3 drop-shadow-md">
                        Experience Culinary Excellence
                    </h1>
                    <p class="text-sm opacity-90">
                        Manage your dining reservations effortlessly.
                    </p>
                </div>
            </div>

            <!-- LOGIN FORM -->
            <div class="w-full lg:w-1/2 flex items-center justify-center px-12 py-10">

                <div class="w-full max-w-md flex flex-col gap-6">

                    <div>
                        <h2 class="text-4xl font-bold leading-tight">
                            Welcome Back!
                        </h2>
                        <p class="text-slate-500 text-base mt-3">
                            Please enter your details to sign in.
                        </p>
                    </div>

                    <form action="login" method="post" class="flex flex-col gap-4">

                        <div>
                            <label class="text-sm font-semibold">Username</label>
                            <input name="username" type="text" required
                                   class="w-full px-3 py-2 text-base rounded-md
                                   border border-slate-200
                                   focus:ring-2 focus:ring-primary/20
                                   focus:border-primary outline-none"
                                   placeholder="Enter your username"/>
                        </div>

                        <div>
                            <label class="text-sm font-semibold">Password</label>
                            <input name="password" type="password" required
                                   class="w-full px-3 py-2 text-base rounded-md
                                   border border-slate-200
                                   focus:ring-2 focus:ring-primary/20
                                   focus:border-primary outline-none"
                                   placeholder="••••••••"/>
                        </div>

                        <div class="flex items-center justify-between text-sm">
                            <div class="flex items-center gap-2">
                                <input type="checkbox" name="remember" class="w-4 h-4"/>
                                <label>Remember me</label>
                            </div>

                            <a href="${pageContext.request.contextPath}/views/customer/auth/forgot-password.jsp"
                               class="text-primary hover:underline font-medium">
                                Forgot password?
                            </a>
                        </div>

                        <button type="submit"
                                class="w-full bg-primary hover:bg-primary/90
                                text-white text-sm font-semibold
                                py-3 rounded-md shadow">
                            Sign In
                        </button>

                    </form>

                    <div class="flex items-center my-2">
                        <div class="flex-grow h-px bg-gray-300"></div>
                        <span class="px-3 text-sm text-gray-400 font-medium">
                            OR CONTINUE WITH
                        </span>
                        <div class="flex-grow h-px bg-gray-300"></div>
                    </div>

                    <div class="flex gap-3">

                        <a href="${pageContext.request.contextPath}/google-login"
                           class="flex-1 flex items-center justify-center gap-2
                           h-11 bg-white border border-gray-300
                           rounded-md hover:shadow-sm transition-all duration-200">

                            <svg width="18" height="18" viewBox="0 0 48 48">
                            <path fill="#EA4335" d="M24 9.5c3.54 0 6.73 1.22 9.23 3.6l6.9-6.9C35.64 2.1 30.2 0 24 0 14.64 0 6.48 5.4 2.56 13.32l8.04 6.24C12.68 13.1 17.9 9.5 24 9.5z"/>
                            <path fill="#4285F4" d="M46.1 24.5c0-1.64-.15-3.21-.43-4.73H24v9.01h12.42c-.54 2.9-2.18 5.36-4.66 7.01l7.2 5.6C43.8 37.2 46.1 31.3 46.1 24.5z"/>
                            <path fill="#FBBC05" d="M10.6 28.56A14.48 14.48 0 0 1 9.5 24c0-1.58.27-3.1.75-4.56l-8.04-6.24A23.94 23.94 0 0 0 0 24c0 3.9.94 7.6 2.56 10.8l8.04-6.24z"/>
                            <path fill="#34A853" d="M24 48c6.48 0 11.92-2.14 15.9-5.82l-7.2-5.6c-2 1.34-4.56 2.13-8.7 2.13-6.1 0-11.32-3.6-13.4-8.76l-8.04 6.24C6.48 42.6 14.64 48 24 48z"/>
                            </svg>

                            <span class="text-sm font-medium text-gray-700">
                                Google
                            </span>
                        </a>

                        <a href="${pageContext.request.contextPath}/facebook-login"
                           class="flex-1 flex items-center justify-center gap-2
                           h-11 bg-white border border-gray-300
                           rounded-md hover:shadow-sm transition-all duration-200">

                            <i class="fa-brands fa-facebook-f text-blue-600 text-base"></i>
                            <span class="text-sm font-medium text-gray-700">
                                Facebook
                            </span>
                        </a>

                    </div>

                    <p class="text-center text-sm text-slate-600">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/views/customer/auth/register.jsp"
                           class="text-primary font-semibold hover:underline">
                            Create Account
                        </a>
                    </p>

                </div>
            </div>

        </main>

        <jsp:include page="/views/includes/footer.jsp"/>

    </body>
</html>