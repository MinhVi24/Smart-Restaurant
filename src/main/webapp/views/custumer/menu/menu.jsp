<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>RestaurantSmart | Online Food Menu</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">        <link rel="stylesheet"
                                                                                                             href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

        <jsp:include page="/views/includes/header.jsp"/>

        <main class="flex-1 max-w-7xl mx-auto w-full px-4 md:px-10 py-8">

            <div class="flex flex-col md:flex-row gap-8">

                <aside class="w-full md:w-64 flex-shrink-0">
                    <div class="space-y-6">
                        <h3 class="text-lg font-bold mb-4">Categories</h3>

                        <div class="flex flex-col gap-2">
                            <a href="${pageContext.request.contextPath}/menu"
                               class="px-4 py-3 rounded-xl bg-primary text-white font-bold">
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

                        <c:choose>

                            <c:when test="${empty foods}">
                                <div class="col-span-3 text-center py-20">
                                    <h2 class="text-2xl font-bold text-slate-400">
                                        There are no dishes in the system yet.                                    </h2>
                                    <p class="text-slate-400 mt-2">
                                        Please add data to the food table.                                    </p>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="food" items="${foods}">
                                    <div class="bg-white rounded-2xl overflow-hidden shadow-md border hover:shadow-xl transition">

                                        <div class="bg-white p-4">
                                            <img class="w-full h-48 object-contain"
                                                 src="${pageContext.request.contextPath}/${food.image}"
                                                 alt="${food.name}" />
                                        </div>

                                        <div class="p-5">
                                            <div class="flex justify-between mb-2">
                                                <h3 class="font-bold text-lg">${food.name}</h3>
                                                <span class="text-primary font-bold text-lg">
                                                    $${food.price}
                                                </span>
                                            </div>

                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="productId" value="${food.id}"/>
                                                <button type="submit"
                                                        class="w-full bg-primary text-white py-2.5 rounded-xl font-bold hover:bg-orange-600 transition">
                                                    Add to Cart
                                                </button>
                                            </form>
                                        </div>

                                    </div>
                                </c:forEach>
                            </c:otherwise>

                        </c:choose>


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

                <a href="${pageContext.request.contextPath}/views/custumer/checkout/checkout.jsp">
                    <button 
                        class="bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-6 rounded-xl shadow-lg transition duration-300 transform hover:scale-105">
                        Checkout
                    </button>
                </a>
            </div>
        </div>

        <jsp:include page="/views/includes/footer.jsp"/>

    </body>
</html>