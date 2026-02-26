<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header class="bg-white border-b border-slate-200">
    
    <div class="relative w-full px-10 h-20 flex items-center justify-between">

        <!-- LEFT: Logo -->
        <a href="${pageContext.request.contextPath}/"
           class="flex items-center gap-3 group">

            <div class="w-10 h-10 rounded-xl 
                        bg-primary 
                        flex items-center justify-center
                        shadow-sm group-hover:scale-105 
                        transition duration-300">

                <span class="text-white font-bold text-lg">
                    RS
                </span>
            </div>

            <div class="leading-tight">
                <p class="text-xl font-bold tracking-wide text-primary">
                    RestaurantSmart
                </p>
                <p class="text-xs text-slate-500">
                    Premium Dining Experience
                </p>
            </div>
        </a>


        <!-- CENTER: Navigation -->
        <nav class="absolute left-1/2 -translate-x-1/2 
                    flex items-center gap-10 text-sm font-medium">

            <a href="${pageContext.request.contextPath}/"
               class="text-slate-700 hover:text-primary transition">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/menu"
               class="text-slate-700 hover:text-primary transition">
                Menu
            </a>

            <a href="${pageContext.request.contextPath}/views/customer/booking/booking.jsp"
               class="text-slate-700 hover:text-primary transition">
                Booking
            </a>

            <a href="${pageContext.request.contextPath}/#about"
               class="text-slate-700 hover:text-primary transition">
                About Us
            </a>
        </nav>


        <!-- RIGHT: Sign Up -->
        <div class="flex items-center gap-4">

            <a href="${pageContext.request.contextPath}/views/customer/auth/login.jsp"
               class="text-slate-700 hover:text-primary transition font-medium">
                Login
            </a>

            <a href="${pageContext.request.contextPath}/views/customer/auth/register.jsp"
               class="bg-primary text-white px-5 py-2 rounded-xl 
                      font-bold hover:bg-orange-600 transition">
                Sign Up
            </a>

        </div>

    </div>

</header>