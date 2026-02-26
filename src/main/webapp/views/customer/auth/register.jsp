<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register - RestaurantSmart</title>
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

            .bg-register-hero {
                background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuADgKRJo7OBrvd2iZ_7k1WjP668gL1ILVx-9sRSu-KwQeeZ0HC7FTeN6rwK4RPI6TkAN46sYVC64o0kvs0KCRMuQwKIRuEgp9JfP_O0OIV6Z9tqY2eHo4G3MPIFMUWN3sgp7wKKpjU4CeGh42TpvUicRYM4rJiNO_FCgoTqGfnHAbKSzbfn8bxZSuJyVplR0NmBAluog0xmgWIfLwKH3zyMdusIyKxwB_DWtFbumlMz4UytWUaYZFn1wPkoDbx-hrP4qDDSLAl6gAc");
            }
        </style>
    </head>

    <body class="bg-white text-slate-900 min-h-screen flex flex-col">

        <jsp:include page="/views/includes/header.jsp"/>

        <main class="flex flex-1 min-h-[650px]">

            <!-- HERO LEFT 50% -->
            <div class="hidden lg:flex lg:w-1/2 relative bg-register-hero bg-cover bg-center">
                <div class="absolute inset-0 bg-primary/10"></div>

                <div class="absolute bottom-12 left-12 right-12 text-white">
                    <h1 class="text-3xl font-bold mb-3 drop-shadow-md">
                        Join Our Dining Community
                    </h1>
                    <p class="text-sm opacity-90">
                        Create your account and start booking premium experiences.
                    </p>
                </div>
            </div>

            <!-- FORM RIGHT 50% -->
            <div class="w-full lg:w-1/2 flex items-center justify-center px-8">

                <!-- giảm max-width để form nhỏ lại -->
                <div class="w-full max-w-sm flex flex-col gap-6">

                    <div>
                        <h2 class="text-3xl font-bold">
                            Create Account
                        </h2>
                        <p class="text-slate-500 text-sm mt-2">
                            Fill in your details to get started.
                        </p>
                    </div>

                    <form action="register" method="post" class="flex flex-col gap-4">

                        <div>
                            <label class="text-sm font-semibold">Full Name</label>
                            <input name="fullname" type="text" required
                                   class="w-full px-3 py-2 rounded-md
                                   border border-slate-200
                                   focus:ring-2 focus:ring-primary/20
                                   focus:border-primary outline-none"
                                   placeholder="Enter your full name"/>
                        </div>

                        <div>
                            <label class="text-sm font-semibold">Email</label>
                            <input name="email" type="email" required
                                   class="w-full px-3 py-2 rounded-md
                                   border border-slate-200
                                   focus:ring-2 focus:ring-primary/20
                                   focus:border-primary outline-none"
                                   placeholder="Enter your email address"/>
                        </div>

                        <div>
                            <label class="text-sm font-semibold">Password</label>
                            <input name="password" type="password" required
                                   class="w-full px-3 py-2 rounded-md
                                   border border-slate-200
                                   focus:ring-2 focus:ring-primary/20
                                   focus:border-primary outline-none"
                                   placeholder="••••••••"/>
                        </div>

                        <div class="flex items-center gap-2 text-sm">
                            <input type="checkbox" name="agree" required class="w-4 h-4"/>
                            <label>I agree to the Terms</label>
                        </div>

                        <button type="submit"
                                class="w-full bg-primary hover:bg-primary/90
                                text-white text-sm font-semibold
                                py-2.5 rounded-md shadow">
                            Create Account
                        </button>

                        <div class="flex items-center my-4">
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

                                <i class="fa-brands fa-google text-red-500"></i>
                                <span class="text-sm font-medium text-gray-700">
                                    Google
                                </span>
                            </a>

                            <a href="${pageContext.request.contextPath}/facebook-login"
                               class="flex-1 flex items-center justify-center gap-2
                               h-11 bg-white border border-gray-300
                               rounded-md hover:shadow-sm transition-all duration-200">

                                <i class="fa-brands fa-facebook-f text-blue-600"></i>
                                <span class="text-sm font-medium text-gray-700">
                                    Facebook
                                </span>
                            </a>

                        </div>

                    </form>

                    <p class="text-center text-sm text-slate-600">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/views/customer/auth/login.jsp"
                           class="text-primary font-semibold hover:underline">
                            Sign In
                        </a>
                    </p>

                </div>
            </div>

        </main>

        <jsp:include page="/views/includes/footer.jsp"/>

    </body>
</html>