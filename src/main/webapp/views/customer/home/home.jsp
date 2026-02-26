<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">        <link rel="stylesheet"
                                                                                                             href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#800020",
                            "accent": "#D4AF37",
                            "background-light": "#FFFDF5",
                            "background-dark": "#1A0F0A",
                        },
                        fontFamily: {
                            "display": ["Plus Jakarta Sans", "sans-serif"]
                        },
                        borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                    },
                },
            }
        </script>
        <style>
            body {
                font-family: "Plus Jakarta Sans", sans-serif;
            }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">
        <div class="relative flex h-auto min-h-screen w-full flex-col group/design-root">
            <div class="layout-container flex h-full grow flex-col">

                <jsp:include page="/views/includes/header.jsp"/>

                <main class="flex flex-col flex-1">

                    <div class="@container w-full">
                        <div class="p-0 md:p-6 lg:px-20">
                            <div class="relative flex min-h-[600px] flex-col gap-8 bg-cover bg-center bg-no-repeat md:rounded-3xl items-center justify-center p-6 text-center overflow-hidden" data-alt="Exquisite fine dining table setting with wine" style='background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url("https://lh3.googleusercontent.com/aida-public/AB6AXuAmBu8wHJFrlDhIsIXUsAAfakw_b87yrA5ZpKAXZJf0mQd9C6dsGR34h_83XuZmC368Cac8EMNrtDSGWvkJ4vGnC9Sno6p_AS1Jp0xDVx1Fcm7Dl3mZUEPDhPEDN5p0kD9bfor0DS4vHa1OtL7mrZsuWNGjZol6-OH1vvzkdhM3s75LZ-sPEhIXD5w4y5Gg5rrTGcvgSpA_MelQ07pQp-Dkv7jWiUbXIsxc3k_fIn9xvL8kWKkqTYbHdIOvGpMMrXjy45nOx3xgOkc");'>
                                <div class="flex flex-col gap-4 max-w-3xl animate-in fade-in slide-in-from-bottom-4 duration-1000">
                                    <span class="text-accent font-bold tracking-[0.2em] uppercase text-sm">Established 1994</span>
                                    <h1 class="text-white text-5xl md:text-7xl font-extrabold leading-tight tracking-tight">
                                        A Symphony of <br/><span class="text-accent italic font-serif">Fine Flavors</span>
                                    </h1>
                                    <p class="text-slate-200 text-lg md:text-xl font-light leading-relaxed max-w-2xl mx-auto">
                                        Indulge in a culinary journey crafted by world-renowned chefs. Where every ingredient tells a story and every plate is a masterpiece.
                                    </p>
                                </div>
                                <div class="flex flex-wrap gap-4 justify-center mt-4">
                                    <button class="flex min-w-[160px] cursor-pointer items-center justify-center rounded-full h-14 px-8 bg-primary text-white text-base font-bold shadow-xl hover:scale-105 transition-transform border-2 border-primary">
                                        <span class="truncate">Book a Table</span>
                                    </button>
                                    <button class="flex min-w-[160px] cursor-pointer items-center justify-center rounded-full h-14 px-8 bg-transparent text-white text-base font-bold border-2 border-white/50 backdrop-blur-sm hover:bg-white/10 transition-all">
                                        <span class="truncate">View Menu</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="px-6 md:px-20 pt-16 pb-8 text-center">
                        <span class="text-primary font-bold text-sm tracking-widest uppercase">Our Selection</span>
                        <h2 class="text-slate-900 dark:text-slate-100 text-4xl font-bold mt-2">Chef's Seasonal Specials</h2>
                        <div class="h-1 w-20 bg-accent mx-auto mt-4 rounded-full"></div>
                    </div>

                    <div class="px-6 md:px-20 pb-20">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">

                            <div class="flex flex-col group cursor-pointer">
                                <div class="relative overflow-hidden rounded-2xl aspect-[4/3] mb-4 shadow-lg">
                                    <div class="w-full h-full bg-center bg-cover transition-transform duration-500 group-hover:scale-110" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBmxrwqRgFIRubMcSzpBaK_IPGDZSpciHASLcC7Zk_yAXZFT4vWRrPB0KsRMH0pQz7qJhb9GYhvl9RLyzvc5S6t5qatmqvWT3dkwpoCjXiA6KB8FqscfibpEoloBU5N_v7iwhHQpEI0GPjzssKPbhylf0aq-tzo-4DywCLfKaiUopB2s0kKgkrOvMjODsvfEPfbu56P4mb7GZUFpV4woiuVMCXz6ck5NHyCe-mbYRAZtu7y-U_yTaHyvYSnI4GkXVJ7H1AS5zdiRio");'></div>
                                    <div class="absolute top-4 right-4 bg-accent text-primary font-bold px-3 py-1 rounded-full text-xs shadow-md">
                                        Best Seller
                                    </div>
                                </div>
                                <div class="px-2">
                                    <div class="flex justify-between items-center mb-1">
                                        <h3 class="text-slate-900 dark:text-slate-100 text-xl font-bold group-hover:text-primary transition-colors">Wagyu Ribeye Steak</h3>
                                        <span class="text-primary font-bold">$65</span>
                                    </div>
                                    <p class="text-slate-600 dark:text-slate-400 text-sm leading-relaxed">
                                        Grade A5 Wagyu with roasted root vegetables, truffle mash, and a signature red wine reduction.
                                    </p>
                                </div>
                            </div>

                            <div class="flex flex-col group cursor-pointer">
                                <div class="relative overflow-hidden rounded-2xl aspect-[4/3] mb-4 shadow-lg">
                                    <div class="w-full h-full bg-center bg-cover transition-transform duration-500 group-hover:scale-110" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCMHvQUZX8gWn4x23eBMzO7P6Wd0XfvmPPKPlLlTPi7ZtiUjqc1AkIKPvxxKMNuvFtXgjUs4HtOigAudjFM4qNsY8ABV1mPE2AuRSdUA_QRYedInNsSctQgLS1uAgEkN1MV5LNKUEIBnnxFN7wBwisRFvcJqzO1CA4NaFSJAa7UPEcvjZPVLwhjoahNbGNKuejnqxWQy2G71sUKQNY05_wUktIkIwUPYJ-zOGTOPda71-4zV5STVHR3G2lgwJhf0FvulG4lBkjjHjk");'></div>
                                </div>
                                <div class="px-2">
                                    <div class="flex justify-between items-center mb-1">
                                        <h3 class="text-slate-900 dark:text-slate-100 text-xl font-bold group-hover:text-primary transition-colors">Hokkaido Scallops</h3>
                                        <span class="text-primary font-bold">$42</span>
                                    </div>
                                    <p class="text-slate-600 dark:text-slate-400 text-sm leading-relaxed">
                                        Pan-seared jumbo scallops served on a bed of vibrant pea purée with crispy pancetta crumbles.
                                    </p>
                                </div>
                            </div>

                            <div class="flex flex-col group cursor-pointer">
                                <div class="relative overflow-hidden rounded-2xl aspect-[4/3] mb-4 shadow-lg">
                                    <div class="w-full h-full bg-center bg-cover transition-transform duration-500 group-hover:scale-110" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDXNvOG1HPKqkjTnLjfgsXn4ppQFoMK_xTPcU_Ndx8mM84lbzBECBSwlQgblsJdmbxWYSObLoLVR3eYA7cmYmLDeC7liRv8MBLFaFptIg1ajiMb3iyuYjRkHgfZnytRCdLvVt2cicIYYvJ6fw1b2Y55VJdV3iI9zyVL4w685mHgToISnZ4fhcWUsE9diYfsELx8KS3PfaLNyO2sM1E1KaLuIOjCzMxgQwl-y1cHNta6hhIdlcbxzCAjxvT9xZfW_if8NYW23TjY9GI");'></div>
                                </div>
                                <div class="px-2">
                                    <div class="flex justify-between items-center mb-1">
                                        <h3 class="text-slate-900 dark:text-slate-100 text-xl font-bold group-hover:text-primary transition-colors">Wild Truffle Pasta</h3>
                                        <span class="text-primary font-bold">$38</span>
                                    </div>
                                    <p class="text-slate-600 dark:text-slate-400 text-sm leading-relaxed">
                                        Handmade tagliatelle tossed with seasonal black truffles, aged parmesan, and forest mushrooms.
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="bg-primary/5 py-20 px-6">
                        <div class="max-w-4xl mx-auto flex flex-col items-center text-center gap-8">
                            <div class="size-16 flex items-center justify-center bg-primary rounded-full text-accent shadow-xl ring-8 ring-primary/10">
                                <span class="material-symbols-outlined text-3xl">event_seat</span>
                            </div>
                            <div class="flex flex-col gap-4">
                                <h2 class="text-slate-900 dark:text-slate-100 text-3xl md:text-5xl font-bold leading-tight">
                                    Join Us for an Unforgettable Evening
                                </h2>
                                <p class="text-slate-600 dark:text-slate-400 text-lg md:text-xl font-light max-w-2xl mx-auto">
                                    Whether it's a romantic date, a business dinner, or a family celebration, we provide the perfect setting for your most cherished moments.
                                </p>
                            </div>
                            <div class="flex flex-wrap gap-4 justify-center">
                                <button class="flex min-w-[200px] cursor-pointer items-center justify-center rounded-full h-14 px-8 bg-primary text-white text-lg font-bold shadow-xl hover:shadow-primary/40 transition-all">
                                    <span class="truncate">Make a Reservation</span>
                                </button>
                                <div class="flex items-center gap-2 text-primary font-semibold py-4 px-6 cursor-pointer hover:underline">
                                    <span class="material-symbols-outlined">call</span>
                                    <span>+1 (555) 123-4567</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </main>

                <jsp:include page="/views/includes/footer.jsp"/>

            </div>

        </div>

    </body>
</html>