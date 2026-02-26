<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://cdn.tailwindcss.com"></script>

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: "#ee7c2b"
                        }
                    }
                }
            }
        </script>

    </head>

    <body class="flex min-h-screen bg-gray-100">

        <jsp:include page="/includes/sidebar.jsp" />

        <div class="flex-1 flex flex-col">

            <jsp:include page="/includes/header.jsp" />

            <main class="flex-1 p-10 bg-gray-100">
                <h1 class="text-3xl font-bold text-primary mb-6">
                    Dashboard Overview
                </h1>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-white p-6 rounded-xl shadow">
                        <h3 class="text-lg font-semibold">Total Orders</h3>
                        <p class="text-2xl font-bold mt-2">120</p>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow">
                        <h3 class="text-lg font-semibold">Reservations</h3>
                        <p class="text-2xl font-bold mt-2">45</p>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow">
                        <h3 class="text-lg font-semibold">Revenue</h3>
                        <p class="text-2xl font-bold mt-2">$8,540</p>
                    </div>
                </div>

            </main>

        </div>

    </body>

</html>