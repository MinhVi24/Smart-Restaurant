<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>GourmetDine | Online Food Menu</title>

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

    <style>
        body {
            font-family: "Plus Jakarta Sans", sans-serif;
        }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

<jsp:include page="/includes/header.jsp"/>

<main class="flex-1 max-w-7xl mx-auto w-full px-4 md:px-10 py-8">

    <div class="flex flex-col md:flex-row gap-8">

        <aside class="w-full md:w-64 flex-shrink-0">
            <div class="space-y-6">
                <h3 class="text-lg font-bold mb-4">Categories</h3>

                <div class="flex flex-col gap-2">
                    <a href="/pages/menu.jsp" class="px-4 py-3 rounded-xl bg-primary text-white font-bold">
                        All Items
                    </a>
                    <a href="#" class="px-4 py-3 rounded-xl hover:bg-slate-100">
                        Starters
                    </a>
                    <a href="#" class="px-4 py-3 rounded-xl hover:bg-slate-100">
                        Main Course
                    </a>
                    <a href="#" class="px-4 py-3 rounded-xl hover:bg-slate-100">
                        Desserts
                    </a>
                    <a href="#" class="px-4 py-3 rounded-xl hover:bg-slate-100">
                        Drinks
                    </a>
                </div>
            </div>
        </aside>

        <div class="flex-1">

            <div class="mb-8">
                <h1 class="text-4xl font-extrabold mb-2">Our Menu</h1>
                <p class="text-slate-500">
                    Discover our chef's selection of seasonal ingredients.
                </p>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- ITEM 1 -->
                <div class="bg-white rounded-2xl overflow-hidden shadow-sm border">
                    <img class="w-full h-48 object-cover"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuD-mQKTsPJUNkvci_t3l1jbbE4FjP0wTsKt8Gjqz2uTKa1wYat99JDtTzIPi91aorYmaVjnLVzaW3rlC2AWnW54DzmXIo7isxgfCDjDAcEXnQsugMGnZxd4MXwCd-j4HN70d1DHzLfgTXrOgeA7uZ-cw2XVJ6Ck--rNmmXpODzBlqkfXmqGB1eR5a7yBabzRGkUwR9G79Pij7htieqyG2PSegiLz6fy8-7qXSR3eMqBSy08iTXiKHAjDzMvTspWtY2YcygSepnsN8E"/>

                    <div class="p-5">
                        <div class="flex justify-between mb-2">
                            <h3 class="font-bold text-lg">Garden Spring Salad</h3>
                            <span class="text-primary font-bold">$14.00</span>
                        </div>

                        <p class="text-slate-500 text-sm mb-4">
                            Organic greens, cherry tomatoes, radish, citrus vinaigrette.
                        </p>

                        <form action="cart" method="post">
                            <input type="hidden" name="productId" value="1"/>
                            <button type="submit"
                                    class="w-full bg-primary/10 hover:bg-primary hover:text-white text-primary py-2.5 rounded-xl font-bold transition-all">
                                Add to Cart
                            </button>
                        </form>
                    </div>
                </div>


            </div>
        </div>

    </div>

</main>

<div class="fixed bottom-6 left-1/2 -translate-x-1/2 w-full max-w-2xl px-4 z-50">
    <div class="bg-background-dark text-white rounded-2xl p-4 flex justify-between shadow-2xl">
        <div>
            <p class="text-sm font-bold">3 Items in Cart</p>
            <p class="text-xs text-slate-400">
                Estimated Total: <span class="text-white font-bold">$68.00</span>
            </p>
        </div>

        <a href="/pages/checkout.jsp"
           class="bg-primary px-6 py-2.5 rounded-xl text-sm font-bold">
            Checkout
        </a>
    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>

</body>
</html>