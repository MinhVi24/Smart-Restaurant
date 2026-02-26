<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<aside class="w-64 min-h-screen bg-slate-900 text-white p-6 flex flex-col">

    <!-- TITLE -->
    <h2 class="text-2xl font-bold mb-8 text-primary">
        <%
            String role = (String) session.getAttribute("role");
            if (role != null && role.equals("ADMIN")) {
                out.print("Admin Panel");
            } else {
                out.print("User Panel");
            }
        %>
    </h2>

    <!-- MENU -->
    <nav class="flex flex-col gap-4 flex-1">

        <%
            if (role != null && role.equals("ADMIN")) {
        %>

            <a href="${pageContext.request.contextPath}/views/admin/food/admin-dashboard.jsp"
               class="hover:text-primary transition">
                Dashboard
            </a>

            <a href="#"
               class="hover:text-primary transition">
                Manage Menu
            </a>

            <a href="#"
               class="hover:text-primary transition">
                Reservations
            </a>

            <a href="#"
               class="hover:text-primary transition">
                Orders
            </a>

        <%
            } else {
        %>

            <a href="${pageContext.request.contextPath}/views/customer/home/home.jsp"
               class="hover:text-primary transition">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/views/customer/menu/menu.jsp"
               class="hover:text-primary transition">
                Menu
            </a>

            <a href="${pageContext.request.contextPath}/views/customer/booking/booking.jsp"
               class="hover:text-primary transition">
                Booking
            </a>

            <a href="#"
               class="hover:text-primary transition">
                My Orders
            </a>

        <%
            }
        %>

        <!-- BACK TO SITE -->
        <a href="${pageContext.request.contextPath}/views/customer/home/home.jsp"
           class="mt-auto border-t border-slate-700 pt-4 hover:text-primary transition">
            Back to Site
        </a>

    </nav>

</aside>