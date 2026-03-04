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
            <div style="display: flex; justify-content: center; gap: 32px; margin-bottom: 48px; flex-wrap: wrap; border-bottom: 1px solid #333; padding-bottom: 16px;">
                <a href="#" class="category-tab active" data-category="all" style="color: var(--md-primary); text-decoration: none; font-weight: 700; border-bottom: 2px solid var(--md-primary); padding-bottom: 8px; transition: all 0.3s;">Tất Cả</a>
                <a href="#" class="category-tab" data-category="Khai vị" style="color: #999; text-decoration: none; padding-bottom: 8px; transition: all 0.3s;">Khai Vị</a>
                <a href="#" class="category-tab" data-category="Món chính" style="color: #999; text-decoration: none; padding-bottom: 8px; transition: all 0.3s;">Món Chính</a>
                <a href="#" class="category-tab" data-category="Món phụ" style="color: #999; text-decoration: none; padding-bottom: 8px; transition: all 0.3s;">Món Phụ</a>
                <a href="#" class="category-tab" data-category="Tráng miệng" style="color: #999; text-decoration: none; padding-bottom: 8px; transition: all 0.3s;">Tráng Miệng</a>
                <a href="#" class="category-tab" data-category="Đồ uống" style="color: #999; text-decoration: none; padding-bottom: 8px; transition: all 0.3s;">Đồ Uống</a>
            </div>

            <!-- Menu Grid -->
            <div id="featuredItem" style="margin-bottom: 48px;"></div>
            <div id="menuGrid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 24px;"></div>
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
                    <span id="cartItemCount">0</span> phần steak thượng hạng
                </div>
            </div>
            
            <div style="display: flex; align-items: center; gap: 16px;">
                <div style="text-align: right;">
                    <div style="color: var(--md-text-muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">
                        TỔNG CỘNG
                    </div>
                    <div style="font-family: var(--md-font-serif); font-size: 1.5rem; color: var(--md-primary); font-weight: 700;">
                        <span id="cartTotal">0</span>₫
                    </div>
                </div>
                
                <button onclick="viewCart()" style="padding: 16px 32px; background: rgba(212, 175, 55, 0.1); color: var(--md-primary); border: 1px solid var(--md-border-gold); border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; white-space: nowrap;">
                    XEM ĐƠN HÀNG
                </button>
                
                <button onclick="proceedToCheckout()" style="padding: 16px 32px; background: var(--md-primary); color: #000; border: none; border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; white-space: nowrap;">
                    TIẾP TỤC ĐẶT BÀN
                </button>
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
        
        // Menu data
        const menuItems = [
            // Khai vị
            { name: 'Foie Gras Poêlé', category: 'Khai vị', badgeColor: '#d4af37', detail: 'Gan ngỗng Pháp áp chảo với sốt vang đỏ và bánh mì nướng giòn.', price: '850k', optionLabel: 'Phụ Kiện Kèm Theo', options: ['Sốt Nấm', 'Sốt Vang Đỏ'], defaultOption: 1, image: 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&q=80' },
            { name: 'Carpaccio Bò Wagyu', category: 'Khai vị', badgeColor: '#d4af37', detail: 'Thịt bò Wagyu thái mỏng với dầu truffle, phô mai Parmesan và rau arugula.', price: '680k', image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80' },
            { name: 'Tôm Hùm Nướng Bơ', category: 'Khai vị', badgeColor: '#d4af37', detail: 'Tôm hùm Boston nướng với bơ tỏi thơm lừng và chanh vàng.', price: '1.200k', image: 'https://images.unsplash.com/photo-1625944525533-473f1a3d54e7?w=800&q=80' },
            { name: 'Salad Caesar', category: 'Khai vị', badgeColor: '#d4af37', detail: 'Rau xà lách romaine, phô mai Parmesan, bánh mì nướng và sốt Caesar.', price: '280k', image: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=800&q=80' },
            
            // Món chính
            { name: 'Wagyu A5 Miyazaki', category: 'Món chính', badgeColor: '#d4af37', detail: 'Marble Score 12, kết cấu mềm mại như bơ với hương thơm đặc trưng của hạt dẻ.', price: '3.800k', optionLabel: 'Trọng Lượng', options: ['200g', '300g', '500g'], defaultOption: 1, isBestseller: true, bestsellerNote: 'Bò Wagyu A5 thượng hạng từ tỉnh Miyazaki, Nhật Bản. Vân mỡ cẩm thạch hoàn hảo (BMS 11-12), tan chảy ngay trong miệng với hương vị umami đậm đà khó quên.', wineRecommend: 'Gợi ý: Cabernet Sauvignon 2015', image: 'https://images.unsplash.com/photo-1558030006-450675393462?w=800&q=80' },
            { name: 'Black Angus Ribeye', category: 'Món chính', badgeColor: '#d4af37', detail: 'Bò ăn ngũ cốc 200 ngày từ vùng Úc, hương vị đậm đà, độ ngọt thịt vượt trội.', price: '1.450k', optionLabel: 'Độ Chín', options: ['Medium Rare', 'Medium', 'Well Done'], defaultOption: 0, image: 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80' },
            { name: 'Dry-Aged Tenderloin', category: 'Món chính', badgeColor: '#d4af37', detail: 'Ủ khô 45 ngày trong hầm chuyên dụng, thịt cực mềm với hương thơm nấm và phô mai.', price: '2.100k', optionLabel: 'Phụ Kiện Kèm Theo', options: ['Sốt Nấm', 'Sốt Vang Đỏ'], defaultOption: 0, image: 'https://images.unsplash.com/photo-1603360946369-dc9bb6258143?w=800&q=80' },
            { name: 'Tomahawk Dát Vàng', category: 'Món chính', badgeColor: '#d4af37', detail: 'Sườn bò Wagyu F1 nguyên xương phủ vàng lá 24K sang trọng.', price: '4.500k', optionLabel: 'Độ Chín', options: ['Medium Rare', 'Medium', 'Well Done'], defaultOption: 0, image: 'https://images.unsplash.com/photo-1615937722923-67f6deaf2cc9?w=800&q=80' },
            { name: 'Sườn Cừu New Zealand', category: 'Món chính', badgeColor: '#d4af37', detail: 'Lamb Rack nướng với lớp vỏ thảo mộc thơm ngon đặc trưng.', price: '1.350k', image: 'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=800&q=80' },
            { name: 'Bò Kobe Nhật Bản', category: 'Món chính', badgeColor: '#d4af37', detail: 'Kobe Beef A5 chính hiệu từ Hyogo với vân mỡ cẩm thạch hoàn hảo.', price: '5.200k', optionLabel: 'Trọng Lượng', options: ['200g', '300g', '500g'], defaultOption: 1, image: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80' },
            
            // Món phụ
            { name: 'Khoai Tây Truffle', category: 'Món phụ', badgeColor: '#8b7355', detail: 'Khoai tây nghiền mịn với nấm truffle đen và bơ Pháp thơm béo.', price: '180k', image: 'https://images.unsplash.com/photo-1585238341710-4a8fa9b5e8b7?w=800&q=80' },
            { name: 'Măng Tây Nướng', category: 'Món phụ', badgeColor: '#8b7355', detail: 'Măng tây xanh nướng than hoa với phô mai Parmesan bào và dầu oliu.', price: '150k', image: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&q=80' },
            { name: 'Rau Chân Vịt Xào', category: 'Món phụ', badgeColor: '#8b7355', detail: 'Rau chân vịt baby xào kem tươi với tỏi phi giòn tan.', price: '140k', image: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=800&q=80' },
            { name: 'Nấm Portobello', category: 'Món phụ', badgeColor: '#8b7355', detail: 'Nấm Portobello nướng với bơ tỏi và thảo mộc tươi.', price: '160k', image: 'https://images.unsplash.com/photo-1516714435131-44d6b64dc6a2?w=800&q=80' },
            
            // Tráng miệng
            { name: 'Tiramisu Classic', category: 'Tráng miệng', badgeColor: '#c9a961', detail: 'Tiramisu truyền thống Ý với mascarpone, cà phê espresso và bột cacao.', price: '180k', image: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=800&q=80' },
            { name: 'Chocolate Lava', category: 'Tráng miệng', badgeColor: '#c9a961', detail: 'Bánh chocolate chảy lòng nóng hổi với kem vani Madagascar.', price: '220k', image: 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=800&q=80' },
            { name: 'Panna Cotta Berry', category: 'Tráng miệng', badgeColor: '#c9a961', detail: 'Panna cotta mềm mịn với sốt dâu tây tươi và bạc hà.', price: '190k', image: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&q=80' },
            { name: 'Crème Brûlée', category: 'Tráng miệng', badgeColor: '#c9a961', detail: 'Kem tươi vani với lớp đường caramel giòn tan đặc trưng.', price: '200k', image: 'https://images.unsplash.com/photo-1470124182917-cc6e71b22ecc?w=800&q=80' },
            
            // Đồ uống
            { name: 'Cabernet Sauvignon', category: 'Đồ uống', badgeColor: '#a0522d', detail: 'Rượu vang đỏ cao cấp từ Napa Valley với hương vị phong phú.', price: '3.500k', image: 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800&q=80' },
            { name: 'Dom Pérignon', category: 'Đồ uống', badgeColor: '#a0522d', detail: 'Champagne vintage 2012 sang trọng từ vùng Champagne, Pháp.', price: '12.000k', image: 'https://images.unsplash.com/photo-1547595628-c61a29f496f0?w=800&q=80' },
            { name: 'Macallan 18', category: 'Đồ uống', badgeColor: '#a0522d', detail: 'Single Malt Scotch 18 năm tuổi với hương vị gỗ sồi đậm đà.', price: '4.800k', image: 'https://images.unsplash.com/photo-1527281400683-1aae777175f8?w=800&q=80' },
            { name: 'Espresso Ý', category: 'Đồ uống', badgeColor: '#a0522d', detail: 'Cà phê espresso đậm đà từ hạt Arabica rang vừa.', price: '120k', image: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800&q=80' },
            { name: 'Trà Earl Grey', category: 'Đồ uống', badgeColor: '#a0522d', detail: 'Trà đen Earl Grey thơm lừng với hương bergamot tự nhiên.', price: '80k', image: 'https://images.unsplash.com/photo-1564890369478-c89ca6d9cde9?w=800&q=80' },
        ];

        // Render menu items
        function renderMenuItems(category = 'all') {
            const menuGrid = document.getElementById('menuGrid');
            const featuredItem = document.getElementById('featuredItem');
            menuGrid.innerHTML = '';
            featuredItem.innerHTML = '';
            
            // Show featured item only on "all" category
            if (category === 'all') {
                const bestseller = menuItems.find(item => item.isBestseller);
                if (bestseller) {
                    renderFeaturedItem(bestseller);
                }
            }
            
            const filteredItems = category === 'all' 
                ? menuItems.filter(item => !item.isBestseller)
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
                        addToCart(itemName, itemPrice);
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
                    optionButtons += '<button style="padding: 12px 24px; background: ' + (isDefault ? 'var(--md-primary)' : 'rgba(255, 255, 255, 0.05)') + '; color: ' + (isDefault ? '#000' : '#999') + '; border: 1px solid ' + (isDefault ? 'var(--md-primary)' : 'var(--md-border)') + '; border-radius: 8px; font-size: 0.9375rem; font-weight: 600; cursor: pointer; transition: all 0.3s;">' + opt + '</button>';
                });
                
                optionsHtml = '<div style="margin-bottom: 24px;">' +
                    '<p style="color: var(--md-primary); font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 16px;">' + item.optionLabel + '</p>' +
                    '<div style="display: flex; gap: 12px; flex-wrap: wrap;">' + optionButtons + '</div>' +
                    '</div>';
            }
            
            const featuredCard = '<div style="background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%); border-radius: 16px; overflow: hidden; border: 1px solid var(--md-border-gold); box-shadow: 0 8px 32px rgba(212, 175, 55, 0.15);">' +
                '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0; min-height: 500px;">' +
                    '<div style="position: relative; overflow: hidden;">' +
                        '<img src="' + item.image + '" alt="' + item.name + '" style="width: 100%; height: 100%; object-fit: cover;">' +
                        '<div style="position: absolute; top: 24px; left: 24px;">' +
                            '<span style="display: inline-block; padding: 8px 20px; background: var(--md-primary); border-radius: 24px; color: #000; font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;">SIGNATURE</span>' +
                        '</div>' +
                    '</div>' +
                    '<div style="padding: 48px; display: flex; flex-direction: column; justify-content: center;">' +
                        '<div style="margin-bottom: 16px;">' +
                            '<span style="color: var(--md-primary); font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;">' + item.category + ', NHẬT BẢN</span>' +
                        '</div>' +
                        '<h2 style="font-family: var(--md-font-serif); font-size: 3rem; color: #fff; line-height: 1.2; margin-bottom: 20px;">' + item.name + '</h2>' +
                        '<p style="color: #ccc; font-size: 1rem; line-height: 1.7; margin-bottom: 24px;">' + item.bestsellerNote + '</p>' +
                        '<div style="display: flex; align-items: center; gap: 12px; margin-bottom: 32px; padding: 16px; background: rgba(212, 175, 55, 0.05); border-radius: 8px; border: 1px solid var(--md-border-gold);">' +
                            '<span style="font-size: 1.5rem;">🍷</span>' +
                            '<span style="color: var(--md-text-muted); font-size: 0.9375rem;">' + item.wineRecommend + '</span>' +
                        '</div>' +
                        optionsHtml +
                        '<div style="display: flex; align-items: center; gap: 24px;">' +
                            '<div>' +
                                '<p style="color: var(--md-text-muted); font-size: 0.8125rem; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 8px;">Giá theo trọng lượng</p>' +
                                '<p style="font-family: var(--md-font-serif); font-size: 2.25rem; color: var(--md-primary); font-weight: 700;">' + item.price + ' <span style="font-size: 1.25rem;">/ 300g</span></p>' +
                            '</div>' +
                            '<button class="add-to-cart-btn" data-item="' + item.name + '" data-price="' + item.price + '" style="flex: 1; padding: 18px 32px; background: var(--md-primary); color: #000; border: none; border-radius: 8px; font-size: 0.9375rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 10px;">' +
                                '<span style="font-size: 1.5rem;">+</span> THÊM VÀO BỮA TIỆC' +
                            '</button>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
            
            featuredItem.innerHTML = featuredCard;
        }
        
        // Render regular menu item
        function renderMenuItem(item, container) {
            let optionsHtml = '';
            if (item.options) {
                let optionButtons = '';
                item.options.forEach((opt, idx) => {
                    const isDefault = idx === item.defaultOption;
                    optionButtons += '<button style="padding: 8px 16px; background: ' + (isDefault ? 'var(--md-primary)' : '#2a2a2a') + '; color: ' + (isDefault ? '#000' : '#999') + '; border: 1px solid ' + (isDefault ? 'var(--md-primary)' : '#3a3a3a') + '; border-radius: 6px; font-size: 0.875rem; font-weight: 600; cursor: pointer; transition: all 0.3s;">' + opt + '</button>';
                });
                
                optionsHtml = '<div style="margin-bottom: 20px;">' +
                    '<p style="color: var(--md-primary); font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 12px;">' + item.optionLabel + '</p>' +
                    '<div style="display: flex; gap: 8px; flex-wrap: wrap;">' + optionButtons + '</div>' +
                    '</div>';
            }
            
            const menuCard = '<div class="md-card menu-item" data-category="' + item.category + '" style="padding: 0; display: flex; flex-direction: column; overflow: hidden; background: #1a1a1a;">' +
                '<div style="position: relative; width: 100%; height: 240px; overflow: hidden;">' +
                    '<img src="' + item.image + '" alt="' + item.name + '" style="width: 100%; height: 100%; object-fit: cover;">' +
                    '<div style="position: absolute; top: 16px; right: 16px;">' +
                        '<span style="display: inline-block; padding: 6px 16px; background: ' + item.badgeColor + '; border-radius: 20px; color: #000; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;">' + item.category + '</span>' +
                    '</div>' +
                '</div>' +
                '<div style="padding: 24px; flex: 1; display: flex; flex-direction: column;">' +
                    '<div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">' +
                        '<h4 style="font-family: var(--md-font-serif); font-size: 1.5rem; color: #fff; line-height: 1.3; flex: 1;">' + item.name + '</h4>' +
                        '<span style="color: var(--md-primary); font-weight: 700; font-size: 1.375rem; font-family: var(--md-font-serif); margin-left: 16px; white-space: nowrap;">' + item.price + '</span>' +
                    '</div>' +
                    '<p style="color: #999; font-size: 0.875rem; line-height: 1.6; margin-bottom: 20px;">' + item.detail + '</p>' +
                    optionsHtml +
                    '<button class="md-btn add-to-cart-btn" data-item="' + item.name + '" data-price="' + item.price + '" style="width: 100%; padding: 14px; background: rgba(212, 175, 55, 0.1); color: var(--md-primary); border: 1px solid rgba(212, 175, 55, 0.3); border-radius: 8px; font-size: 0.875rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; cursor: pointer; transition: all 0.3s; display: flex; align-items: center; justify-content: center; gap: 8px; margin-top: auto;">' +
                        '<span style="font-size: 1.25rem;">+</span> Thêm Vào Đơn' +
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
        function addToCart(itemName, itemPrice) {
            // Parse price (remove 'k' and convert to number)
            const priceValue = parseFloat(itemPrice.replace('k', '')) * 1000;
            
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
            // Save cart to session storage before navigating
            saveCartToSession();
            // Navigate to booking page
            window.location.href = '${pageContext.request.contextPath}/booking';
        }
        
        // Close modal when clicking outside
        document.getElementById('cartModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeCartModal();
            }
        });
        
        // Load cart from session on page load
        loadCartFromSession();
    </script>
</body>
</html>
