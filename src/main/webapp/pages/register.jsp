<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register - TastyTable</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#ee7c2b",
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
</head>

<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

<jsp:include page="/includes/header.jsp"/>

<main class="flex-1 flex overflow-hidden">

    <div class="w-full lg:w-1/2 flex flex-col justify-center px-6 md:px-16 lg:px-24 py-12 bg-white dark:bg-background-dark">
        <div class="max-w-md w-full mx-auto">

            <div class="mb-10">
                <h1 class="text-4xl font-black mb-2">Create Account</h1>
                <p class="text-slate-500 dark:text-slate-400 text-lg">
                    Join our community of food lovers today.
                </p>
            </div>

            <form action="register" method="post" class="space-y-5">

                <div>
                    <label class="text-sm font-bold">Full Name</label>
                    <input name="fullname" type="text" required
                           class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary outline-none"
                           placeholder="John Doe"/>
                </div>

                <div>
                    <label class="text-sm font-bold">Email Address</label>
                    <input name="email" type="email" required
                           class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary outline-none"
                           placeholder="john@example.com"/>
                </div>

                <div>
                    <label class="text-sm font-bold">Phone Number</label>
                    <input name="phone" type="tel"
                           class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary outline-none"
                           placeholder="+1 (555) 000-0000"/>
                </div>

                <div>
                    <label class="text-sm font-bold">Password</label>
                    <input name="password" type="password" required
                           class="w-full px-4 py-3 rounded-lg border border-slate-200 focus:ring-2 focus:ring-primary outline-none"
                           placeholder="••••••••"/>
                </div>

                <div class="space-y-3 pt-2">
                    <label class="flex items-start gap-3">
                        <input name="agree" type="checkbox" required
                               class="mt-1 w-5 h-5 text-primary"/>
                        <span class="text-sm">
                            I agree to the Terms and Conditions.
                        </span>
                    </label>

                    <label class="flex items-start gap-3">
                        <input name="subscribe" type="checkbox"
                               class="mt-1 w-5 h-5 text-primary"/>
                        <span class="text-sm">
                            Send me updates and special offers.
                        </span>
                    </label>
                </div>

                <button type="submit"
                        class="w-full bg-primary text-white py-4 rounded-xl font-bold text-lg shadow-lg hover:opacity-90 transition-all">
                    Create Account
                </button>

            </form>

            <div class="mt-8 text-center">
                <p class="text-slate-500 dark:text-slate-400">
                    Already have an account?
                    <a href="/pages/home.jsp" class="text-primary font-bold hover:underline ml-1">
                        Log In
                    </a>
                </p>
            </div>

        </div>
    </div>

    <div class="hidden lg:block lg:w-1/2 relative">
        <div class="absolute inset-0 bg-cover bg-center"
             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAL6iXtthaLGR9mSTgdRB0CmISWWDcQdSbYGHeQa8S8htDEdPJy8PsNp2kVXy9r-PPBcSChd5zteF1wRsmJjEPykPt1-56RusilVN9vb6VYxZHkyTmFlGsyzfBawA0fHlrM6yf7FXhMWy6RcKBl1nqeBdOpP7hvXZC5O_5-U_szYzciESHvQqOPnzgoDmszEtO0-PybBI_iNbbFyT31G0-XbWnmICePrFIe6t-kLEPij78v254KpW8e7Yo4LYI0lPUuva9xLYfEFhU');">
        </div>
    </div>

</main>

<jsp:include page="/includes/footer.jsp"/>

</body>
</html>