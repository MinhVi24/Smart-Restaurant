package controller.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.BookingService;
import service.MenuService;
import dao.CustomerDAO;
import model.Customers;
import model.Reservations;
import model.Orders;
import model.Payments;
import model.OrderItems;
import model.MenuItems;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    
    private BookingService bookingService;
    private MenuService menuService;
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
        menuService = new MenuService();
        customerDAO = new CustomerDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Parse cart from individual item parameters (item_1=2, item_3=1, etc.)
        Map<Integer, Integer> cart = new java.util.HashMap<>();
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            if (paramName.startsWith("item_")) {
                try {
                    Integer menuItemId = Integer.parseInt(paramName.substring(5));
                    Integer quantity = Integer.parseInt(request.getParameter(paramName));
                    cart.put(menuItemId, quantity);
                    System.out.println("Parsed cart item: " + menuItemId + " = " + quantity);
                } catch (Exception e) {
                    System.out.println("Error parsing item: " + paramName);
                    e.printStackTrace();
                }
            }
        }
        
        // Save cart to session if we got items
        if (!cart.isEmpty()) {
            session.setAttribute("cart", cart);
            System.out.println("=== CART LOADED FROM PARAMETERS ===");
            System.out.println("Total items: " + cart.size());
        } else {
            System.out.println("=== NO CART ITEMS IN PARAMETERS ===");
        }
        
        // Check if user is logged in - REQUIRED for checkout
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            // Not logged in - redirect to login with return URL
            String returnUrl = request.getContextPath() + "/checkout";
            response.sendRedirect(request.getContextPath() + "/login?returnUrl=" + returnUrl);
            return;
        }
        
        // Check if user has selected table and menu
        Integer tableId = (Integer) session.getAttribute("selectedTableId");
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> sessionCart = (Map<Integer, Integer>) session.getAttribute("cart");
        
        // Use cart from parameters if available, otherwise use session cart
        if (cart.isEmpty() && sessionCart != null) {
            cart = sessionCart;
        }
        
        if (tableId == null) {
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
            System.out.println("ERROR: Cart is empty! Redirecting to menu...");
            System.out.println("Session ID: " + session.getId());
            System.out.println("Customer ID: " + customerId);
            System.out.println("Table ID: " + tableId);
            response.sendRedirect(request.getContextPath() + "/booking?action=menu&error=cart_empty");
            return;
        }
        
        // DEBUG: Log cart contents
        System.out.println("=== CHECKOUT DEBUG ===");
        System.out.println("Cart size: " + cart.size());
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            System.out.println("Item ID: " + entry.getKey() + ", Quantity: " + entry.getValue());
        }
        
        // Load menu items for display
        List<MenuItems> cartItems = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;
        
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            MenuItems menuItem = menuService.getMenuItem(entry.getKey());
            if (menuItem != null) {
                cartItems.add(menuItem);
                BigDecimal itemTotal = menuItem.getPrice().multiply(new BigDecimal(entry.getValue()));
                totalAmount = totalAmount.add(itemTotal);
                System.out.println("Added: " + menuItem.getName() + " x " + entry.getValue() + " = " + itemTotal);
            } else {
                System.out.println("WARNING: Menu item not found for ID: " + entry.getKey());
            }
        }
        
        System.out.println("Total items: " + cartItems.size());
        System.out.println("Total amount: " + totalAmount);
        System.out.println("======================");
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("cart", cart);
        
        // Get booking details for display
        String bookingDate = (String) session.getAttribute("bookingDate");
        String bookingTime = (String) session.getAttribute("bookingTime");
        Integer guestCount = (Integer) session.getAttribute("guestCount");
        
        request.setAttribute("bookingDate", bookingDate);
        request.setAttribute("bookingTime", bookingTime);
        request.setAttribute("guestCount", guestCount);
        request.setAttribute("tableId", tableId);
        
        request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Parse cart data from form if present
        String cartDataJson = request.getParameter("cartData");
        if (cartDataJson != null && !cartDataJson.isEmpty()) {
            // Parse JSON cart data and store in session
            // Format: {"1":{"name":"..","price":123,"quantity":2},"2":{...}}
            try {
                Map<Integer, Integer> cart = parseCartData(cartDataJson);
                session.setAttribute("cart", cart);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/booking?action=menu&error=invalid_cart");
                return;
            }
        }
        
        // Get booking information from session
        Integer tableId = (Integer) session.getAttribute("selectedTableId");
        String bookingDate = (String) session.getAttribute("bookingDate");
        String bookingTime = (String) session.getAttribute("bookingTime");
        Integer guestCount = (Integer) session.getAttribute("guestCount");
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        
        // Get payment information from form
        String depositPercentageStr = request.getParameter("depositPercentage");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (tableId == null || cart == null || depositPercentageStr == null) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=missing_data");
            return;
        }
        
        try {
            // Get or create customer
            Customers customer = getOrCreateCustomer(session, request);
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/login?redirect=checkout");
                return;
            }
            
            // Parse reservation time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date reservationTime = sdf.parse(bookingDate + " " + bookingTime);
            
            // Create reservation
            Reservations reservation = bookingService.createReservation(
                customer, tableId, reservationTime, guestCount
            );
            
            if (reservation == null) {
                // Reload cart items for display
                List<MenuItems> cartItems = new ArrayList<>();
                BigDecimal totalAmount = BigDecimal.ZERO;
                
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    MenuItems menuItem = menuService.getMenuItem(entry.getKey());
                    if (menuItem != null) {
                        cartItems.add(menuItem);
                        BigDecimal itemTotal = menuItem.getPrice().multiply(new BigDecimal(entry.getValue()));
                        totalAmount = totalAmount.add(itemTotal);
                    }
                }
                
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("totalAmount", totalAmount);
                request.setAttribute("cart", cart);
                request.setAttribute("error", "Failed to create reservation. Table may not be available.");
                request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
                return;
            }
            
            // Prepare order items
            List<OrderItems> orderItems = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                MenuItems menuItem = menuService.getMenuItem(entry.getKey());
                if (menuItem != null) {
                    OrderItems orderItem = new OrderItems();
                    orderItem.setMenuItemId(menuItem);
                    orderItem.setQuantity(entry.getValue());
                    orderItem.setPrice(menuItem.getPrice());
                    orderItems.add(orderItem);
                    
                    totalAmount = totalAmount.add(
                        menuItem.getPrice().multiply(new BigDecimal(entry.getValue()))
                    );
                }
            }
            
            // Parse deposit percentage
            Integer depositPercentage = Integer.parseInt(depositPercentageStr);
            
            // Fix payment method: Convert QR_CODE to QR for database compatibility
            String finalPaymentMethod = paymentMethod;
            if ("QR_CODE".equals(paymentMethod)) {
                finalPaymentMethod = "QR";
            }
            if (finalPaymentMethod == null || finalPaymentMethod.isEmpty()) {
                finalPaymentMethod = "QR"; // Default to QR
            }
            
            // Complete booking with payment
            BookingService.BookingResult result = bookingService.completeBooking(
                reservation.getReservationId(),
                orderItems,
                totalAmount,
                depositPercentage,
                finalPaymentMethod
            );
            
            if (result.isSuccess()) {
                // Store booking result in session for payment page
                session.setAttribute("bookingResult", result);
                session.setAttribute("reservation", result.getReservation());
                session.setAttribute("order", result.getOrder());
                session.setAttribute("payment", result.getPayment());
                
                // DON'T clear booking session data yet - keep for payment page
                
                // Redirect to payment QR page
                response.sendRedirect(request.getContextPath() + "/payment/qr");
            } else {
                // Reload cart items for display
                List<MenuItems> cartItems = new ArrayList<>();
                BigDecimal errorTotalAmount = BigDecimal.ZERO;
                
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    MenuItems menuItem = menuService.getMenuItem(entry.getKey());
                    if (menuItem != null) {
                        cartItems.add(menuItem);
                        BigDecimal itemTotal = menuItem.getPrice().multiply(new BigDecimal(entry.getValue()));
                        errorTotalAmount = errorTotalAmount.add(itemTotal);
                    }
                }
                
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("totalAmount", errorTotalAmount);
                request.setAttribute("cart", cart);
                request.setAttribute("error", result.getMessage());
                request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // Reload cart items for display on error
            @SuppressWarnings("unchecked")
            Map<Integer, Integer> errorCart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (errorCart != null) {
                List<MenuItems> cartItems = new ArrayList<>();
                BigDecimal exceptionTotalAmount = BigDecimal.ZERO;
                
                for (Map.Entry<Integer, Integer> entry : errorCart.entrySet()) {
                    MenuItems menuItem = menuService.getMenuItem(entry.getKey());
                    if (menuItem != null) {
                        cartItems.add(menuItem);
                        BigDecimal itemTotal = menuItem.getPrice().multiply(new BigDecimal(entry.getValue()));
                        exceptionTotalAmount = exceptionTotalAmount.add(itemTotal);
                    }
                }
                
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("totalAmount", exceptionTotalAmount);
                request.setAttribute("cart", errorCart);
            }
            
            request.setAttribute("error", "An error occurred while processing your booking: " + e.getMessage());
            request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
        }
    }
    
    /**
     * Calculate total amount from cart
     */
    private BigDecimal calculateTotalAmount(Map<Integer, Integer> cart) {
        BigDecimal total = BigDecimal.ZERO;
        
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            MenuItems menuItem = menuService.getMenuItem(entry.getKey());
            if (menuItem != null) {
                total = total.add(menuItem.getPrice().multiply(new BigDecimal(entry.getValue())));
            }
        }
        
        return total;
    }
    
    /**
     * Get or create customer from session
     */
    private Customers getOrCreateCustomer(HttpSession session, HttpServletRequest request) {
        // Try to get customer from session
        Integer customerId = (Integer) session.getAttribute("customerId");
        
        if (customerId != null) {
            return customerDAO.findById(customerId);
        }
        
        // For guest checkout, you might want to create a temporary customer
        // or require login. This is a simplified version.
        return null;
    }
    
    /**
     * Parse cart data from JSON string
     * Format: {"1":{"name":"Dish","price":100000,"quantity":2},"2":{...}}
     * Returns: Map<menuItemId, quantity>
     */
    private Map<Integer, Integer> parseCartData(String jsonData) {
        Map<Integer, Integer> cart = new java.util.HashMap<>();
        
        // Simple JSON parsing (you can use Gson or Jackson for better parsing)
        jsonData = jsonData.trim();
        if (jsonData.startsWith("{") && jsonData.endsWith("}")) {
            jsonData = jsonData.substring(1, jsonData.length() - 1);
            
            // Split by items
            String[] items = jsonData.split("},");
            for (String item : items) {
                try {
                    // Extract menu item ID (key)
                    int colonIndex = item.indexOf(":");
                    if (colonIndex > 0) {
                        String idStr = item.substring(0, colonIndex).replace("\"", "").trim();
                        Integer menuItemId = Integer.parseInt(idStr);
                        
                        // Extract quantity
                        int quantityIndex = item.indexOf("\"quantity\":");
                        if (quantityIndex > 0) {
                            String quantityPart = item.substring(quantityIndex + 11);
                            quantityPart = quantityPart.split("[,}]")[0].trim();
                            Integer quantity = Integer.parseInt(quantityPart);
                            
                            cart.put(menuItemId, quantity);
                        }
                    }
                } catch (Exception e) {
                    // Skip invalid items
                    e.printStackTrace();
                }
            }
        }
        
        return cart;
    }
}
