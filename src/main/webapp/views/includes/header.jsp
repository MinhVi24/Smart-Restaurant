<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <header class="bg-white border-b border-slate-200">

            <div class="relative w-full px-10 h-20 flex items-center justify-between">

                <!-- LEFT: Logo -->
                <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 group">

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

                    <a href="${pageContext.request.contextPath}/" class="text-slate-700 hover:text-primary transition">
                        Home
                    </a>

                    <a href="${pageContext.request.contextPath}/menu"
                        class="text-slate-700 hover:text-primary transition">
                        Menu
                    </a>

                    <a href="${pageContext.request.contextPath}/views/custumer/booking/booking.jsp"
                        class="text-slate-700 hover:text-primary transition">
                        Booking
                    </a>

                    <a href="${pageContext.request.contextPath}/#about"
                        class="text-slate-700 hover:text-primary transition">
                        About Us
                    </a>
                </nav>


                <!-- RIGHT: Login/Logout -->
                <div class="flex items-center gap-4">

                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <!-- Đã đăng nhập: Hiển thị tên và nút Logout -->
                            <span class="text-slate-700 font-medium">
                                Xin chào, ${sessionScope.loggedInUser.username}
                            </span>
                            <a href="${pageContext.request.contextPath}/logout" class="bg-red-500 text-white px-5 py-2 rounded-xl 
                              font-bold hover:bg-red-600 transition">
                                Logout
                            </a>
                        </c:when>
                        <c:otherwise>
                            <!-- Chưa đăng nhập: Hiển thị Login và Sign Up -->
                            <a href="${pageContext.request.contextPath}/login"
                                class="text-slate-700 hover:text-primary transition font-medium">
                                Login
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="bg-primary text-white px-5 py-2 rounded-xl 
                              font-bold hover:bg-orange-600 transition">
                                Sign Up
                            </a>
                        </c:otherwise>
                    </c:choose>

                </div>

            </div>

        </header>