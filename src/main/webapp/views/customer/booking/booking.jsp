<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <title>Table Reservation Form | RestaurantSmart</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">      

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

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
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">

        <jsp:include page="/views/includes/header.jsp" />

        <main class="flex-1 container mx-auto px-6 lg:px-20 py-12">

            <div class="max-w-2xl mx-auto bg-white dark:bg-slate-900 p-8 rounded-xl shadow-lg">

                <h1 class="text-3xl font-bold mb-6 text-center text-primary">
                    Reserve Your Table
                </h1>

                <form action="table-booking.jsp" method="get" class="space-y-6">
                    <div>
                        <label class="block text-sm font-medium mb-2">Full Name</label>
                        <input type="text" 
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Email</label>
                        <input type="email" 
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Phone</label>
                        <input type="text" 
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Date</label>
                        <input type="date" 
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Time</label>
                        <input type="time" 
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-2">Number of Guests</label>
                        <input type="number" min="1"
                               class="w-full rounded-lg border-gray-300 focus:border-primary focus:ring-primary"/>
                    </div>

                    <div class="text-center pt-4">
                        <button type="submit"
                                class="px-8 py-3 bg-primary text-white rounded-lg font-semibold hover:opacity-90 transition">
                            Confirm Reservation
                        </button>
                    </div>

                </form>
            </div>

        </main>

        <jsp:include page="/views/includes/footer.jsp" />

    </body>
</html>