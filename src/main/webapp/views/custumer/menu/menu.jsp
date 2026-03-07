<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực Đơn - Maison D'Or</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .md-card {
            background: #1a1a1a;
            border-radius: 12px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .md-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(212, 175, 55, 0.15);
        }
        
        .category-tab:hover {
            color: var(--md-primary) !important;
        }
        
        button:hover {
            opacity: 0.9;
        }
        
        /* Cart Bar Styles */
        .cart-bar {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(23, 22, 17, 0.98);
            border-top: 1px solid var(--md-border-gold);
            padding: 20px;
            backdrop-filter: blur(14px);
            z-index: 100;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }
        
        .cart-bar.active {
            transform: translateY(0);
        }
        
        .cart-bar-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/views/includes/header.jsp"/>
    
    <!-- Main Content -->
    <main style="background: #0a0a0a; min-height: 100vh; padding: 40px 20px;">
        <div class="md-container" style="max-width: 1400px; margin: 0 auto;">
            <!-- Page Header -->
            <div style="text-align: center; margin-bottom: 48px;">
                <span style="color: var(--md-primary); font-size: 0.875rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;">Menu Bữa Tối</span>
                <h1 style="font-family: var(--md-font-serif); font-size: 3rem; color: #fff; margin-top: 12px; margin-bottom: 16px;">Nghệ Thuật Bít Tết Thượng Hạng</h1>
                <p style="color: #999; font-size: 1.125rem; max-width: 700px; margin: 0 auto;">
                    Trải nghiệm ẩm thực đẳng cấp với những phần cắt thượng hạng từ khắp nơi trên thế giới.
                </p>
            </div>

            <!-- Filter Tabs -->
            <div style="display: flex; justify-content: center; gap: 24px; margin-bottom: 48px; flex-wrap: wrap; border-bottom: 1px solid #333; padding-bottom: 16px;">
                <a href="#" class="category-tab active" data-category="all" style="color: var(--md-primary); text-decoration: none; font-weight: 600; font-size: 0.9375rem; border-bottom: 2px solid var(--md-primary); padding-bottom: 8px; transition: all 0.3s;">Tất Cả</a>
                <a href="#" class="category-tab" data-category="Khai vị" style="color: #999; text-decoration: none; font-size: 0.9375rem; padding-bottom: 8px; transition: all 0.3s;">Khai Vị</a>
                <a href="#" class="category-tab" data-category="Món chính" style="color: #999; text-decoration: none; font-size: 0.9375rem; padding-bottom: 8px; transition: all 0.3s;">Món Chính</a>
                <a href="#" class="category-tab" data-category="Món phụ" style="color: #999; text-decoration: none; font-size: 0.9375rem; padding-bottom: 8px; transition: all 0.3s;">Món Phụ</a>
                <a href="#" class="category-tab" data-category="Tráng miệng" style="color: #999; text-decoration: none; font-size: 0.9375rem; padding-bottom: 8px; transition: all 0.3s;">Tráng Miệng</a>
                <a href="#" class="category-tab" data-category="Đồ uống" style="color: #999; text-decoration: none; font-size: 0.9375rem; padding-bottom: 8px; transition: all 0.3s;">Đồ Uống</a>
            </div>

            <!-- Menu Grid -->
            <div id="featuredItem" style="margin-bottom: 48px;"></div>
            
            <!-- Divider Section -->
            <div style="text-align: center; margin: 64px 0 48px 0;">
                <div style="display: inline-block; padding: 0 32px; position: relative;">
                    <div style="position: absolute; left: 0; right: 0; top: 50%; height: 1px; background: linear-gradient(90deg, transparent, var(--md-border-gold), transparent);"></div>
                    <span style="position: relative; background: #0a0a0a; padding: 0 24px; color: var(--md-primary); font-size: 0.875rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;">Thực Đơn Đầy Đủ</span>
                </div>
                <p style="color: #999; font-size: 1rem; margin-top: 16px; font-style: italic;">Khám phá bộ sưu tập món ăn tinh tế của chúng tôi</p>
            </div>
            
            <div id="menuGrid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px;"></div>
        </div>
    </main>

    <!-- Cart Bar -->
    <div class="cart-bar" id="cartBar">
        <div class="cart-bar-content">
            <div style="display: flex; align-items: center; gap: 16px;">
                <div style="color: var(--md-text-muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.1em;">
                    MÓN ĐÃ CHỌN
                </div>
                <div style="font-family: var(--md-font-serif); font-size: 1.125rem; color: #fff;">
                    <span id="cartItemCount">0</span> món
                </div>
            </div>
            
            <div style="display: flex; align-items: center; gap: 24px; margin-left: auto;">
                <div style="text-align: right;">
                    <div style="color: var(--md-text-muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">
                        TỔNG CỘNG
                    </div>
                    <div style="font-family: var(--md-font-serif); font-size: 1.5rem; color: var(--md-primary); font-weight: 700;">
                        <span id="cartTotal">0</span>₫
                    </div>
                </div>
                
                <div style="display: flex; gap: 12px;">
                    <button onclick="viewCart()" style="padding: 14px 24px; background: rgba(212, 175, 55, 0.1); color: var(--md-primary); border: 1px solid var(--md-border-gold); border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; white-space: nowrap;">
                        XEM ĐƠN HÀNG
                    </button>
                    
                    <button onclick="proceedToCheckout()" style="padding: 14px 28px; background: var(--md-primary); color: #000; border: none; border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; white-space: nowrap;">
                        TIẾP TỤC ĐẶT BÀN
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Cart Modal -->
    <div id="cartModal" style="display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0, 0, 0, 0.85); z-index: 200; backdrop-filter: blur(8px);">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 90%; max-width: 900px; max-height: 85vh; background: #1a1a1a; border-radius: 16px; border: 1px solid var(--md-border-gold); overflow: hidden; display: flex; flex-direction: column;">
            
            <!-- Modal Header -->
            <div style="padding: 24px 32px; border-bottom: 1px solid var(--md-border); display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h2 style="font-family: var(--md-font-serif); font-size: 1.75rem; color: #fff; margin-bottom: 4px;">Đơn Hàng Của Bạn</h2>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem;">Xem lại món ăn đã chọn</p>
                </div>
                <button onclick="closeCartModal()" style="width: 40px; height: 40px; border-radius: 50%; background: rgba(255, 255, 255, 0.05); border: 1px solid var(--md-border); color: #fff; cursor: pointer; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; transition: all 0.3s;">
                    ×
                </button>
            </div>
            
            <!-- Modal Body -->
            <div id="cartModalBody" style="flex: 1; overflow-y: auto; padding: 24px 32px;">
                <!-- Cart items will be inserted here -->
            </div>
            
            <!-- Modal Footer -->
            <div style="padding: 24px 32px; border-top: 1px solid var(--md-border); background: rgba(0, 0, 0, 0.3);">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <span style="font-size: 0.875rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--md-text-muted);">Tổng Cộng</span>
                    <span style="font-family: var(--md-font-serif); font-size: 2rem; color: var(--md-primary); font-weight: 700;">
                        <span id="cartModalTotal">0</span>₫
                    </span>
                </div>
                <div style="display: flex; gap: 16px;">
                    <button onclick="closeCartModal()" style="flex: 1; padding: 16px; background: rgba(255, 255, 255, 0.05); color: #fff; border: 1px solid var(--md-border); border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s;">
                        Tiếp Tục Chọn Món
                    </button>
                    <button onclick="proceedToCheckout()" style="flex: 1; padding: 16px; background: var(--md-primary); color: #000; border: none; border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s;">
                        Tiếp Tục Đặt Bàn
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="background: var(--md-surface-dark); border-top: 1px solid var(--md-border); padding: 32px 20px; text-align: center;">
        <div class="md-container">
            <p style="color: var(--md-text-muted); font-size: 0.875rem;">© 2024 Maison D'Or Luxury Steakhouse. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Cart state
        let cart = [];
        
        // Menu data from database
        const menuItems = [
            <c:forEach var="item" items="${menuItems}" varStatus="status">
            {
                menuItemId: ${item.menuItemId},
                name: '${item.name}',
                category: '<c:out value="${item.category != null ? item.category : 'Món chính'}" />',
                badgeColor: '<c:choose><c:when test="${item.category == 'Khai vị'}">#d4af37</c:when><c:when test="${item.category == 'Món phụ'}">#8b7355</c:when><c:when test="${item.category == 'Tráng miệng'}">#c9a961</c:when><c:when test="${item.category == 'Đồ uống'}">#a0522d</c:when><c:otherwise>#d4af37</c:otherwise></c:choose>',
                detail: '<c:out value="${item.description != null ? item.description : 'Món ăn cao cấp được chế biến từ nguyên liệu tươi ngon'}" />',
                price: '${item.price.intValue() / 1000}k',
                priceValue: ${item.price.intValue()},
                image: '<c:choose><c:when test="${item.imageUrl != null && !item.imageUrl.isEmpty()}">${item.imageUrl}</c:when><c:otherwise>${pageContext.request.contextPath}/assets/images/pizza.jpg</c:otherwise></c:choose>',
                <c:if test="${item.options != null && !item.options.isEmpty()}">
                optionLabel: 'Loại Sốt',
                options: ['Sốt Nấm', 'Sốt Vang Đỏ', 'Sốt Tiêu Đen'],
                defaultOption: 0,
                </c:if>
                isBestseller: false
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        // Render menu items
        function renderMenuItems(category = 'all') {
            const menuGrid = document.getElementById('menuGrid');
            const featuredItem = document.getElementById('featuredItem');
            menuGrid.innerHTML = '';
            featuredItem.innerHTML = '';
            
            // Show featured item only on "all" category
            if (category === 'all' && menuItems.length > 0) {
                const bestseller = menuItems[0]; // First item from database
                renderFeaturedItem(bestseller);
            }
            
            const filteredItems = category === 'all' 
                ? menuItems.slice(1) // Skip first item (featured)
                : menuItems.filter(item => item.category === category);
            
            filteredItems.forEach(item => {
                renderMenuItem(item, menuGrid);
            });
            
            // Add event listeners to add-to-cart buttons
            setTimeout(() => {
                document.querySelectorAll('.add-to-cart-btn').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const itemName = this.dataset.item;
                        const itemPrice = this.dataset.price;
                        const priceValue = parseInt(this.dataset.priceValue);
                        addToCartWithQuantity(this, itemName, itemPrice, priceValue);
                    });
                });
            }, 100);
        }
        
        // Render featured bestseller item
        function renderFeaturedItem(item) {
            const featuredItem = document.getElementById('featuredItem');
            
            let optionsHtml = '';
            if (item.options) {
                let optionButtons = '';
                item.options.forEach((opt, idx) => {
                    const isDefault = idx === item.defaultOption;
                    optionButtons += '<button onclick="selectOption(this, \'' + item.name + '\', \'' + opt + '\')" class="sauce-option" data-selected="' + isDefault + '" style="padding: 12px 24px; background: ' + (isDefault ? 'var(--md-primary)' : 'rgba(255, 255, 255, 0.05)') + '; color: ' + (isDefault ? '#000' : '#999') + '; border: 1px solid ' + (isDefault ? 'var(--md-primary)' : 'var(--md-border)') + '; border-radius: 8px; font-size: 0.9375rem; font-weight: 600; cursor: pointer; transition: all 0.3s;">' + opt + '</button>';
                });
                
                optionsHtml = '<div style="margin-bottom: 24px;">' +
                    '<p style="color: var(--md-primary); font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px;">' + item.optionLabel + '</p>' +
                    '<div style="display: flex; gap: 12px; flex-wrap: wrap;">' + optionButtons + '</div>' +
                    '</div>';
            }
            
            const featuredCard = '<div style="background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%); border-radius: 16px; overflow: hidden; border: 1px solid var(--md-border-gold); box-shadow: 0 8px 32px rgba(212, 175, 55, 0.15); margin-bottom: 48px;">' +
                '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0; min-height: 500px;">' +
                    '<div style="position: relative; overflow: hidden;">' +
                        '<img src="' + item.image + '" alt="' + item.name + '" style="width: 100%; height: 100%; object-fit: cover;">' +
                        '<div style="position: absolute; top: 24px; left: 24px;">' +
                            '<span style="display: inline-block; padding: 8px 20px; background: var(--md-primary); border-radius: 24px; color: #000; font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;">SIGNATURE</span>' +
                        '</div>' +
                    '</div>' +
                    '<div style="padding: 48px; display: flex; flex-direction: column; justify-content: center;">' +
                        '<div style="margin-bottom: 16px;">' +
                            '<span style="color: var(--md-primary); font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;">' + item.category + '</span>' +
                        '</div>' +
                        '<h2 style="font-family: var(--md-font-serif); font-size: 3rem; color: #fff; line-height: 1.2; margin-bottom: 20px;">' + item.name + '</h2>' +
                        '<p style="color: #ccc; font-size: 1rem; line-height: 1.7; margin-bottom: 24px;">' + item.detail + '</p>' +
                        optionsHtml +
                        '<div style="display: flex; align-items: center; gap: 24px;">' +
                            '<div>' +
                                '<p style="color: var(--md-text-muted); font-size: 0.8125rem; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 8px;">Giá món ăn</p>' +
                                '<p style="font-family: var(--md-font-serif); font-size: 2.25rem; color: var(--md-primary); font-weight: 700;">' + item.price + '</p>' +
                            '</div>' +
                            '<button class="add-to-cart-btn featured-btn" data-item="' + item.name + '" data-price="' + item.price + '" data-price-value="' + item.priceValue + '" style="flex: 1; padding: 18px 32px; background: var(--md-primary); color: #000; border: none; border-radius: 8px; font-size: 0.9375rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 10px;">' +
                                '<span style="font-size: 1.5rem;">+</span> THÊM MÓN' +
                            '</button>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
            
            featuredItem.innerHTML = featuredCard;
        }
        
        // Select sauce option
        function selectOption(button, itemName, sauceName) {
            const parent = button.parentElement;
            parent.querySelectorAll('.sauce-option').forEach(btn => {
                btn.dataset.selected = 'false';
                btn.style.background = 'rgba(255, 255, 255, 0.05)';
                btn.style.color = '#999';
                btn.style.borderColor = 'var(--md-border)';
            });
            
            button.dataset.selected = 'true';
            button.style.background = 'var(--md-primary)';
            button.style.color = '#000';
            button.style.borderColor = 'var(--md-primary)';
            
            if (!window.sauceSelections) {
                window.sauceSelections = {};
            }
            window.sauceSelections[itemName] = sauceName;
        }
        
        // Render regular menu item
        function renderMenuItem(item, container) {
            let optionsHtml = '';
            if (item.options) {
                let optionButtons = '';
                item.options.forEach((opt, idx) => {
                    const isDefault = idx === item.defaultOption;
                    optionButtons += '<button onclick="selectOption(this, \'' + item.name + '\', \'' + opt + '\')" class="sauce-option" style="padding: 6px 12px; background: ' + (isDefault ? 'var(--md-primary)' : '#2a2a2a') + '; color: ' + (isDefault ? '#000' : '#999') + '; border: 1px solid ' + (isDefault ? 'var(--md-primary)' : '#3a3a3a') + '; border-radius: 6px; font-size: 0.8125rem; font-weight: 600; cursor: pointer; transition: all 0.3s;">' + opt + '</button>';
                });
                
                optionsHtml = '<div style="margin-bottom: 16px;">' +
                    '<p style="color: var(--md-primary); font-size: 0.6875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 10px;">' + item.optionLabel + '</p>' +
                    '<div style="display: flex; gap: 6px; flex-wrap: wrap;">' + optionButtons + '</div>' +
                    '</div>';
            }
            
            const menuCard = '<div class="md-card menu-item" data-category="' + item.category + '" style="padding: 0; display: flex; flex-direction: column; overflow: hidden; background: #1a1a1a;">' +
                '<div style="position: relative; width: 100%; height: 200px; overflow: hidden;">' +
                    '<img src="' + item.image + '" alt="' + item.name + '" style="width: 100%; height: 100%; object-fit: cover;">' +
                    '<div style="position: absolute; top: 12px; right: 12px;">' +
                        '<span style="display: inline-block; padding: 4px 12px; background: ' + item.badgeColor + '; border-radius: 16px; color: #000; font-size: 0.6875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;">' + item.category + '</span>' +
                    '</div>' +
                '</div>' +
                '<div style="padding: 18px; flex: 1; display: flex; flex-direction: column;">' +
                    '<div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 10px;">' +
                        '<h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: #fff; line-height: 1.3; flex: 1;">' + item.name + '</h4>' +
                        '<span style="color: var(--md-primary); font-weight: 700; font-size: 1.125rem; font-family: var(--md-font-serif); margin-left: 12px; white-space: nowrap;">' + item.price + '</span>' +
                    '</div>' +
                    '<p style="color: #999; font-size: 0.8125rem; line-height: 1.5; margin-bottom: 16px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">' + item.detail + '</p>' +
                    optionsHtml +
                    '<button class="md-btn add-to-cart-btn" data-item="' + item.name + '" data-price="' + item.price + '" data-price-value="' + item.priceValue + '" style="width: 100%; padding: 12px; background: rgba(212, 175, 55, 0.1); color: var(--md-primary); border: 1px solid rgba(212, 175, 55, 0.3); border-radius: 8px; font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 6px; margin-top: auto;">' +
                        '<span style="font-size: 1.125rem;">+</span> THÊM MÓN' +
                    '</button>' +
                '</div>' +
            '</div>';
            
            container.innerHTML += menuCard;
        }

        // Category filtering
        document.querySelectorAll('.category-tab').forEach(tab => {
            tab.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Update active tab
                document.querySelectorAll('.category-tab').forEach(t => {
                    t.style.color = 'var(--md-text-muted)';
                    t.style.fontWeight = '400';
                    t.style.borderBottom = 'none';
                    t.classList.remove('active');
                });
                
                this.style.color = 'var(--md-primary)';
                this.style.fontWeight = '700';
                this.style.borderBottom = '2px solid var(--md-primary)';
                this.classList.add('active');
                
                // Filter menu items
                const category = this.dataset.category;
                renderMenuItems(category);
            });
        });

        // Initial render
        renderMenuItems('all');
        
        // Cart functions
        function addToCartWithQuantity(button, itemName, itemPrice, priceValue) {
            // Find the menu item
            const menuItem = menuItems.find(item => item.name === itemName);
            const actualPriceValue = priceValue || (menuItem ? menuItem.priceValue : (parseFloat(itemPrice.replace('k', '')) * 1000));
            
            // Check if item already in cart
            const existingItem = cart.find(item => item.name === itemName);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({
                    name: itemName,
                    price: actualPriceValue,
                    priceDisplay: itemPrice,
                    quantity: 1
                });
            }
            
            // Update button to show quantity controls
            const currentQuantity = cart.find(item => item.name === itemName).quantity;
            const itemId = itemName.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9-]/g, '');
            const isFeatured = button.classList.contains('featured-btn');
            
            // Different styles for featured vs regular buttons
            if (isFeatured) {
                button.innerHTML = '<button onclick="decreaseItemQuantity(\'' + itemName.replace(/'/g, "\\'") + '\', \'' + itemPrice + '\', ' + actualPriceValue + ', this)" style="width: 48px; height: 48px; border: none; background: rgba(0, 0, 0, 0.2); color: #fff; cursor: pointer; font-size: 1.75rem; display: flex; align-items: center; justify-content: center; font-weight: 700; border-radius: 8px;">−</button>' +
                    '<span id="qty-' + itemId + '" style="flex: 1; text-align: center; color: #000; font-weight: 700; font-size: 1.5rem;">' + currentQuantity + '</span>' +
                    '<button onclick="increaseItemQuantity(\'' + itemName.replace(/'/g, "\\'") + '\', \'' + itemPrice + '\', ' + actualPriceValue + ')" style="width: 48px; height: 48px; border: none; background: rgba(0, 0, 0, 0.2); color: #fff; cursor: pointer; font-size: 1.75rem; display: flex; align-items: center; justify-content: center; font-weight: 700; border-radius: 8px;">+</button>';
                
                button.style.background = 'var(--md-primary)';
                button.style.gap = '12px';
            } else {
                button.innerHTML = '<button onclick="decreaseItemQuantity(\'' + itemName.replace(/'/g, "\\'") + '\', \'' + itemPrice + '\', ' + actualPriceValue + ', this)" style="width: 36px; height: 36px; border: none; background: transparent; color: var(--md-primary); cursor: pointer; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; font-weight: 700;">−</button>' +
                    '<span id="qty-' + itemId + '" style="flex: 1; text-align: center; color: var(--md-text); font-weight: 700; font-size: 1.125rem;">' + currentQuantity + '</span>' +
                    '<button onclick="increaseItemQuantity(\'' + itemName.replace(/'/g, "\\'") + '\', \'' + itemPrice + '\', ' + actualPriceValue + ')" style="width: 36px; height: 36px; border: none; background: transparent; color: var(--md-primary); cursor: pointer; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; font-weight: 700;">+</button>';
                
                button.style.background = 'rgba(212, 175, 55, 0.15)';
                button.style.borderColor = 'var(--md-primary)';
                button.style.gap = '0';
            }
            
            button.style.display = 'flex';
            button.style.alignItems = 'center';
            button.style.justifyContent = 'space-between';
            button.classList.add('quantity-active');
            
            updateCartDisplay();
            showCartBar();
            saveCartToSession();
        }
        
        function increaseItemQuantity(itemName, itemPrice, priceValue) {
            const existingItem = cart.find(item => item.name === itemName);
            if (existingItem) {
                existingItem.quantity += 1;
                const itemId = itemName.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9-]/g, '');
                const qtyElement = document.getElementById('qty-' + itemId);
                if (qtyElement) {
                    qtyElement.textContent = existingItem.quantity;
                }
                updateCartDisplay();
                saveCartToSession();
            }
        }
        
        function decreaseItemQuantity(itemName, itemPrice, priceValue, button) {
            const existingItem = cart.find(item => item.name === itemName);
            if (existingItem) {
                existingItem.quantity -= 1;
                
                if (existingItem.quantity <= 0) {
                    // Remove from cart
                    cart = cart.filter(item => item.name !== itemName);
                    
                    // Find the button and restore it
                    const addButton = button.closest('.add-to-cart-btn');
                    if (addButton) {
                        const isFeatured = addButton.classList.contains('featured-btn');
                        
                        if (isFeatured) {
                            addButton.innerHTML = '<span style="font-size: 1.5rem;">+</span> THÊM MÓN';
                            addButton.style.background = 'var(--md-primary)';
                            addButton.style.color = '#000';
                            addButton.style.gap = '10px';
                        } else {
                            addButton.innerHTML = '<span style="font-size: 1.125rem;">+</span> THÊM MÓN';
                            addButton.style.background = 'rgba(212, 175, 55, 0.1)';
                            addButton.style.borderColor = 'rgba(212, 175, 55, 0.3)';
                            addButton.style.gap = '6px';
                        }
                        
                        addButton.style.display = 'flex';
                        addButton.style.alignItems = 'center';
                        addButton.style.justifyContent = 'center';
                        addButton.classList.remove('quantity-active');
                    }
                } else {
                    const itemId = itemName.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9-]/g, '');
                    const qtyElement = document.getElementById('qty-' + itemId);
                    if (qtyElement) {
                        qtyElement.textContent = existingItem.quantity;
                    }
                }
                
                updateCartDisplay();
                saveCartToSession();
                
                if (cart.length === 0) {
                    showCartBar();
                }
            }
        }
        
        function addToCart(itemName, itemPrice) {
            // Find the menu item to get the actual price value
            const menuItem = menuItems.find(item => item.name === itemName);
            const priceValue = menuItem ? menuItem.priceValue : (parseFloat(itemPrice.replace('k', '')) * 1000);
            
            // Check if item already in cart
            const existingItem = cart.find(item => item.name === itemName);
            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                cart.push({
                    name: itemName,
                    price: priceValue,
                    priceDisplay: itemPrice,
                    quantity: 1
                });
            }
            
            updateCartDisplay();
            showCartBar();
            saveCartToSession();
        }
        
        function updateCartDisplay() {
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            
            document.getElementById('cartItemCount').textContent = totalItems;
            document.getElementById('cartTotal').textContent = formatPrice(totalPrice);
        }
        
        function saveCartToSession() {
            sessionStorage.setItem('restaurantCart', JSON.stringify(cart));
        }
        
        function loadCartFromSession() {
            const savedCart = sessionStorage.getItem('restaurantCart');
            if (savedCart) {
                cart = JSON.parse(savedCart);
                updateCartDisplay();
                showCartBar();
            }
        }
        
        function formatPrice(price) {
            return new Intl.NumberFormat('vi-VN').format(price);
        }
        
        function showCartBar() {
            const cartBar = document.getElementById('cartBar');
            if (cart.length > 0) {
                cartBar.classList.add('active');
            } else {
                cartBar.classList.remove('active');
            }
        }
        
        function viewCart() {
            renderCartModal();
            document.getElementById('cartModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }
        
        function closeCartModal() {
            document.getElementById('cartModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }
        
        function renderCartModal() {
            const modalBody = document.getElementById('cartModalBody');
            const modalTotal = document.getElementById('cartModalTotal');
            
            if (cart.length === 0) {
                modalBody.innerHTML = '<div style="text-align: center; padding: 60px 20px; color: var(--md-text-muted);">' +
                    '<p style="font-size: 1.125rem; margin-bottom: 8px;">Giỏ hàng trống</p>' +
                    '<p style="font-size: 0.875rem;">Hãy chọn món ăn yêu thích của bạn</p>' +
                    '</div>';
                modalTotal.textContent = '0';
                return;
            }
            
            let cartHtml = '';
            cart.forEach((item, index) => {
                const itemTotal = item.price * item.quantity;
                cartHtml += '<div style="display: flex; gap: 20px; padding: 20px; background: rgba(255, 255, 255, 0.02); border-radius: 12px; margin-bottom: 16px; border: 1px solid var(--md-border);">' +
                    '<img src="' + (menuItems.find(m => m.name === item.name)?.image || 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80') + '" alt="' + item.name + '" style="width: 120px; height: 120px; object-fit: cover; border-radius: 8px;">' +
                    '<div style="flex: 1;">' +
                        '<h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: #fff; margin-bottom: 8px;">' + item.name + '</h4>' +
                        '<p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 12px;">Giá: ' + item.priceDisplay + '</p>' +
                        '<div style="display: flex; align-items: center; gap: 12px;">' +
                            '<button onclick="decreaseQuantity(' + index + ')" style="width: 32px; height: 32px; border-radius: 6px; background: rgba(255, 255, 255, 0.05); border: 1px solid var(--md-border); color: #fff; cursor: pointer; font-size: 1.125rem; display: flex; align-items: center; justify-content: center;">−</button>' +
                            '<span style="min-width: 40px; text-align: center; font-weight: 600; font-size: 1.125rem;">' + item.quantity + '</span>' +
                            '<button onclick="increaseQuantity(' + index + ')" style="width: 32px; height: 32px; border-radius: 6px; background: rgba(212, 175, 55, 0.1); border: 1px solid var(--md-border-gold); color: var(--md-primary); cursor: pointer; font-size: 1.125rem; display: flex; align-items: center; justify-content: center;">+</button>' +
                        '</div>' +
                    '</div>' +
                    '<div style="text-align: right; display: flex; flex-direction: column; justify-content: space-between;">' +
                        '<button onclick="removeFromCart(' + index + ')" style="width: 32px; height: 32px; border-radius: 6px; background: rgba(255, 0, 0, 0.1); border: 1px solid rgba(255, 0, 0, 0.3); color: #ff4444; cursor: pointer; font-size: 1.125rem; display: flex; align-items: center; justify-content: center; margin-left: auto;">×</button>' +
                        '<div>' +
                            '<p style="color: var(--md-text-muted); font-size: 0.75rem; margin-bottom: 4px;">Thành tiền</p>' +
                            '<p style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-primary); font-weight: 700;">' + formatPrice(itemTotal) + '₫</p>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            });
            
            modalBody.innerHTML = cartHtml;
            
            const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
            modalTotal.textContent = formatPrice(totalPrice);
        }
        
        function increaseQuantity(index) {
            cart[index].quantity += 1;
            updateCartDisplay();
            renderCartModal();
            saveCartToSession();
        }
        
        function decreaseQuantity(index) {
            if (cart[index].quantity > 1) {
                cart[index].quantity -= 1;
            } else {
                cart.splice(index, 1);
            }
            updateCartDisplay();
            renderCartModal();
            showCartBar();
            saveCartToSession();
            
            if (cart.length === 0) {
                closeCartModal();
            }
        }
        
        function removeFromCart(index) {
            cart.splice(index, 1);
            updateCartDisplay();
            renderCartModal();
            showCartBar();
            saveCartToSession();
            
            if (cart.length === 0) {
                closeCartModal();
            }
        }
        
        function proceedToCheckout() {
            if (cart.length === 0) {
                alert('Vui lòng chọn món ăn trước khi đặt bàn');
                return;
            }
            
            // Save cart to session storage
            saveCartToSession();
            
            // Check if booking info exists (came from booking page)
            const bookingInfo = sessionStorage.getItem('bookingInfo');
            
            if (bookingInfo) {
                // LUỒNG 2: Đã chọn bàn → Đi thẳng thanh toán
                const booking = JSON.parse(bookingInfo);
                alert('Đặt món thành công!\n\nBàn: ' + booking.tableId + '\nNgày: ' + booking.date + '\nGiờ: ' + booking.time + '\nSố khách: ' + booking.guestCount + '\nSố món: ' + cart.length);
                // TODO: Navigate to payment page
                // window.location.href = '${pageContext.request.contextPath}/checkout';
            } else {
                // LUỒNG 1: Chưa chọn bàn → Đi đến booking
                window.location.href = '${pageContext.request.contextPath}/booking';
            }
        }
        
        // Close modal when clicking outside
        document.getElementById('cartModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeCartModal();
            }
        });
        
        // Load cart from session on page load
        loadCartFromSession();
        
        // Check if came from booking page
        const bookingInfo = sessionStorage.getItem('bookingInfo');
        if (bookingInfo) {
            // Update button text in cart bar and modal
            const checkoutButtons = document.querySelectorAll('button[onclick="proceedToCheckout()"]');
            checkoutButtons.forEach(btn => {
                btn.innerHTML = btn.innerHTML.replace('TIẾP TỤC ĐẶT BÀN', 'XÁC NHẬN ĐẶT BÀN');
            });
        }
    </script>
</body>
</html>
