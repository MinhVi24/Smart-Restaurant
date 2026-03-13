<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VESPER - Nhà Hàng Ẩm Thực Cao Cấp</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500&family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        .hero-section {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.7)), 
                        url('${pageContext.request.contextPath}/assets/images/pizza.jpg') center/cover;
            text-align: center;
        }
        
        .hero-content {
            max-width: 900px;
            padding: 0 20px;
        }
        
        .hero-subtitle {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: var(--md-primary);
            margin-bottom: 32px;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: 5.5rem;
            font-weight: 500;
            line-height: 1.15;
            color: var(--md-text);
            margin-bottom: 24px;
            letter-spacing: -0.02em;
        }
        
        .hero-title-italic {
            font-style: italic;
            font-weight: 400;
            color: var(--md-primary);
            display: block;
            margin-top: 8px;
        }
        
        .hero-description {
            font-size: 1.125rem;
            color: rgba(245, 245, 240, 0.75);
            margin-bottom: 48px;
            line-height: 1.8;
            font-family: 'Cormorant Garamond', serif;
            font-weight: 300;
            letter-spacing: 0.02em;
        }
        
        .scroll-indicator {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateX(-50%) translateY(0);
            }
            40% {
                transform: translateX(-50%) translateY(-10px);
            }
            60% {
                transform: translateX(-50%) translateY(-5px);
            }
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }
        
        .section-subtitle {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: var(--md-primary);
            margin-bottom: 16px;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 500;
            color: var(--md-text);
            letter-spacing: -0.01em;
        }
        
        .dish-card {
            position: relative;
            border-radius: var(--md-radius-lg);
            overflow: hidden;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--md-border);
            transition: all 0.3s;
        }
        
        .dish-card:hover {
            transform: translateY(-8px);
            border-color: var(--md-border-gold);
            box-shadow: var(--md-shadow);
        }
        
        .dish-image {
            position: relative;
            height: 300px;
            overflow: hidden;
        }
        
        .dish-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        
        .dish-card:hover .dish-image img {
            transform: scale(1.1);
        }
        
        .dish-badge {
            position: absolute;
            top: 16px;
            right: 16px;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .badge-limited {
            background: rgba(220, 38, 38, 0.9);
            color: white;
        }
        
        .badge-signature {
            background: rgba(212, 175, 53, 0.9);
            color: #0a0a0a;
        }
        
        .badge-sold-out {
            background: rgba(107, 114, 128, 0.9);
            color: white;
        }
        
        .dish-content {
            padding: 24px;
        }
        
        .dish-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.375rem;
            font-weight: 500;
            color: var(--md-text);
            margin-bottom: 8px;
            letter-spacing: -0.01em;
        }
        
        .dish-price {
            color: var(--md-primary);
            font-weight: 600;
            font-size: 1.125rem;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .dish-description {
            color: rgba(245, 245, 240, 0.7);
            font-size: 0.9375rem;
            margin: 12px 0 20px;
            line-height: 1.7;
            font-family: 'Cormorant Garamond', serif;
            font-weight: 300;
        }
        
        .testimonial-section {
            background: rgba(255, 255, 255, 0.01);
            padding: 80px 20px;
            text-align: center;
        }
        
        .quote-icon {
            font-size: 3rem;
            color: var(--md-primary);
            margin-bottom: 24px;
        }
        
        .testimonial-text {
            font-family: 'Playfair Display', serif;
            font-size: 1.875rem;
            font-style: italic;
            font-weight: 400;
            color: var(--md-text);
            line-height: 1.7;
            max-width: 900px;
            margin: 0 auto 40px;
            letter-spacing: -0.01em;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
        }
        
        .author-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: var(--md-primary);
        }
        
        .author-info {
            text-align: left;
        }
        
        .author-name {
            font-weight: 700;
            font-size: 0.875rem;
            text-transform: uppercase;
            color: var(--md-text);
        }
        
        .author-title {
            font-size: 0.75rem;
            color: var(--md-primary);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/views/includes/header.jsp"/>
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <p class="hero-subtitle">Trải Nghiệm Ẩm Thực Đẳng Cấp Quốc Tế</p>
            <h1 class="hero-title">
                Nghệ Thuật Ẩm Thực
                <span class="hero-title-italic">Tinh Hoa Pháp</span>
            </h1>
            <p class="hero-description">
                Nơi hương vị gặp gỡ nghệ thuật, mỗi món ăn là một kiệt tác được chế tác tỉ mỉ<br>
                bởi đội ngũ đầu bếp đẳng cấp Michelin
            </p>
            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-primary" style="text-decoration: none; font-size: 1rem; padding: 18px 48px; letter-spacing: 0.05em;">
                <span class="material-symbols-outlined" style="margin-right: 10px;">restaurant_menu</span>
                Đặt Bàn Ngay
            </a>
        </div>
        <div class="scroll-indicator">
            <span class="material-symbols-outlined" style="color: rgba(212, 175, 53, 0.6); font-size: 32px;">keyboard_arrow_down</span>
        </div>
    </section>

    <!-- Menu Section -->
    <section style="padding: 80px 20px; background: var(--md-bg-dark);">
        <div class="md-container">
            <div class="section-header">
                <p class="section-subtitle">Bộ Sưu Tập Đặc Biệt</p>
                <h2 class="section-title">Món Ăn Đặc Trưng</h2>
                <p style="color: rgba(245, 245, 240, 0.65); max-width: 700px; margin: 20px auto 0; font-size: 1.0625rem; line-height: 1.8; font-family: 'Cormorant Garamond', serif; font-weight: 300;">
                    Mỗi món ăn là một tác phẩm nghệ thuật, được chế biến từ nguyên liệu tươi ngon nhất,<br>
                    kết hợp tinh hoa ẩm thực Pháp và hương vị Việt Nam đương đại
                </p>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 32px;">
                <!-- Dish 1 -->
                <div class="dish-card">
                    <div class="dish-image">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Bò Wagyu Thượng Hạng">
                        <div class="dish-badge badge-limited">
                            <span class="material-symbols-outlined" style="font-size: 12px; vertical-align: middle;">timer</span>
                            Chỉ còn 3 phần
                        </div>
                    </div>
                    <div class="dish-content">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">
                            <h3 class="dish-name">Bò Wagyu Thượng Hạng</h3>
                            <span class="dish-price">2.500k</span>
                        </div>
                        <p class="dish-description">
                            Thịt bò A5 nhập khẩu trực tiếp từ Nhật Bản, nướng trên đá nóng núi lửa, kèm sốt nấm Truffle đen.
                        </p>
                        <button class="md-btn md-btn-secondary" style="width: 100%;">Đặt Món Ngay</button>
                    </div>
                </div>

                <!-- Dish 2 -->
                <div class="dish-card">
                    <div class="dish-image">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Tôm Hùm Alaska">
                        <div class="dish-badge badge-signature">
                            <span class="material-symbols-outlined" style="font-size: 12px; vertical-align: middle;">star</span>
                            Signature
                        </div>
                    </div>
                    <div class="dish-content">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">
                            <h3 class="dish-name">Tôm Hùm Alaska Sốt Bơ</h3>
                            <span class="dish-price">3.200k</span>
                        </div>
                        <p class="dish-description">
                            Tôm hùm tươi sống bắt tại bể, chế biến theo phong cách Pháp với sốt bơ tỏi và rượu vang trắng.
                        </p>
                        <button class="md-btn md-btn-secondary" style="width: 100%;">Đặt Món Ngay</button>
                    </div>
                </div>

                <!-- Dish 3 -->
                <div class="dish-card" style="opacity: 0.6;">
                    <div class="dish-image">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Gan Ngỗng Áp Chảo" style="filter: grayscale(100%);">
                        <div class="dish-badge badge-sold-out">
                            <span class="material-symbols-outlined" style="font-size: 12px; vertical-align: middle;">block</span>
                            Hết hàng
                        </div>
                    </div>
                    <div class="dish-content">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">
                            <h3 class="dish-name">Gan Ngỗng Áp Chảo</h3>
                            <span class="dish-price">1.800k</span>
                        </div>
                        <p class="dish-description">
                            Gan ngỗng béo ngậy tan chảy, kết hợp hoàn hảo với sốt việt quất chua nhẹ cân bằng vị giác.
                        </p>
                        <button class="md-btn md-btn-secondary" style="width: 100%; opacity: 0.5; cursor: not-allowed;" disabled>Hết Hàng Hôm Nay</button>
                    </div>
                </div>
            </div>

            <div style="text-align: center; margin-top: 48px;">
                <a href="${pageContext.request.contextPath}/menu" class="md-btn md-btn-ghost" style="text-decoration: none;">
                    Xem Toàn Bộ Thực Đơn
                    <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 16px;">arrow_forward</span>
                </a>
            </div>
        </div>
    </section>

    <!-- Testimonial Section -->
    <section class="testimonial-section">
        <div class="md-container" style="max-width: 900px;">
            <span class="material-symbols-outlined quote-icon">format_quote</span>
            <p class="testimonial-text">
                "Một trải nghiệm ẩm thực vượt xa sự mong đợi. Sự kết hợp giữa công nghệ đặt bàn 3D và hương vị tuyệt hảo tạo nên đẳng cấp khác biệt."
            </p>
            <div class="testimonial-author">
                <div class="author-avatar" style="background: linear-gradient(135deg, var(--md-primary) 0%, var(--md-primary-dark) 100%); display: flex; align-items: center; justify-content: center; color: #18140c; font-weight: 700; font-size: 18px;">
                    HQ
                </div>
                <div class="author-info">
                    <p class="author-name">Hoàng Minh Quân</p>
                    <p class="author-title">Food Critic - Tạp chí Ẩm Thực</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Spaces Section -->
    <section style="padding: 80px 20px; background: var(--md-bg-dark);">
        <div class="md-container">
            <div class="section-header">
                <p class="section-subtitle">Không Gian Sang Trọng</p>
                <h2 class="section-title">Trải Nghiệm Đẳng Cấp</h2>
                <p style="color: rgba(245, 245, 240, 0.65); max-width: 700px; margin: 20px auto 0; font-size: 1.0625rem; line-height: 1.8; font-family: 'Cormorant Garamond', serif; font-weight: 300;">
                    Không gian được thiết kế tinh tế với tầm nhìn panorama tuyệt đẹp,<br>
                    mang đến trải nghiệm ẩm thực trọn vẹn cho mọi giác quan
                </p>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 24px;">
                <!-- Sky Lounge -->
                <div class="dish-card" style="cursor: pointer;">
                    <div class="dish-image" style="height: 400px;">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Sky Lounge & City View" style="filter: brightness(0.7);">
                        <div style="position: absolute; bottom: 32px; left: 32px; right: 32px;">
                            <h3 style="font-family: 'Playfair Display', serif; font-size: 2.25rem; font-weight: 500; color: white; margin-bottom: 12px; letter-spacing: -0.01em;">Sky Lounge</h3>
                            <p style="color: rgba(255,255,255,0.85); margin-bottom: 20px; font-size: 1.0625rem; line-height: 1.7; font-family: 'Cormorant Garamond', serif; font-weight: 300;">Tầm nhìn toàn cảnh thành phố từ tầng 45, không gian mở thoáng đãng với thiết kế hiện đại</p>
                            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-ghost" style="text-decoration: none; border-color: rgba(255,255,255,0.4); color: white; font-size: 0.9375rem;">
                                Khám Phá Ngay
                                <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 18px;">arrow_forward</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Private VIP Rooms -->
                <div class="dish-card" style="cursor: pointer;">
                    <div class="dish-image" style="height: 400px;">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Private VIP Rooms" style="filter: brightness(0.7);">
                        <div style="position: absolute; bottom: 32px; left: 32px; right: 32px;">
                            <h3 style="font-family: 'Playfair Display', serif; font-size: 2.25rem; font-weight: 500; color: white; margin-bottom: 12px; letter-spacing: -0.01em;">Private Dining</h3>
                            <p style="color: rgba(255,255,255,0.85); margin-bottom: 20px; font-size: 1.0625rem; line-height: 1.7; font-family: 'Cormorant Garamond', serif; font-weight: 300;">Phòng riêng sang trọng cho các buổi gặp gỡ quan trọng, phục vụ tận tâm và riêng tư tuyệt đối</p>
                            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-ghost" style="text-decoration: none; border-color: rgba(255,255,255,0.4); color: white; font-size: 0.9375rem;">
                                Đặt Phòng VIP
                                <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 18px;">arrow_forward</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="/views/includes/footer.jsp"/>
</body>
</html>
