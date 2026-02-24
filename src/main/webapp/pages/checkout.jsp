<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen flex flex-col">

<jsp:include page="/includes/header.jsp"/>

<main class="flex-1 max-w-6xl mx-auto w-full px-6 py-10">

    <h1 class="text-3xl font-bold mb-8">Checkout</h1>

    <div class="grid md:grid-cols-2 gap-10">

        <div class="bg-white rounded-xl shadow p-6">
            <h2 class="text-xl font-bold mb-4">Order Summary</h2>

            <c:forEach var="item" items="${cart.items}">
                <div class="flex justify-between py-3 border-b">
                    <div>
                        <p class="font-semibold">${item.name}</p>
                        <p class="text-sm text-gray-500">
                            ${item.quantity} × $${item.price}
                        </p>
                    </div>
                    <p class="font-bold">
                        $${item.total}
                    </p>
                </div>
            </c:forEach>

            <div class="flex justify-between mt-6 text-lg font-bold">
                <span>Total</span>
                <span>$${cart.totalAmount}</span>
            </div>
        </div>


        <div class="bg-white rounded-xl shadow p-6">
            <h2 class="text-xl font-bold mb-4">Customer Information</h2>

            <form action="${pageContext.request.contextPath}/checkout" method="post"
                  class="flex flex-col gap-4">

                <input type="text" name="fullName"
                       placeholder="Full Name"
                       class="border p-3 rounded-lg" required/>

                <input type="text" name="phone"
                       placeholder="Phone Number"
                       class="border p-3 rounded-lg" required/>

                <input type="text" name="address"
                       placeholder="Shipping Address"
                       class="border p-3 rounded-lg" required/>

                <button type="submit"
                        class="bg-orange-500 text-white py-3 rounded-lg font-bold hover:bg-orange-600">
                    Place Order
                </button>

            </form>
        </div>

    </div>

</main>

<jsp:include page="/includes/footer.jsp"/>

</body>
</html>