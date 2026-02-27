<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Prestige Spotlight | Culinary Excellence</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#f2b90d",
                            "background-light": "#f8f8f5",
                            "background-dark": "#181611",
                            "accent-dark": "#27241b",
                            "border-gold": "#544e3b"
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"]
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

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-900 antialiased">

        <div class="relative flex min-h-screen w-full flex-col overflow-x-hidden">
            <div class="layout-container flex h-full grow flex-col">

                <jsp:include page="/views/includes/header.jsp" />
                <main class="flex-1 max-w-7xl mx-auto w-full px-6 md:px-10 py-12">
                    <div class="flex flex-col lg:flex-row gap-12 items-start">
                        <!-- LEFT COLUMN: Content Blocks -->
                        <div class="w-full lg:w-1/2 flex flex-col gap-10">
                            <!-- Hero Header -->
                            <div class="flex flex-col gap-4">
                                <span class="text-primary font-bold tracking-[0.2em] text-xs uppercase">Est. 1988</span>
                                <h1 class="text-4xl md:text-6xl font-black leading-tight tracking-tight text-slate-900">
                                    Culinary Excellence <span class="text-primary">Redefined.</span>
                                </h1>
                                <p class="text-slate-600 text-lg leading-relaxed max-w-xl">
                                    Experience the pinnacle of fine dining where heritage meets innovation in every exquisite bite. A symphony of flavors crafted for the most discerning palates.
                                </p>
                            </div>
                            <!-- Prestigious Awards -->
                            <div class="flex flex-col gap-4">
                                <h3 class="text-primary text-sm font-bold uppercase tracking-widest border-b border-border-gold pb-2 w-max">Prestigious Awards</h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div class="flex gap-4 rounded-xl border border-border-gold bg-white p-5 hover:bg-accent-dark/60 transition-colors">
                                        <div class="text-primary pt-1">
                                            <span class="material-symbols-outlined text-3xl">star</span>
                                        </div>
                                        <div class="flex flex-col gap-1">
                                            <h4 class="text-slate-900 text-base font-bold">Michelin Star</h4>
                                            <p class="text-slate-600 text-sm">Recognized for exceptional culinary quality and technique.</p>
                                        </div>
                                    </div>
                                    <div class="flex gap-4 rounded-xl border border-border-gold bg-white p-5 hover:bg-accent-dark/60 transition-colors">
                                        <div class="text-primary pt-1">
                                            <span class="material-symbols-outlined text-3xl">trophy</span>
                                        </div>
                                        <div class="flex flex-col gap-1">
                                            <h4 class="text-slate-900 text-base font-bold">Best Fine Dining 2023</h4>
                                            <p class="text-slate-600 text-sm">Voted #1 luxury experience by the International Gourmet Guide.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Chef's Legacy -->
                            <div class="flex flex-col gap-4">
                                <h3 class="text-primary text-sm font-bold uppercase tracking-widest border-b border-border-gold pb-2 w-max">Chef's Legacy</h3>
                                <div class="rounded-xl border border-border-gold bg-white p-6">
                                    <div class="flex items-center gap-4 mb-4">
                                        <div class="h-12 w-12 rounded-full border-2 border-primary bg-cover bg-center" data-alt="Portrait of Head Chef in professional uniform" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDGI2-po0BZpGCwVyRO0ak_nZt5T71lWE-olcM4Zvzol14A2ExV73hoatel67oELFF051SUL8577bUnZK26_v6eqIOgxsWSy_2YHG1GNyUz7wm9QVsjXXHQcWHVjMWN6Vd4EPRxYccwuDF0hKoNgjE6W7XZ1ZXkJ0u6ULRQkQZINVFJMMFopV_1vA4R3r7keGHlDIXfZpjz5PxBpR7_GEXihOp26V3sLXie76-i0lrrfMbJWxCBYnspQrkTaHwoZERYDiP06En2zOk')"></div>
                                        <div>
                                            <h4 class="text-slate-900 font-bold text-lg">Master Chef Julian Vance</h4>
                                            <p class="text-primary text-xs font-semibold uppercase">Executive Head Chef</p>
                                        </div>
                                    </div>
                                    <p class="text-slate-600 text-sm leading-relaxed italic">
                                        "With over 15 years in Michelin-starred kitchens globally and dual culinary degrees from Paris, I believe in respecting the ingredient while challenging the tradition."
                                    </p>
                                </div>
                            </div>
                            <!-- Signature Best-Seller -->
                            <div class="flex flex-col gap-4">
                                <h3 class="text-primary text-sm font-bold uppercase tracking-widest border-b border-border-gold pb-2 w-max">Signature Best-Seller</h3>
                                <div class="rounded-xl border border-border-gold bg-white p-6 flex flex-col md:flex-row gap-6 items-center">
                                    <div class="w-full md:w-32 h-32 flex-shrink-0 rounded-lg bg-cover bg-center" data-alt="Close up of a luxury wagyu truffle dish" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuB59TmZ1QuY8A2Fxt0AytqwH6sdP8CwtRV8L4Dc8BuGTPUgMVvDWb83aIWRMwjrqkWihJ-MWWM-Lghp9GcYMNZXfbw6ouoF9ypHMbzUlQowF15sr0i94N8Cy8EeTTc1fCt1GrAg3493SC9FBORJ10hSE0AjjzP6fPZd5-jNXCgT3tcXqXRnqd8Lq9ouxgHVy615YzxOeGby5YTTFhJfqv4DwZZ_aSct63JCM6PtmH0MjBJc7oalxVnds8pagX7yydwTgh33OXgYfl4')"></div>
                                    <div class="flex-1">
                                        <div class="flex justify-between items-start mb-2">
                                            <h4 class="text-slate-900 font-bold text-xl">Wagyu Truffle Sensation</h4>
                                            <span class="text-primary font-bold">$120</span>
                                        </div>
                                        <p class="text-slate-600 text-sm">
                                            Grade A5 Miyazaki Wagyu, aged for 45 days, served with shaved black winter truffles and a signature red wine reduction.
                                        </p>
                                        <div class="mt-4 flex gap-2">
                                            <span class="px-2 py-1 bg-primary/10 text-primary text-[10px] font-bold uppercase rounded">Limited Selection</span>
                                            <span class="px-2 py-1 bg-primary/10 text-primary text-[10px] font-bold uppercase rounded">Award Winning</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- RIGHT COLUMN: Visual Spotlight -->
                        <div class="w-full lg:w-1/2 lg:sticky lg:top-32">
                            <div class="relative group">
                                <!-- Main Large Image -->
                                <div class="aspect-[3/4] w-full rounded-2xl overflow-hidden border border-border-gold shadow-2xl relative">
                                    <div class="absolute inset-0 bg-gradient-to-t from-background-light/80 to-transparent z-10"></div>
                                    <img alt="High-end restaurant interior with gold accents" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" data-alt="Luxurious dark restaurant interior with warm lighting" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCw-tbbrrtOpHDmWs5US9TMYPC9z_06D-du_jomvJaV3-RM7d9HgPGReMnr8HhrHRBTD66X-MyxU1w4VRPo1gZhhbmLEMadAXo3bP-ij5lIiX6TYHBeMDqAywJiy13nMthXvQ0GHI-xSIgwaa_SMro50oZyJ5hUeK49BPXOEby2ccrKjz0mfXOmaanjp7V6Z9dalH80SvhsZBStbdRgmh4VQcSmuZGgzSGlQdGhtRIvWkaRneOutMuzcZ7jNKRMAW9VZoAAhApZZgU"/>
                                    <!-- Floating Detail Card -->
                                    <div class="absolute bottom-8 left-8 right-8 z-20 p-6 bg-white/80 backdrop-blur-md border border-border-gold rounded-xl">
                                        <div class="flex justify-between items-end">
                                            <div>
                                                <p class="text-primary text-xs font-bold uppercase mb-1">Current View</p>
                                                <h3 class="text-slate-900 text-2xl font-black">The Grand Dining Hall</h3>
                                                <p class="text-slate-600 text-sm mt-1 flex items-center gap-1">
                                                    <span class="material-symbols-outlined text-sm">location_on</span>
                                                    Manhattan, New York
                                                </p>
                                            </div>
                                            <button class="bg-primary text-background-dark p-3 rounded-full flex items-center justify-center hover:bg-white transition-colors">
                                                <span class="material-symbols-outlined">fullscreen</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!-- Mini Gallery Selector -->
                                <div class="grid grid-cols-3 gap-4 mt-6">
                                    <div class="aspect-square rounded-lg border-2 border-primary overflow-hidden cursor-pointer relative group/thumb">
                                        <img class="w-full h-full object-cover opacity-100" data-alt="Thumbnail of restaurant interior" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCzYIvMfgW3v8d-pyBIpB73ts4V6487fGOilvWhUUY9qNQ54DOUGBS6R-Uw5oUTES171f2KyaVmZ18WvNmXScV53m7m3LDxFdSrrWlF1e3WFecoZF9j1OgTMDv0sOEfx79dgM6BpiM0AEycXsY82DitpTFgpFkFAXxwkEUfOMVY88IGZTggFqEPV-oElfpS513iRJb4nPN0oj16EBDscdFgC5ak0RuaBMUdllfooNVrlExMgwSFMlThnqh3rtNdY2LHeZeJe6vNRP8"/>
                                        <div class="absolute inset-0 bg-primary/20 flex items-center justify-center">
                                            <span class="text-background-dark font-black text-xs">VIEW</span>
                                        </div>
                                    </div>
                                    <div class="aspect-square rounded-lg border border-border-gold overflow-hidden cursor-pointer hover:border-primary transition-all relative group/thumb">
                                        <img class="w-full h-full object-cover opacity-60 group-hover/thumb:opacity-100 transition-opacity" data-alt="Thumbnail portrait of professional chef" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCr5F87gTlxICvckoSJsyXWVKFve7LjVdyahZuKQLzIUerOYCWL3HrAO_nFCKPs_1HWugBVfZHOSGaiEBxzzPh9nUrgyGSO01N9VTQa0b13i5z0Ui1-9kAg_67znIAKXBgeye1byCyIjIlS3h3il6ROuR4E21mTICRj-vZWi2-nFiBqSYoe-XVZeZJJ1jyLMSTPXJS_JQj14VRX8i3jM5-9UD__k8MLKzeE4bSa_04nDvtD7_i9nkUFevqMLJJhd9xb292BHMRVhCw"/>
                                    </div>
                                    <div class="aspect-square rounded-lg border border-border-gold overflow-hidden cursor-pointer hover:border-primary transition-all relative group/thumb">
                                        <img class="w-full h-full object-cover opacity-60 group-hover/thumb:opacity-100 transition-opacity" data-alt="Thumbnail of signature wagyu dish" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDwZEB1th6rcX2DCW01yh4e0iwptoD9Pw-xpv5gx5bLjd4NChZrr4FciDEcSW-b8yyrsNIp2BGI080I9Gt6vZsfV1f32WK5jXkJYepG5-P6k4c4f2LLrwcmpYzRztjCzFPwO9hc9_jUcAbxY5tLJqV-p_K-CLOxEqJI35TnFdWd3xyi0YxlrkTnFOwrIAYTw4kHNqEpHXpK0iRln8IyReH6Wh7QMYBJapgh1mPHMQzEAkxt7fJAL9CYir84ssnLtVidA32OWUwe0iM"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <jsp:include page="/views/includes/footer.jsp" />

            </div>
        </div>

    </body>
</html>