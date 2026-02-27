<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="light" lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Table Booking - RestaurantSmart</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#f4c025",
                            "background-light": "#f8f8f5",
                            "background-dark": "#221e10",
                        },
                        fontFamily: {
                            display: ["Plus Jakarta Sans"]
                        }
                    }
                }
            }
        </script>

        <style>
            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
            .floor-plan-grid {
                background-image: radial-gradient(circle, #e5e7eb 1px, transparent 1px);
                background-size: 24px 24px;
            }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">

        <div class="flex flex-col min-h-screen">

            <jsp:include page="/views/includes/header.jsp"/>
            <%
                String floor = request.getParameter("floor");
                if (floor == null) {
                    floor = "1";
                }
            %>
            <main class="flex flex-1 overflow-hidden">
                <!-- Left Sidebar: Floor Selection -->
                <aside class="w-72 border-r border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-6 flex flex-col gap-6">
                    <div>
                        <h1 class="text-lg font-bold text-slate-900 dark:text-slate-100">Table Selection</h1>
                        <p class="text-slate-500 text-sm mt-1">Pick your preferred atmosphere</p>
                    </div>
                    <div class="flex flex-col gap-2">
                        <!-- Floor 1 Active -->
                        <a href="table-booking.jsp?floor=1"
                           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
                           <%= floor.equals("1") ? "bg-primary text-white shadow-lg shadow-primary/20"
                                   : "hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-700 dark:text-slate-300"%>">

                            <span class="material-symbols-outlined">layers</span>
                            <div class="text-left">
                                <p class="text-sm font-bold">Floor 1</p>
                                <p class="text-xs opacity-90">Main Dining Area</p>
                            </div>
                        </a>
                        <!-- Floor 2 -->
                        <a href="table-booking.jsp?floor=2"
                           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
                           <%= floor.equals("2") ? "bg-primary text-white shadow-lg shadow-primary/20"
                                   : "hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-700 dark:text-slate-300"%>">

                            <span class="material-symbols-outlined">deck</span>
                            <div class="text-left">
                                <p class="text-sm font-bold">Floor 2</p>
                                <p class="text-xs">Terrace & Bar</p>
                            </div>
                        </a>
                        <!-- Floor 3 -->
                        <a href="table-booking.jsp?floor=3"
                           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
                           <%= floor.equals("3") ? "bg-primary text-white shadow-lg shadow-primary/20"
                                   : "hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-700 dark:text-slate-300"%>">

                            <span class="material-symbols-outlined">stars</span>
                            <div class="text-left">
                                <p class="text-sm font-bold">Floor 3</p>
                                <p class="text-xs">VIP Suites</p>
                            </div>
                        </a>
                    </div>
                    <div class="mt-auto p-4 bg-slate-50 dark:bg-slate-800 rounded-xl">
                        <p class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-3">Legend</p>
                        <div class="flex flex-col gap-2">
                            <div class="flex items-center gap-2 text-xs">
                                <div class="size-3 rounded-sm bg-primary/20 border border-primary"></div>
                                <span>Recommended</span>
                            </div>
                            <div class="flex items-center gap-2 text-xs">
                                <div class="size-3 rounded-sm bg-slate-200 dark:bg-slate-700"></div>
                                <span>Available</span>
                            </div>
                            <div class="flex items-center gap-2 text-xs opacity-50">
                                <div class="size-3 rounded-sm bg-slate-400"></div>
                                <span>Occupied</span>
                            </div>
                        </div>
                    </div>
                </aside>
                <!-- Central Content: Floor Plan -->
                <section class="flex-1 bg-background-light dark:bg-background-dark p-8 overflow-auto flex flex-col">
                    <div class="flex justify-between items-end mb-8">
                        <div>
                            <nav class="flex gap-2 text-xs font-medium text-slate-400 mb-2">
                                <span>Booking</span>
                                <span>/</span>
                                <span class="text-primary">Floor <%= floor%> Selection</span>                            </nav>

                            <h2 class="text-3xl font-bold text-slate-900 dark:text-slate-100">
                                <%= floor.equals("1") ? "Main Dining Hall"
            : floor.equals("2") ? "Terrace & Bar"
            : "VIP Suites"%>
                            </h2>                        </div>
                        <div class="flex gap-2">
                            <div class="px-4 py-2 bg-white dark:bg-slate-800 rounded-lg shadow-sm border border-slate-200 dark:border-slate-700 flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary text-sm">groups</span>
                                <span class="text-sm font-semibold">4 People</span>
                            </div>
                        </div>
                    </div>
                    <!-- Interactive 2D Map -->
                    <div class="flex-1 rounded-3xl bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 shadow-xl floor-plan-grid relative min-h-[500px] overflow-hidden">
                        <!-- Entrance Label -->
                        <div class="absolute bottom-0 left-1/2 -translate-x-1/2 bg-slate-100 dark:bg-slate-800 px-8 py-2 rounded-t-xl border-x border-t border-slate-200 dark:border-slate-700 text-xs font-bold uppercase tracking-widest text-slate-400">Entrance</div>
                        <!-- Map Elements (Floor 1: Dining) -->
                        <div class="absolute inset-0 p-12 grid grid-cols-4 grid-rows-3 gap-12">
                            <!-- Table 1 (Recommended) -->
                            <div class="relative flex items-center justify-center group cursor-pointer">
                                <div class="absolute -top-6 bg-primary text-[10px] font-bold px-2 py-0.5 rounded text-white uppercase">Best View</div>
                                <div class="w-24 h-24 rounded-full bg-primary/10 border-2 border-primary flex flex-col items-center justify-center transition-transform hover:scale-105">
                                    <span class="text-sm font-bold text-slate-900 dark:text-slate-100">T-01</span>
                                    <span class="text-[10px] text-slate-500">4 Seats</span>
                                </div>
                                <!-- Chairs -->
                                <div class="absolute -top-2 size-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -bottom-2 size-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -left-2 size-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -right-2 size-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                            </div>
                            <!-- Table 2 (Available) -->
                            <div class="relative flex items-center justify-center cursor-pointer">
                                <div class="w-32 h-20 rounded-xl bg-slate-50 dark:bg-slate-800 border-2 border-slate-200 dark:border-slate-700 flex flex-col items-center justify-center transition-transform hover:border-primary">
                                    <span class="text-sm font-bold text-slate-900 dark:text-slate-100">T-02</span>
                                    <span class="text-[10px] text-slate-500">6 Seats</span>
                                </div>
                                <div class="absolute -left-2 top-2 size-5 rounded bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -left-2 bottom-2 size-5 rounded bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -right-2 top-2 size-5 rounded bg-slate-200 dark:bg-slate-700"></div>
                                <div class="absolute -right-2 bottom-2 size-5 rounded bg-slate-200 dark:bg-slate-700"></div>
                            </div>
                            <!-- Bar Area Representation -->
                            <div class="col-span-2 row-span-1 border-b-4 border-slate-100 dark:border-slate-800 flex items-center justify-center bg-slate-50/50 dark:bg-slate-800/30 rounded-t-3xl">
                                <div class="flex gap-4">
                                    <div class="size-8 rounded-full border-2 border-slate-200 dark:border-slate-700"></div>
                                    <div class="size-8 rounded-full border-2 border-slate-200 dark:border-slate-700"></div>
                                    <div class="size-8 rounded-full border-2 border-slate-200 dark:border-slate-700"></div>
                                    <div class="size-8 rounded-full border-2 border-slate-200 dark:border-slate-700"></div>
                                </div>
                                <span class="ml-4 text-xs font-bold text-slate-400 uppercase tracking-widest">Beverage Bar</span>
                            </div>
                            <!-- Table 3 (Occupied) -->
                            <div class="relative flex items-center justify-center opacity-40 grayscale">
                                <div class="w-20 h-20 rounded-full bg-slate-300 dark:bg-slate-700 flex flex-col items-center justify-center">
                                    <span class="text-sm font-bold">T-03</span>
                                </div>
                            </div>
                            <!-- Table 4 (Available) -->
                            <div class="relative flex items-center justify-center cursor-pointer">
                                <div class="w-20 h-20 rounded-lg bg-slate-50 dark:bg-slate-800 border-2 border-slate-200 dark:border-slate-700 flex flex-col items-center justify-center hover:border-primary">
                                    <span class="text-sm font-bold">T-04</span>
                                    <span class="text-[10px]">2 Seats</span>
                                </div>
                            </div>
                            <!-- Table 5 (Recommended) -->
                            <div class="relative flex items-center justify-center group cursor-pointer">
                                <div class="absolute -top-6 bg-primary text-[10px] font-bold px-2 py-0.5 rounded text-white uppercase">Quiet Spot</div>
                                <div class="w-24 h-24 rounded-full bg-primary/10 border-2 border-primary flex flex-col items-center justify-center">
                                    <span class="text-sm font-bold text-slate-900 dark:text-slate-100">T-05</span>
                                    <span class="text-[10px] text-slate-500">4 Seats</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mt-6 flex items-center gap-4 text-sm text-slate-500 bg-white dark:bg-slate-900 p-4 rounded-xl border border-slate-200 dark:border-slate-800">
                        <span class="material-symbols-outlined text-primary">info</span>
                        <p>Selected floor: <strong>Floor 1</strong>. Tables with gold borders are curated recommendations based on your history.</p>
                    </div>
                </section>
                <!-- Right Sidebar: Reservation Summary -->
                <aside class="w-80 border-l border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 p-6 flex flex-col gap-8 shadow-2xl">
                    <div>
                        <h3 class="text-lg font-bold text-slate-900 dark:text-slate-100 mb-4">Your Selection</h3>
                        <div class="space-y-4">
                            <div class="flex items-center gap-4 p-3 bg-slate-50 dark:bg-slate-800 rounded-xl">
                                <div class="bg-white dark:bg-slate-900 p-2 rounded-lg shadow-sm">
                                    <span class="material-symbols-outlined text-primary">calendar_today</span>
                                </div>
                                <div>
                                    <p class="text-[10px] font-bold text-slate-400 uppercase">Date</p>
                                    <p class="text-sm font-bold text-slate-900 dark:text-slate-100">Sat, 24 May 2024</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-4 p-3 bg-slate-50 dark:bg-slate-800 rounded-xl">
                                <div class="bg-white dark:bg-slate-900 p-2 rounded-lg shadow-sm">
                                    <span class="material-symbols-outlined text-primary">schedule</span>
                                </div>
                                <div>
                                    <p class="text-[10px] font-bold text-slate-400 uppercase">Time</p>
                                    <p class="text-sm font-bold text-slate-900 dark:text-slate-100">07:30 PM</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-4 p-3 bg-primary/10 border border-primary/20 rounded-xl">
                                <div class="bg-primary p-2 rounded-lg shadow-sm">
                                    <span class="material-symbols-outlined text-white">table_restaurant</span>
                                </div>
                                <div>
                                    <p class="text-[10px] font-bold text-slate-500 uppercase">Selected Table</p>
                                    <p class="text-sm font-bold text-slate-900 dark:text-slate-100">Table T-01 (Main Hall)</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="border-t border-slate-100 dark:border-slate-800 pt-6">
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm text-slate-500">Booking Fee</span>
                            <span class="text-sm font-bold">$10.00</span>
                        </div>
                        <div class="flex justify-between items-center mb-6">
                            <span class="text-sm text-slate-500">Minimum Spend</span>
                            <span class="text-sm font-bold">$120.00</span>
                        </div>
                        <button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-4 rounded-xl shadow-lg shadow-primary/30 transition-all flex items-center justify-center gap-2 group">
                            Confirm &amp; Pre-order
                            <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                        </button>
                        <p class="text-[10px] text-center text-slate-400 mt-4 px-4 leading-relaxed">
                            By clicking confirm, you agree to our restaurant's reservation policy. Cancellation fees may apply.
                        </p>
                    </div>
                    <div class="mt-auto">
                        <div class="rounded-2xl overflow-hidden relative h-32 group">
                            <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110" data-alt="Interior of the main dining room with warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAmMQd5D5ALoFzfQ1UZfdVevqkN4BEYOvoLu0gNYo8KRXRaLyhNJSFhXExTisIOr0u2vJ1PDDMpw6lyPu2wuraZKQRt3SMO2mkp4nVX5pYfBhkuc7VU4MXMM0plzbFQP-nHPArH_Blpi8pLLPhb3OsFWBe126kb3UKJa7zwGZF085Wz1Fo4ElYJhZYfxQi3aAYzIEiz1C9PCNzpbb-9p5dCm0xds7Y6ON0sFLnhJjEVe9NEqmW_PFPN7AHVIghsyEnZW7tgWpS6uDw"/>
                            <div class="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-3">
                                <p class="text-white text-xs font-bold">Floor 1 Preview</p>
                                <p class="text-white/70 text-[10px]">Elegant lighting &amp; acoustics</p>
                            </div>
                        </div>
                    </div>
                </aside>
            </main>

            <jsp:include page="/views/includes/footer.jsp"/>
        </div>

    </body>
</html>