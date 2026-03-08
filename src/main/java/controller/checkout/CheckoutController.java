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
    private dao.TableDAO tableDAO;
    private dao.ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
        menuService = new MenuService();
        customerDAO = new CustomerDAO();
        tableDAO = new dao.TableDAO();
        reservationDAO = new dao.ReservationDAO();
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
        
        System.out.println("========================================");
        System.out.println("=== CHECKOUT DOPOST CALLED ===");
        System.out.println("========================================");
        
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
        
        // Debug logging
        System.out.println("=== CHECKOUT DEBUG ===");
        System.out.println("Table ID: " + tableId);
        System.out.println("Booking Date: " + bookingDate);
        System.out.println("Booking Time: " + bookingTime);
        System.out.println("Guest Count: " + guestCount);
        System.out.println("Cart size: " + (cart != null ? cart.size() : "null"));
        System.out.println("Deposit %: " + depositPercentageStr);
        System.out.println("Payment Method: " + paymentMethod);
        
        if (tableId == null) {
            request.setAttribute("error", "Vui lòng chọn bàn trước khi thanh toán");
            request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
            return;
        }
        
        if (bookingDate == null || bookingTime == null) {
            request.setAttribute("error", "Thiếu thông tin ngày giờ đặt bàn");
            request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống");
            request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
            return;
        }
        
        if (depositPercentageStr == null) {
            depositPercentageStr = "100"; // Default 100%
        }
        
        try {
            // Get or create customer
            Customers customer = getOrCreateCustomer(session, request);
            
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/login?redirect=checkout");
                return;
            }
            
            // Load table object
            model.Tables table = tableDAO.findById(tableId);
            if (table == null) {
                System.err.println("ERROR: Table not found: " + tableId);
                
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
                request.setAttribute("error", "Bàn không tồn tại. Vui lòng chọn lại bàn.");
                request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
                return;
            }
            
            // Parse reservation time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date reservationTime = sdf.parse(bookingDate + " " + bookingTime);
            
            // Create reservation DIRECTLY using ReservationDAO
            System.out.println("Creating reservation DIRECTLY...");
            System.out.println("Customer ID: " + customer.getCustomerId());
            System.out.println("Customer Name: " + customer.getFullName());
            System.out.println("Table ID: " + table.getTableId());
            System.out.println("Table Status: " + table.getStatus());
            System.out.println("Reservation Time: " + reservationTime);
            System.out.println("Guest Count: " + guestCount);
            
            // Create reservation directly without going through BookingService
            Reservations reservation = reservationDAO.createReservation(
                customer, table, reservationTime, guestCount
            );
            
            if (reservation == null) {
                System.err.println("ERROR: Failed to create reservation DIRECTLY!");
                System.err.println("Check console log for detailed error from ReservationDAO");
                
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
                request.setAttribute("error", "Không thể tạo đặt bàn. Vui lòng thử lại hoặc liên hệ quản trị viên.");
                request.getRequestDispatcher("/views/custumer/checkout/checkout.jsp").forward(request, response);
                return;
            }
            
            System.out.println("SUCCESS: Reservation created with ID: " + reservation.getReservationId());
            
            // Update table status to RESERVED
            tableDAO.updateStatus(tableId, "RESERVED");
            
            // Prepare order items
            List<OrderItems> orderItems = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            System.out.println("=== PREPARING ORDER ITEMS ===");
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                MenuItems menuItem = menuService.getMenuItem(entry.getKey());
                if (menuItem != null) {
                    System.out.println("Processing item: " + menuItem.getName() + " (ID: " + menuItem.getMenuItemId() + ")");
                    System.out.println("  Price: " + menuItem.getPrice());
                    System.out.println("  Quantity: " + entry.getValue());
                    
                    OrderItems orderItem = new OrderItems();
                    orderItem.setMenuItemId(menuItem);
                    orderItem.setQuantity(entry.getValue());
                    orderItem.setPrice(menuItem.getPrice());
                    orderItems.add(orderItem);
                    
                    BigDecimal itemTotal = menuItem.getPrice().multiply(new BigDecimal(entry.getValue()));
                    totalAmount = totalAmount.add(itemTotal);
                    
                    System.out.println("  Item total: " + itemTotal);
                } else {
                    System.err.println("ERROR: Menu item not found for ID: " + entry.getKey());
                }
            }
            
            System.out.println("Total order items: " + orderItems.size());
            System.out.println("Total amount: " + totalAmount);
            System.out.println("=============================");
            
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
                // IMPORTANT: Clear old payment data from session first
                session.removeAttribute("payment");
                session.removeAttribute("order");
                session.removeAttribute("reservation");
                session.removeAttribute("bookingResult");
                
                // Store NEW booking result in session for payment page
                session.setAttribute("bookingResult", result);
                session.setAttribute("reservation", result.getReservation());
                session.setAttribute("order", result.getOrder());
                session.setAttribute("payment", result.getPayment());
                
                System.out.println("=== STORED IN SESSION ===");
                System.out.println("Reservation ID: " + result.getReservation().getReservationId());
                System.out.println("Order ID: " + result.getOrder().getOrderId());
                System.out.println("Payment ID: " + result.getPayment().getPaymentId());
                System.out.println("Payment Status: " + result.getPayment().getPaymentStatus());
                System.out.println("=========================");
                
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
        
        System.out.println("=== GET CUSTOMER ===");
        System.out.println("Customer ID from session: " + customerId);
        
        if (customerId != null) {
            Customers customer = customerDAO.findById(customerId);
            System.out.println("Customer found: " + (customer != null ? customer.getFullName() : "NULL"));
            return customer;
        }
        
        // FALLBACK: If no customer in session, try to use customer ID 1 for testing
        System.out.println("WARNING: No customer in session, using customer ID 1 for testing");
        Customers customer = customerDAO.findById(1);
        if (customer != null) {
            System.out.println("Fallback customer: " + customer.getFullName());
            // Set to session for next time
            session.setAttribute("customerId", customer.getCustomerId());
        }
        return customer;
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
