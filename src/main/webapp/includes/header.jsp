<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header class="flex items-center justify-between border-b border-primary/10 px-6 py-4 lg:px-20 bg-white dark:bg-slate-900 sticky top-0 z-50">
    <div class="flex items-center gap-3 text-primary">
        <div class="size-8">
            <!-- logo -->
            <svg fill="none" viewBox="0 0 48 48">
                <path d="M4 4H17.3334V17.3334H30.6666V30.6666H44V44H4V4Z" fill="currentColor"></path>
            </svg>
        </div>
        <h2 class="text-xl font-bold text-slate-900 dark:text-slate-100">
            GourmetDine
        </h2>
    </div>

    <nav class="hidden md:flex items-center gap-8">
        <a href="home.jsp" class="hover:text-primary">Home</a>
        <a href="menu.jsp" class="hover:text-primary">Menu</a>
        <a href="booking.jsp" class="hover:text-primary">Booking</a>
        <a href="#" class="hover:text-primary">About</a>
    </nav>

    <div>
        <a href="login.jsp"
           class="bg-primary text-white px-4 py-2 rounded-lg font-bold hover:brightness-110">
            Sign In
        </a>
    </div>
</header>