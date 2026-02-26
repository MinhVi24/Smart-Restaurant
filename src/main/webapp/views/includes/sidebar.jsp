<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<aside class="w-64 min-h-screen bg-slate-900 text-white p-6">
    <h2 class="text-2xl font-bold mb-8 text-primary">
        <%= session.getAttribute("role") != null && session.getAttribute("role").equals("ADMIN")
            ? "Admin Panel"
            : "User Panel" %>
    </h2>

    <nav class="flex flex-col gap-4">

        <% 
            String role = (String) session.getAttribute("role");
            if (role != null && role.equals("ADMIN")) { 
        %>

            <a href="admin-dashboard.jsp" class="hover:text-primary">Dashboard</a>
            <a href="#" class="hover:text-primary">Manage Menu</a>
            <a href="#" class="hover:text-primary">Reservations</a>
            <a href="#" class="hover:text-primary">Orders</a>

        <% } else { %>

            <a href="home.jsp" class="hover:text-primary">Home</a>
            <a href="menu.jsp" class="hover:text-primary">Menu</a>
            <a href="booking.jsp" class="hover:text-primary">Booking</a>
            <a href="#" class="hover:text-primary">My Orders</a>

        <% } %>

        <a href="home.jsp" class="hover:text-primary mt-6 border-t border-slate-700 pt-4">
            Back to Site
        </a>

    </nav>
</aside>