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
            height: 100vh;
            padding: 0;
            margin: 0;
        }
        
        .menu-sidebar {
            width: 380px;
            background: rgba(23, 22, 17, 0.98);
            border-right: 1px solid var(--md-border-gold);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .menu-header {
            padding: 20px;
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
            transition: all 0.3s ease;
        }
        
        .category-tab:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: var(--md-primary);
            color: var(--md-text);
            transform: translateY(-2px);
        }
        
        .category-tab.active {
            background: var(--md-primary);
            color: #0a0a0a;
            border-color: var(--md-primary);
            transform: translateY(0);
        }
        
        .category-tab.active:hover {
            background: var(--md-primary-light);
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 40px 12px 40px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--md-border);
            border-radius: 8px;
            color: var(--md-text);
            font-size: 0.875rem;
            transition: all 0.3s;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--md-primary);
            background: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 0 3px rgba(212, 175, 53, 0.1);
        }
        
        .search-box .material-symbols-outlined {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--md-text-muted);
            font-size: 20px;
            transition: color 0.3s;
            pointer-events: none;
        }
        
        .search-box input:focus + .material-symbols-outlined {
            color: var(--md-primary);
        }
        
        .search-box #clearSearch {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.05);
            border: none;
            color: var(--md-text-muted);
            cursor: pointer;
            padding: 6px;
            border-radius: 4px;
            display: none;
            transition: all 0.3s;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .search-box #clearSearch:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--md-primary);
        }
        
        .search-box #clearSearch .material-symbols-outlined {
            font-size: 18px;
            position: static;
            transform: none;
        }
        
        .menu-list {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            padding-bottom: 140px;
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
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .category-title::before {
            content: '';
            width: 40px;
            height: 2px;
            background: linear-gradient(90deg, var(--md-primary), transparent);
        }
        
        .menu-item {
            display: flex;
            gap: 16px;
            padding: 16px;
            border-radius: var(--md-radius);
            border: 1px solid transparent;
            margin-bottom: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .menu-item:hover {
            background: rgba(255, 255, 255, 0.02);
            border-color: var(--md-border);
            transform: translateX(4px);
        }
        
        .menu-item.selected {
            background: rgba(212, 175, 53, 0.1);
            border-color: var(--md-primary);
        }
        
        .menu-item.selected:hover {
            transform: translateX(0);
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
            align-items: stretch;
            justify-content: center;
            padding: 0;
            background: #0a0a0a;
            position: relative;
            overflow: hidden;
        }
        
        .featured-dish {
            width: 100%;
            height: 100vh;
            display: flex;
            flex-direction: column;
            background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            position: relative;
            overflow-y: auto;
            overflow-x: hidden;
        }
        
        .featured-dish::-webkit-scrollbar {
            width: 6px;
        }
        
        .featured-dish::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.3);
        }
        
        .featured-dish::-webkit-scrollbar-thumb {
            background: var(--md-primary);
            border-radius: 3px;
        }
        
        .featured-dish::-webkit-scrollbar-thumb:hover {
            background: #e5c158;
        }
        
        .featured-image-container {
            flex: 0 0 auto;
            width: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .featured-image {
            width: 100%;
            height: auto;
            min-height: 100vh;
            object-fit: cover;
            display: block;
        }
        
        .featured-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.98) 0%, rgba(0,0,0,0.85) 35%, rgba(0,0,0,0.4) 65%, transparent 100%);
            padding: 32px 40px 160px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
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
            width: 100%;
            background: rgba(23, 22, 17, 0.98);
            border-top: 1px solid var(--md-border-gold);
            padding: 16px 24px;
            backdrop-filter: blur(14px);
            z-index: 50;
        }
        
        .cart-content {
            max-width: 100%;
            padding: 0;
            margin: 0;
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
                    <button class="category-tab active" data-category="all" onclick="filterByCategory('all', this)">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">restaurant_menu</span>
                        Tất cả
                    </button>
                    <button class="category-tab" data-category="appetizer" onclick="filterByCategory('appetizer', this)">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">tapas</span>
                        Khai vị
                    </button>
                    <button class="category-tab" data-category="main" onclick="filterByCategory('main', this)">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">restaurant</span>
                        Món chính
                    </button>
                    <button class="category-tab" data-category="dessert" onclick="filterByCategory('dessert', this)">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">icecream</span>
                        Tráng miệng
                    </button>
                    <button class="category-tab" data-category="beverage" onclick="filterByCategory('beverage', this)">
                        <span class="material-symbols-outlined" style="font-size: 16px; vertical-align: middle; margin-right: 4px;">local_bar</span>
                        Đồ uống
                    </button>
                </div>
                
                <!-- Search -->
                <div class="search-box">
                    <span class="material-symbols-outlined">search</span>
                    <input type="text" id="searchInput" placeholder="Tìm kiếm món ăn... (Ctrl+K)" oninput="filterMenu()">
                    <button type="button" id="clearSearch" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); background: none; border: none; color: var(--md-text-muted); cursor: pointer; display: none; padding: 4px;" onclick="clearSearch()">
                        <span class="material-symbols-outlined" style="font-size: 18px;">close</span>
                    </button>
                </div>
            </div>
            
            <!-- Menu List -->
            <div class="menu-list" id="menuList">
                <h3 class="category-title" id="categoryTitle">Tất cả món ăn</h3>
                
                <c:forEach var="item" items="${menuItems}">
                    <!-- Menu Item -->
                    <div class="menu-item" 
                         data-id="${item.menuItemId}" 
                         data-name="${item.name}" 
                         data-price="${item.price}"
                         data-category="${item.category != null ? item.category : 'Món chính'}">
                        <div class="item-image">
                            <img src="${item.imageUrl != null && !item.imageUrl.isEmpty() ? item.imageUrl : pageContext.request.contextPath += '/assets/images/pizza.jpg'}" 
                                 alt="${item.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/pizza.jpg'">
                        </div>
                        <div class="item-info">
                            <h4 class="item-name">${item.name}</h4>
                            <p class="item-description">${item.description != null && item.description.length() > 60 ? item.description.substring(0, 60) += '...' : item.description != null ? item.description : 'Món ăn cao cấp được chế biến từ nguyên liệu tươi ngon'}</p>
                            <div class="item-footer">
                                <span class="item-price">${item.price}₫</span>
                                <button class="add-btn" onclick="addItem(this, ${item.menuItemId}, '${item.name}', ${item.price})">
                                    <span class="material-symbols-outlined" style="font-size: 14px; vertical-align: middle;">add</span>
                                    Thêm món
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- Empty State -->
                <div id="emptyState" style="display: none; text-align: center; padding: 60px 20px;">
                    <span class="material-symbols-outlined" style="font-size: 64px; color: var(--md-text-muted); opacity: 0.3;">search_off</span>
                    <p style="color: var(--md-text-muted); margin-top: 16px; font-size: 1rem;">
                        Không tìm thấy món ăn phù hợp
                    </p>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-top: 8px;">
                        Thử tìm kiếm với từ khóa khác
                    </p>
                </div>
                
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
                <c:choose>
                    <c:when test="${not empty menuItems && menuItems.size() > 0}">
                        <c:set var="featuredItem" value="${menuItems[0]}" />
                        
                        <!-- Featured Image with Overlay -->
                        <div class="featured-image-container">
                            <img src="${featuredItem.imageUrl != null && !featuredItem.imageUrl.isEmpty() ? featuredItem.imageUrl : pageContext.request.contextPath += '/assets/images/pizza.jpg'}" 
                                 alt="${featuredItem.name}" 
                                 class="featured-image"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/pizza.jpg'">
                            
                            <div class="featured-overlay">
                                <span class="featured-badge">Best Seller</span>
                                <h2 class="featured-title" style="margin-top: 12px; font-size: 2.5rem;">${featuredItem.name}</h2>
                                <p class="featured-description" style="margin-top: 12px; margin-bottom: 20px; font-size: 1rem; line-height: 1.6;">
                                    ${featuredItem.description != null ? featuredItem.description : 'Món ăn đặc biệt được chế biến từ nguyên liệu cao cấp nhất'}
                                </p>
                                
                                <!-- Price and Button in Overlay -->
                                <div style="display: flex; justify-content: space-between; align-items: center; gap: 20px; flex-wrap: wrap;">
                                    <div style="flex: 0 0 auto;">
                                        <div style="color: rgba(245, 245, 240, 0.6); font-size: 0.6875rem; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 6px;">
                                            Giá món ăn
                                        </div>
                                        <div class="featured-price" style="margin: 0; font-size: 2rem;">${featuredItem.price}₫</div>
                                    </div>
                                    <button class="md-btn md-btn-primary" style="padding: 14px 28px; font-size: 0.875rem; white-space: nowrap; flex: 0 0 auto;" onclick="addItem(this, ${featuredItem.menuItemId}, '${featuredItem.name}', ${featuredItem.price})">
                                        <span class="material-symbols-outlined" style="margin-right: 8px; font-size: 18px; vertical-align: middle;">add_shopping_cart</span>
                                        THÊM MÓN
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="featured-image-container" style="display: flex; align-items: center; justify-content: center;">
                            <div style="text-align: center;">
                                <span class="featured-badge">Best Seller</span>
                                <h2 class="featured-title" style="margin-top: 16px;">
                                    Đang cập nhật<br>
                                    <span style="font-style: italic;">thực đơn</span>
                                </h2>
                                <p class="featured-description" style="margin-top: 12px;">
                                    Vui lòng chọn món từ danh sách bên trái
                                </p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
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
            <form action="${pageContext.request.contextPath}/checkout" method="get" id="checkoutForm">
                <!-- Hidden inputs will be added by JavaScript -->
                <button type="submit" class="md-btn md-btn-primary" style="padding: 16px 32px;" onclick="return prepareCheckout()">
                    Tiếp Tục Đến Hoàn Tất
                    <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 20px;">check_circle</span>
                </button>
            </form>
        </div>
    </div>
    
    <script>
        let cart = {};
        let currentCategory = 'all';
        let searchQuery = '';
        
        // Category titles
        const categoryTitles = {
            'all': 'Tất cả món ăn',
            'appetizer': 'Khai vị hảo hạng',
            'main': 'Món chính đặc sắc',
            'dessert': 'Tráng miệng tinh tế',
            'beverage': 'Đồ uống cao cấp'
        };
        
        const categoryMapping = {
            'all': 'all',
            'appetizer': 'Khai vị',
            'main': 'Món chính',
            'dessert': 'Tráng miệng',
            'beverage': 'Đồ uống'
        };
        
        function filterByCategory(category, button) {
            currentCategory = category;
            
            // Update active tab
            document.querySelectorAll('.category-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            button.classList.add('active');
            
            // Update category title
            document.getElementById('categoryTitle').textContent = categoryTitles[category] || 'Tất cả món ăn';
            
            // Apply filter
            filterMenu();
        }
        
        function clearSearch() {
            document.getElementById('searchInput').value = '';
            filterMenu();
            document.getElementById('searchInput').focus();
        }
        
        function filterMenu() {
            searchQuery = document.getElementById('searchInput').value.toLowerCase().trim();
            
            // Show/hide clear button
            const clearBtn = document.getElementById('clearSearch');
            if (searchQuery !== '') {
                clearBtn.style.display = 'block';
            } else {
                clearBtn.style.display = 'none';
            }
            
            const menuItems = document.querySelectorAll('.menu-item');
            let visibleCount = 0;
            
            menuItems.forEach(item => {
                const itemName = item.dataset.name.toLowerCase();
                const itemCategory = item.dataset.category;
                
                // Check category filter
                const categoryMatch = currentCategory === 'all' || itemCategory === categoryMapping[currentCategory];
                
                // Check search filter
                const searchMatch = searchQuery === '' || itemName.includes(searchQuery);
                
                // Show/hide item with animation
                if (categoryMatch && searchMatch) {
                    item.style.display = 'flex';
                    visibleCount++;
                    
                    // Highlight search term
                    if (searchQuery !== '') {
                        const nameElement = item.querySelector('.item-name');
                        const originalName = item.dataset.name;
                        const regex = new RegExp('(' + searchQuery + ')', 'gi');
                        nameElement.innerHTML = originalName.replace(regex, '<mark style="background: rgba(212, 175, 53, 0.3); color: var(--md-primary); padding: 2px 4px; border-radius: 3px;">$1</mark>');
                    } else {
                        const nameElement = item.querySelector('.item-name');
                        nameElement.textContent = item.dataset.name;
                    }
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Update category title with count
            const categoryTitle = document.getElementById('categoryTitle');
            const baseTitle = categoryTitles[currentCategory] || 'Tất cả món ăn';
            
            if (searchQuery !== '') {
                categoryTitle.innerHTML = baseTitle + ' <span style="color: var(--md-text-muted); font-size: 0.875rem; font-weight: normal;">(' + visibleCount + ' kết quả)</span>';
            } else {
                categoryTitle.textContent = baseTitle;
            }
            
            // Show/hide empty state
            const emptyState = document.getElementById('emptyState');
            if (visibleCount === 0) {
                emptyState.style.display = 'block';
            } else {
                emptyState.style.display = 'none';
            }
        }
        
        function addItem(button, id, name, price) {
            if (cart[id]) {
                cart[id].quantity++;
            } else {
                cart[id] = {name: name, price: price, quantity: 1};
            }
            
            // Check if this is the featured button (Best Seller)
            const isFeatured = button.classList.contains('md-btn-primary');
            
            if (isFeatured) {
                // Update featured button
                button.innerHTML = '<button onclick="decreaseFeaturedQuantity(' + id + ', \'' + name + '\', ' + price + ', this)" style="width: 40px; height: 40px; border: none; background: rgba(0, 0, 0, 0.2); color: #fff; cursor: pointer; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; font-weight: 700; border-radius: 6px;">−</button>' +
                    '<span id="qty-featured-' + id + '" style="flex: 1; text-align: center; color: #000; font-weight: 700; font-size: 1.25rem;">' + cart[id].quantity + '</span>' +
                    '<button onclick="increaseFeaturedQuantity(' + id + ')" style="width: 40px; height: 40px; border: none; background: rgba(0, 0, 0, 0.2); color: #fff; cursor: pointer; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; font-weight: 700; border-radius: 6px;">+</button>';
                
                button.style.display = 'flex';
                button.style.alignItems = 'center';
                button.style.justifyContent = 'space-between';
                button.style.gap = '12px';
            } else {
                // Update regular menu item
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
            }
            
            updateCart();
        }
        
        function increaseFeaturedQuantity(id) {
            if (cart[id]) {
                cart[id].quantity++;
                const qtyElement = document.getElementById('qty-featured-' + id);
                if (qtyElement) {
                    qtyElement.textContent = cart[id].quantity;
                }
                updateCart();
            }
        }
        
        function decreaseFeaturedQuantity(id, name, price, button) {
            if (cart[id]) {
                cart[id].quantity--;
                if (cart[id].quantity <= 0) {
                    delete cart[id];
                    
                    // Restore featured button
                    const featuredButton = button.closest('.md-btn-primary');
                    if (featuredButton) {
                        featuredButton.innerHTML = '<span class="material-symbols-outlined" style="margin-right: 8px; font-size: 18px; vertical-align: middle;">add_shopping_cart</span>THÊM MÓN';
                        featuredButton.style.display = 'flex';
                        featuredButton.style.alignItems = 'center';
                        featuredButton.style.justifyContent = 'center';
                        featuredButton.style.gap = '0';
                    }
                } else {
                    const qtyElement = document.getElementById('qty-featured-' + id);
                    if (qtyElement) {
                        qtyElement.textContent = cart[id].quantity;
                    }
                }
                updateCart();
            }
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
            
            console.log('Saving cart to session:', cartData);
            
            // Send to server
            return fetch('${pageContext.request.contextPath}/booking?action=saveCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'cartData=' + encodeURIComponent(JSON.stringify(cartData))
            })
            .then(response => response.json())
            .then(data => {
                console.log('Cart saved:', data);
                return data;
            })
            .catch(function(error) {
                console.error('Error saving cart:', error);
                throw error;
            });
        }
        
        function prepareCheckout() {
            if (Object.keys(cart).length === 0) {
                alert('Vui lòng chọn ít nhất 1 món ăn!');
                return false;
            }
            
            // Convert cart to array format for sessionStorage
            const cartArray = [];
            for (let menuItemId in cart) {
                cartArray.push({
                    name: cart[menuItemId].name,
                    price: cart[menuItemId].price,
                    priceDisplay: (cart[menuItemId].price / 1000) + 'k',
                    quantity: cart[menuItemId].quantity
                });
            }
            
            // Save to sessionStorage
            sessionStorage.setItem('restaurantCart', JSON.stringify(cartArray));
            
            // Get booking info
            const bookingInfo = sessionStorage.getItem('bookingInfo');
            if (bookingInfo) {
                const booking = JSON.parse(bookingInfo);
                alert('Đặt món thành công!\n\nBàn: ' + booking.tableId + '\nNgày: ' + booking.date + '\nGiờ: ' + booking.time + '\nSố khách: ' + booking.guestCount + '\nSố món: ' + cartArray.length);
            }
            
            // TODO: Navigate to payment page
            // window.location.href = '${pageContext.request.contextPath}/checkout';
            
            console.log('Cart prepared with', Object.keys(cart).length, 'items');
            return false; // Prevent form submission for now
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize cart
            updateCart();
            
            // Show all items initially
            filterMenu();
            
            // Add keyboard shortcut for search (Ctrl+K or Cmd+K)
            document.addEventListener('keydown', function(e) {
                if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                    e.preventDefault();
                    document.getElementById('searchInput').focus();
                }
            });
        });
    </script>
</body>
</html>
