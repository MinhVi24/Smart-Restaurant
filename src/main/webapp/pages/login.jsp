<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - Gourmet Haven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#ae042f",
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
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

<jsp:include page="/includes/header.jsp"/>
    <main class="flex-1 flex overflow-hidden">

        <div class="hidden lg:block lg:w-1/2 bg-login-hero bg-cover bg-center relative">
            <div class="absolute inset-0 bg-primary/20 backdrop-brightness-75"></div>
            <div class="absolute bottom-12 left-12 right-12 text-white">
                <h1 class="text-5xl font-extrabold mb-4 drop-shadow-lg">
                    Experience Culinary Excellence
                </h1>
                <p class="text-xl opacity-90 drop-shadow-md">
                    Join our exclusive dining community and manage your table reservations with ease.
                </p>
            </div>
        </div>

        <div class="w-full lg:w-1/2 flex items-center justify-center p-8 md:p-16 lg:p-24 overflow-y-auto">
            <div class="w-full max-w-[440px] flex flex-col gap-8">

                <div>
                    <h2 class="text-3xl font-extrabold">Welcome Back</h2>
                    <p class="text-slate-500">Please enter your details to sign in.</p>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="post" class="flex flex-col gap-6">

                    <div>
                        <label class="text-sm font-semibold">Email Address</label>
                        <input name="email" type="email"
                               class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none"
                               placeholder="name@example.com" required/>
                    </div>

                    <div>
                        <label class="text-sm font-semibold">Password</label>
                        <input name="password" type="password"
                               class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none"
                               placeholder="••••••••" required/>
                    </div>

                    <div class="flex items-center gap-2">
                        <input type="checkbox" name="remember" class="w-4 h-4"/>
                        <label class="text-sm">Remember me</label>
                    </div>

                    <button type="submit"
                            class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3.5 rounded-lg shadow-lg">
                        Sign In
                    </button>

                </form>

                <p class="text-center text-sm text-slate-600">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/pages/register.jsp" class="text-primary font-bold hover:underline">
                        Create Account
                    </a>
                </p>

            </div>
        </div>

    </main>

    <jsp:include page="/includes/footer.jsp"/>

</body>
</html>