<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Thực Đơn - Maison D'Or</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols_Outlined" rel="stylesheet">
    
    <style>
        body {
            background: #0a0a0a;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        
        .menu-layout {
            display: flex;
            height: calc(100vh - 72px);
        }
        
        .menu-sidebar {
            width: 400px;
            background: rgba(23, 22, 17, 0.98);
            border-right: 1px solid var(--md-border-gold);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .menu-header {
            padding: 24px;
            border-bottom: 1px solid var(--md-border);
        }
        
        .step-indicator {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        
        .step {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.875rem;
        }
        
        .step-number {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.75rem;
        }
        
        .step.completed .step-number {
            background: rgba(40, 209, 124, 0.2);
            color: #28d17c;
        }
        
        .step.active .step-number {
            background: var(--md-primary);
            color: #0a0a0a;
        }
        
        .step.inactive .step-number {
            background: rgba(255, 255, 255, 0.05);
            color: var(--md-text-muted);
        }
        
        .category-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 16px;
            overflow-x: auto;
        }
        
        .category-tab {
            padding: 10px 20px;
            border-radius: 999px;
            border: 1px solid var(--md-border);
            background: rgba(255, 255, 255, 0.02);
            color: var(--md-text-muted);
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }
        
        .category-tab.active {
            background: var(--md-primary);
            color: #0a0a0a;
            border-color: var(--md-primary);
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 12px 12px 40px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--md-border);
            border-radius: var(--md-radius);
            color: var(--md-text);
            font-size: 0.875rem;
        }
        
        .search-box .material-symbols-outlined {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--md-text-muted);
            font-size: 20px;
        }
        
        .menu-list {
            flex: 1;
            overflow-y: auto;
            padding: 24px;
        }
        
        .menu-list::-webkit-scrollbar {
            width: 4px;
        }
        
        .menu-list::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.02);
        }
        
        .menu-list::-webkit-scrollbar-thumb {
            background: var(--md-border);
            border-radius: 4px;
        }
        
        .category-title {
            font-family: var(--md-font-serif);
            font-size: 1.25rem;
            font-style: italic;
            color: var(--md-primary);
            margin-bottom: 20px;
        }
        
        .menu-item {
            display: flex;
            gap: 16px;
            padding: 16px;
            border-radius: var(--md-radius);
            border: 1px solid transparent;
            margin-bottom: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .menu-item:hover {
            background: rgba(255, 255, 255, 0.02);
            border-color: var(--md-border);
        }
        
        .menu-item.selected {
            background: rgba(212, 175, 53, 0.1);
            border-color: var(--md-primary);
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            border-radius: var(--md-radius);
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .item-info {
            flex: 1;
        }
        
        .item-name {
            font-family: var(--md-font-serif);
            font-size: 1.125rem;
            color: var(--md-text);
            margin-bottom: 4px;
        }
        
        .item-description {
            font-size: 0.75rem;
            color: var(--md-text-muted);
            margin-bottom: 8px;
        }
        
        .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .item-price {
            color: var(--md-primary);
            font-weight: 700;
            font-size: 1rem;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--md-radius);
            padding: 4px;
        }
        
        .quantity-btn {
            width: 24px;
            height: 24px;
            border: none;
            background: transparent;
            color: var(--md-text);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quantity-value {
            min-width: 24px;
            text-align: center;
            color: var(--md-text);
            font-weight: 700;
            font-size: 0.875rem;
        }
        
        .add-btn {
            padding: 6px 12px;
            background: rgba(212, 175, 53, 0.1);
            border: 1px solid var(--md-primary);
            border-radius: var(--md-radius);
            color: var(--md-primary);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .add-btn:hover {
            background: var(--md-primary);
            color: #0a0a0a;
        }
        
        .menu-main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.8)), 
                        url('${pageContext.request.contextPath}/assets/images/pizza.jpg') center/cover;
        }
        
        .featured-dish {
            max-width: 600px;
            padding: 40px;
            text-align: center;
        }
        
        .featured-badge {
            display: inline-block;
            padding: 8px 16px;
            background: rgba(212, 175, 53, 0.2);
            border: 1px solid var(--md-primary);
            border-radius: 999px;
            color: var(--md-primary);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 24px;
        }
        
        .featured-title {
            font-family: var(--md-font-serif);
            font-size: 3rem;
            color: var(--md-text);
            margin-bottom: 16px;
            line-height: 1.2;
        }
        
        .featured-description {
            color: rgba(245, 245, 240, 0.8);
            font-size: 1.125rem;
            line-height: 1.6;
            margin-bottom: 32px;
        }
        
        .featured-price {
            font-family: var(--md-font-serif);
            font-size: 2.5rem;
            color: var(--md-primary);
            font-weight: 700;
            margin-bottom: 24px;
        }
        
        .cart-footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(23, 22, 17, 0.98);
            border-top: 1px solid var(--md-border-gold);
            padding: 20px;
            backdrop-filter: blur(14px);
            z-index: 50;
        }
        
        .cart-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .cart-summary {
            display: flex;
            align-items: center;
            gap: 32px;
        }
        
        .cart-item-count {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .cart-icon {
            position: relative;
        }
        
        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            width: 20px;
            height: 20px;
            background: var(--md-primary);
            color: #0a0a0a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
        }
        
        .cart-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--md-text-muted);
        }
        
        .cart-value {
            font-weight: 700;
            color: var(--md-text);
        }
        
        .cart-total {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        
        .total-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--md-text-muted);
            margin-bottom: 4px;
        }
        
        .total-value {
            font-family: var(--md-font-serif);
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--md-primary);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/views/includes/header.jsp"/>
    
    <!-- Main Layout -->
    <div class="menu-layout">
        <!-- Sidebar -->
        <div class="menu-sidebar">
            <div class="menu-header">
                <!-- Steps -->
                <div class="step-indicator">
                    <div class="step completed">
                        <div class="step-number">
                            <span class="material-symbols-outlined" style="font-size: 14px;">check</span>
                        </div>
                        <span>1. Chọn Bàn</span>
                    </div>
                    <span style="color: var(--md-text-muted);">/</span>
                    <div class="step active">
                        <div class="step-number">2</div>
                        <span>2. Chọn Thực Đơn</span>
                    </div>
                    <span style="color: var(--md-text-muted);">/</span>
                    <div class="step inactive">
                        <div class="step-number">3</div>
                        <span>3. Xác Nhận</span>
                    </div>
                </div>
                
                <!-- Categories -->
                <div class="category-tabs">
                    <button class="category-tab active" data-category="all">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">tapas</span>
                        Khai vị
                    </button>
                    <button class="category-tab" data-category="main">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">restaurant</span>
                        Món chính
                    </button>
                    <button class="category-tab" data-category="dessert">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">icecream</span>
                        Tráng miệng
                    </button>
                </div>
                
                <!-- Search -->
                <div class="search-box">
                    <span class="material-symbols-outlined">search</span>
                    <input type="text" placeholder="Tìm kiếm món ăn...">
                </div>
            </div>
            
            <!-- Menu List -->
            <div class="menu-list">
                <h3 class="category-title">Khai vị hảo hạng</h3>
                
                <c:forEach var="item" items="${menuItems}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <!-- Menu Item -->
                        <div class="menu-item" data-id="${item.menuItemId}" data-name="${item.name}" data-price="${item.price}">
                            <div class="item-image">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="${item.name}">
                            </div>
                            <div class="item-info">
                                <h4 class="item-name">${item.name}</h4>
                                <p class="item-description">Món ăn cao cấp được chế biến từ nguyên liệu tươi ngon</p>
                                <div class="item-footer">
                                    <span class="item-price">${item.price}₫</span>
                                    <button class="add-btn" onclick="addItem(this, ${item.menuItemId}, '${item.name}', ${item.price})">
                                        <span class="material-symbols-outlined" style="font-size: 14px; vertical-align: middle;">add</span>
                                        Thêm món
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <c:if test="${empty menuItems}">
                    <p style="color: var(--md-text-muted); text-align: center; padding: 40px;">
                        Chưa có món ăn nào. Vui lòng chạy script SQL để thêm dữ liệu.
                    </p>
                </c:if>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="menu-main">
            <div class="featured-dish">
                <span class="featured-badge">Signature Dish</span>
                <h2 class="featured-title">
                    Gan Ngỗng Pháp<br>
                    <span style="font-style: italic;">Áp Chảo</span>
                </h2>
                <p class="featured-description">
                    Gan ngỗng béo ngậy nhập khẩu trực tiếp từ Pháp, áp chảo vàng giòn bên ngoài, mềm tan bên trong. Phục vụ cùng sốt quả mọng chua ngọt cân bằng vị giác.
                </p>
                <div class="featured-price">1.250.000₫</div>
                <button class="md-btn md-btn-primary" style="padding: 16px 32px;" onclick="addItem(this, 2, 'Gan Ngỗng Pháp', 1250000)">
                    Thêm vào thực đơn
                    <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 20px;">arrow_forward</span>
                </button>
            </div>
        </div>
    </div>
    
    <!-- Cart Footer -->
    <div class="cart-footer">
        <div class="cart-content">
            <div class="cart-summary">
                <div class="cart-item-count">
                    <div class="cart-icon">
                        <span class="material-symbols-outlined" style="font-size: 32px; color: var(--md-text-muted);">soup_kitchen</span>
                        <div class="cart-badge" id="cartCount">0</div>
                    </div>
                    <div>
                        <div class="cart-label">Đã chọn</div>
                        <div class="cart-value" id="cartItems">0 món ăn</div>
                    </div>
                </div>
                <div class="cart-total">
                    <div class="total-label">Tạm tính</div>
                    <div class="total-value" id="cartTotal">0₫</div>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/checkout" method="get">
                <button type="submit" class="md-btn md-btn-primary" style="padding: 16px 32px;" onclick="return validateCart()">
                    Tiếp Tục Đến Hoàn Tất
                    <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 20px;">check_circle</span>
                </button>
            </form>
        </div>
    </div>
    
    <script>
        let cart = {};
        
        function addItem(button, id, name, price) {
            if (cart[id]) {
                cart[id].quantity++;
            } else {
                cart[id] = {name: name, price: price, quantity: 1};
            }
            
            // Update UI
            const menuItem = button.closest('.menu-item');
            if (menuItem) {
                menuItem.classList.add('selected');
                
                const footer = menuItem.querySelector('.item-footer');
                if (footer) {
                    footer.innerHTML = '<span class="item-price">' + price.toLocaleString() + '₫</span>' +
                        '<div class="quantity-control">' +
                        '<button class="quantity-btn" onclick="decreaseQuantity(' + id + ')">-</button>' +
                        '<span class="quantity-value" id="qty-' + id + '">' + cart[id].quantity + '</span>' +
                        '<button class="quantity-btn" onclick="increaseQuantity(' + id + ')">+</button>' +
                        '</div>';
                }
            }
            
            updateCart();
        }
        
        function increaseQuantity(id) {
            if (cart[id]) {
                cart[id].quantity++;
                const qtyElement = document.getElementById('qty-' + id);
                if (qtyElement) {
                    qtyElement.textContent = cart[id].quantity;
                }
                updateCart();
            }
        }
        
        function decreaseQuantity(id) {
            if (cart[id]) {
                cart[id].quantity--;
                if (cart[id].quantity <= 0) {
                    delete cart[id];
                    const menuItem = document.querySelector('[data-id="' + id + '"]');
                    if (menuItem) {
                        menuItem.classList.remove('selected');
                        const footer = menuItem.querySelector('.item-footer');
                        const price = menuItem.dataset.price;
                        const name = menuItem.dataset.name;
                        if (footer) {
                            footer.innerHTML = '<span class="item-price">' + parseInt(price).toLocaleString() + '₫</span>' +
                                '<button class="add-btn" onclick="addItem(this, ' + id + ', \'' + name + '\', ' + price + ')">' +
                                '<span class="material-symbols-outlined" style="font-size: 14px; vertical-align: middle;">add</span>' +
                                'Thêm món</button>';
                        }
                    }
                } else {
                    const qtyElement = document.getElementById('qty-' + id);
                    if (qtyElement) {
                        qtyElement.textContent = cart[id].quantity;
                    }
                }
                updateCart();
            }
        }
        
        function updateCart() {
            let total = 0;
            let count = 0;
            
            for (let id in cart) {
                total += cart[id].price * cart[id].quantity;
                count += cart[id].quantity;
            }
            
            const cartCountElement = document.getElementById('cartCount');
            const cartItemsElement = document.getElementById('cartItems');
            const cartTotalElement = document.getElementById('cartTotal');
            
            if (cartCountElement) cartCountElement.textContent = count;
            if (cartItemsElement) cartItemsElement.textContent = count + ' món ăn';
            if (cartTotalElement) cartTotalElement.textContent = total.toLocaleString() + '₫';
            
            // Save cart to session via AJAX
            saveCartToSession();
        }
        
        function saveCartToSession() {
            // Convert cart to simple format: {menuItemId: quantity}
            const cartData = {};
            for (let id in cart) {
                cartData[id] = cart[id].quantity;
            }
            
            // Send to server
            fetch('${pageContext.request.contextPath}/booking?action=saveCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'cartData=' + encodeURIComponent(JSON.stringify(cartData))
            }).catch(function(error) {
                console.error('Error saving cart:', error);
            });
        }
        
        function validateCart() {
            if (Object.keys(cart).length === 0) {
                alert('Vui lòng chọn ít nhất 1 món ăn!');
                return false;
            }
            return true;
        }
        
        // Category tabs
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.category-tab').forEach(function(tab) {
                tab.addEventListener('click', function() {
                    document.querySelectorAll('.category-tab').forEach(function(t) {
                        t.classList.remove('active');
                    });
                    this.classList.add('active');
                });
            });
            
            // Initialize cart
            updateCart();
        });
    </script>
</body>
</html>
