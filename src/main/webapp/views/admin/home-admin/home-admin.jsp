
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>All-in-One Restaurant Admin Control</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&amp;family=Playfair+Display:wght@400;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#f2b90d",
                        "accent-burgundy": "#4a0404",
                        "charcoal": "#1a1a1a",
                        "background-light": "#f8f8f5",
                        "background-dark": "#221e10",
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"],
                        "serif": ["Playfair Display", "serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.125rem",
                        "lg": "0.25rem",
                        "xl": "0.5rem",
                        "full": "0.75rem"
                    },
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 24;
        }
        body {
            font-family: 'Inter', sans-serif;
        }
        h1, h2, h3, .serif-heading {
            font-family: 'Playfair Display', serif;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex">
<!-- Persistent Vertical Sidebar -->
<aside class="w-72 bg-white dark:bg-charcoal border-r border-slate-200 dark:border-slate-800 flex flex-col h-screen sticky top-0">
<div class="p-8 flex items-center gap-3">
<div class="bg-primary size-10 flex items-center justify-center rounded-lg">
<span class="material-symbols-outlined text-accent-burgundy font-bold">restaurant</span>
</div>
<div>
<h1 class="text-xl font-bold tracking-tight text-charcoal dark:text-white leading-none">Luxe Bistro</h1>
<p class="text-[10px] uppercase tracking-[0.2em] text-slate-400 font-semibold mt-1">Management Console</p>
</div>
</div>
<nav class="flex-1 px-4 space-y-1 overflow-y-auto">
<a class="flex items-center gap-4 px-4 py-3 bg-primary/10 text-accent-burgundy rounded-lg border-l-4 border-primary" href="#">
<span class="material-symbols-outlined">dashboard</span>
<span class="text-sm font-medium">Dashboard</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">calendar_month</span>
<span class="text-sm font-medium">Reservations</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">receipt_long</span>
<span class="text-sm font-medium">Order Management</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">menu_book</span>
<span class="text-sm font-medium">Menu Editor</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">groups</span>
<span class="text-sm font-medium">Customer Database</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">badge</span>
<span class="text-sm font-medium">Staff Management</span>
</a>
<a class="flex items-center gap-4 px-4 py-3 text-slate-500 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="#">
<span class="material-symbols-outlined">payments</span>
<span class="text-sm font-medium">Financial Reports</span>
</a>
</nav>
<div class="p-6 border-t border-slate-100 dark:border-slate-800">
<div class="flex items-center gap-3 p-3 bg-slate-50 dark:bg-slate-800 rounded-xl mb-4">
<div class="size-10 rounded-full bg-cover bg-center border-2 border-primary/20" data-alt="Administrator profile picture portrait" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC1yGku7mOhKZjLXJQXeFQpi6krKEHfVHGSxtZQlul-6sUM6o15iPsoQhWdDRPFZf5gWHMn7bGUl3r3LohA_Hoy-qg6SC4OUCQLoLcIfHsXoiOOsi89OkLf19b4Obg7pSIzBHtSPg9i64gooKVgUxv-x6Wc4mBdINyLxpJY8gyxeMgDyzU8FZovoBf173EJ4XaxKnf1h9qz4-sCWuQhc_GMR5jDrGGmf7mreV1xASW5U9bjEI7zeaZY3OsUcW8gapkxcWeFZPuy3D8')"></div>
<div class="flex-1 min-w-0">
<p class="text-sm font-semibold truncate">Jameson Thorne</p>
<p class="text-[10px] text-slate-400 truncate uppercase">Executive Admin</p>
</div>
</div>
<button class="w-full flex items-center justify-center gap-2 py-2.5 bg-accent-burgundy text-white rounded-lg text-sm font-medium hover:bg-charcoal transition-colors">
<span class="material-symbols-outlined text-sm">logout</span>
                Logout
            </button>
</div>
</aside>
<!-- Main Content -->
<main class="flex-1 flex flex-col h-screen overflow-y-auto">
<!-- Header -->
<header class="h-20 bg-white/80 dark:bg-charcoal/80 backdrop-blur-md border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-10 sticky top-0 z-10">
<div class="flex flex-col">
<h2 class="text-2xl font-bold text-charcoal dark:text-white leading-tight">Global Overview</h2>
<p class="text-xs text-slate-500">Sunday, October 22, 2023 | Lunch Service Active</p>
</div>
<div class="flex items-center gap-6">
<div class="relative">
<span class="material-symbols-outlined text-slate-400 cursor-pointer hover:text-primary transition-colors">search</span>
</div>
<div class="relative">
<span class="material-symbols-outlined text-slate-400 cursor-pointer hover:text-primary transition-colors">notifications</span>
<span class="absolute -top-1 -right-1 size-2.5 bg-accent-burgundy border-2 border-white rounded-full"></span>
</div>
<button class="bg-primary px-5 py-2 rounded-lg text-accent-burgundy text-sm font-bold shadow-sm hover:shadow-md transition-all">
                    New Reservation
                </button>
</div>
</header>
<!-- Dashboard Content -->
<div class="p-10 space-y-10">
<!-- Summary Cards -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
<!-- Revenue -->
<div class="bg-white dark:bg-charcoal p-6 rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="text-slate-400 material-symbols-outlined">payments</span>
<span class="text-[10px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded">+12.5%</span>
</div>
<p class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Daily Revenue</p>
<h3 class="text-2xl font-black mt-1">$12,450.00</h3>
</div>
<!-- Reservations -->
<div class="bg-white dark:bg-charcoal p-6 rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="text-slate-400 material-symbols-outlined">event_available</span>
<span class="text-[10px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded">+5.2%</span>
</div>
<p class="text-xs font-semibold text-slate-400 uppercase tracking-wider">New Reservations</p>
<h3 class="text-2xl font-black mt-1">24</h3>
</div>
<!-- Pending Orders -->
<div class="bg-white dark:bg-charcoal p-6 rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="text-slate-400 material-symbols-outlined">hourglass_empty</span>
<span class="text-[10px] font-bold text-accent-burgundy bg-red-50 px-2 py-1 rounded">-2.1%</span>
</div>
<p class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Pending Orders</p>
<h3 class="text-2xl font-black mt-1">08</h3>
</div>
<!-- Active Tables -->
<div class="bg-white dark:bg-charcoal p-6 rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="text-slate-400 material-symbols-outlined">table_restaurant</span>
<span class="text-[10px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded">+10.3%</span>
</div>
<p class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Active Tables</p>
<h3 class="text-2xl font-black mt-1">15 <span class="text-sm font-normal text-slate-400">/ 25</span></h3>
</div>
</div>
<!-- Main Widgets -->
<div class="grid grid-cols-1 xl:grid-cols-3 gap-8">
<!-- Live Reservation Calendar -->
<div class="xl:col-span-2 bg-white dark:bg-charcoal rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm flex flex-col overflow-hidden">
<div class="p-6 border-b border-slate-50 dark:border-slate-800 flex items-center justify-between">
<h3 class="text-xl font-bold">Live Reservation Calendar</h3>
<div class="flex gap-2">
<button class="p-2 rounded hover:bg-slate-50 transition-colors"><span class="material-symbols-outlined text-sm">chevron_left</span></button>
<span class="text-sm font-medium self-center">Oct 22, 2023</span>
<button class="p-2 rounded hover:bg-slate-50 transition-colors"><span class="material-symbols-outlined text-sm">chevron_right</span></button>
</div>
</div>
<div class="flex-1 p-6 overflow-x-auto">
<div class="min-w-[600px] grid grid-cols-7 gap-4 text-center">
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Mon</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Tue</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Wed</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Thu</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Fri</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Sat</div>
<div class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-4">Sun</div>
<!-- Dummy Calendar Days -->
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">16</div>
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">17</div>
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">18</div>
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">19</div>
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">20</div>
<div class="aspect-square flex flex-col items-center justify-center rounded-lg text-slate-300">21</div>
<div class="aspect-square border border-primary bg-primary/5 flex flex-col items-center justify-center rounded-lg relative">
<span class="text-sm font-bold text-accent-burgundy">22</span>
<div class="flex gap-1 mt-1">
<span class="size-1 rounded-full bg-accent-burgundy"></span>
<span class="size-1 rounded-full bg-accent-burgundy"></span>
<span class="size-1 rounded-full bg-accent-burgundy"></span>
</div>
<span class="absolute -top-1 -right-1 size-3 bg-primary rounded-full border-2 border-white"></span>
</div>
<!-- Upcoming service details -->
<div class="col-span-7 mt-6 space-y-3">
<div class="flex items-center justify-between p-4 bg-background-light dark:bg-background-dark rounded-lg">
<div class="flex items-center gap-4">
<span class="text-xs font-bold text-slate-400">12:30 PM</span>
<p class="text-sm font-semibold">Table 04 — Mr. Harrison (4 guests)</p>
</div>
<span class="text-[10px] uppercase tracking-widest px-3 py-1 bg-primary text-accent-burgundy font-black rounded-full">Confirmed</span>
</div>
<div class="flex items-center justify-between p-4 bg-background-light dark:bg-background-dark rounded-lg">
<div class="flex items-center gap-4">
<span class="text-xs font-bold text-slate-400">01:00 PM</span>
<p class="text-sm font-semibold">Table 12 — Sarah Jenkins (2 guests)</p>
</div>
<span class="text-[10px] uppercase tracking-widest px-3 py-1 bg-slate-200 text-slate-600 font-black rounded-full">Arriving</span>
</div>
<div class="flex items-center justify-between p-4 bg-background-light dark:bg-background-dark rounded-lg">
<div class="flex items-center gap-4">
<span class="text-xs font-bold text-slate-400">01:15 PM</span>
<p class="text-sm font-semibold">Table 07 — VIP Private Party (8 guests)</p>
</div>
<span class="text-[10px] uppercase tracking-widest px-3 py-1 bg-accent-burgundy text-white font-black rounded-full">Priority</span>
</div>
</div>
</div>
</div>
</div>
<!-- Recent Orders Feed -->
<div class="bg-white dark:bg-charcoal rounded-xl border border-slate-100 dark:border-slate-800 shadow-sm flex flex-col">
<div class="p-6 border-b border-slate-50 dark:border-slate-800">
<h3 class="text-xl font-bold">Recent Orders</h3>
</div>
<div class="flex-1 p-0 overflow-y-auto max-h-[500px]">
<!-- Order Item -->
<div class="p-6 border-b border-slate-50 dark:border-slate-800 last:border-0 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors cursor-pointer group">
<div class="flex justify-between items-start mb-2">
<h4 class="font-bold text-sm">Order #8429</h4>
<span class="text-[10px] font-bold text-orange-600 bg-orange-50 px-2 py-1 rounded">Preparing</span>
</div>
<p class="text-xs text-slate-500 mb-3">Table 04 • 3 Items • $142.00</p>
<div class="flex items-center gap-2">
<div class="size-6 bg-slate-100 rounded-full flex items-center justify-center">
<span class="material-symbols-outlined text-xs">restaurant</span>
</div>
<p class="text-[11px] font-medium italic">Wagyu Steak, Truffle Fries, Merlot</p>
</div>
</div>
<!-- Order Item -->
<div class="p-6 border-b border-slate-50 dark:border-slate-800 last:border-0 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors cursor-pointer">
<div class="flex justify-between items-start mb-2">
<h4 class="font-bold text-sm">Order #8428</h4>
<span class="text-[10px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded">Served</span>
</div>
<p class="text-xs text-slate-500 mb-3">Table 11 • 2 Items • $68.50</p>
<div class="flex items-center gap-2">
<div class="size-6 bg-slate-100 rounded-full flex items-center justify-center">
<span class="material-symbols-outlined text-xs">restaurant</span>
</div>
<p class="text-[11px] font-medium italic">Seabass Al Cartoccio, Pinot Grigio</p>
</div>
</div>
<!-- Order Item -->
<div class="p-6 border-b border-slate-50 dark:border-slate-800 last:border-0 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors cursor-pointer">
<div class="flex justify-between items-start mb-2">
<h4 class="font-bold text-sm">Order #8427</h4>
<span class="text-[10px] font-bold text-accent-burgundy bg-red-50 px-2 py-1 rounded">Pending</span>
</div>
<p class="text-xs text-slate-500 mb-3">Bar • 5 Items • $85.00</p>
<div class="flex items-center gap-2">
<div class="size-6 bg-slate-100 rounded-full flex items-center justify-center">
<span class="material-symbols-outlined text-xs">local_bar</span>
</div>
<p class="text-[11px] font-medium italic">Cocktail Flight (x4), Oyster Platter</p>
</div>
</div>
<!-- Order Item -->
<div class="p-6 border-b border-slate-50 dark:border-slate-800 last:border-0 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors cursor-pointer">
<div class="flex justify-between items-start mb-2">
<h4 class="font-bold text-sm">Order #8426</h4>
<span class="text-[10px] font-bold text-green-600 bg-green-50 px-2 py-1 rounded">Served</span>
</div>
<p class="text-xs text-slate-500 mb-3">Table 09 • 1 Item • $24.00</p>
<div class="flex items-center gap-2">
<div class="size-6 bg-slate-100 rounded-full flex items-center justify-center">
<span class="material-symbols-outlined text-xs">restaurant</span>
</div>
<p class="text-[11px] font-medium italic">Caesar Salad</p>
</div>
</div>
</div>
<div class="p-4 bg-slate-50 dark:bg-slate-900 text-center">
<button class="text-xs font-bold text-accent-burgundy uppercase tracking-widest hover:underline decoration-primary decoration-2 underline-offset-4">View All Active Orders</button>
</div>
</div>
</div>
<!-- Operational Status Footer/Quick Stats -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-6 border-t border-slate-200 dark:border-slate-800">
<div class="flex items-center gap-4">
<div class="size-2 rounded-full bg-green-500 animate-pulse"></div>
<div>
<p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none">Kitchen Status</p>
<p class="text-xs font-semibold mt-1">Normal Operations (12m avg)</p>
</div>
</div>
<div class="flex items-center gap-4">
<div class="size-2 rounded-full bg-primary animate-pulse"></div>
<div>
<p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none">Bar Capacity</p>
<p class="text-xs font-semibold mt-1">85% Occupied</p>
</div>
</div>
<div class="flex items-center gap-4">
<div class="size-2 rounded-full bg-slate-300"></div>
<div>
<p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest leading-none">Staffing</p>
<p class="text-xs font-semibold mt-1">12 On Duty • 2 On Break</p>
</div>
</div>
</div>
</div>
</main>
</body></html>

