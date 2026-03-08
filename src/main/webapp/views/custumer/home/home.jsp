<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VESPER - Hương Vị Đánh Thức Mọi Giác Quan</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
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
            font-size: 0.875rem;
            font-weight: 700;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--md-primary);
            margin-bottom: 24px;
        }
        
        .hero-title {
            font-family: var(--md-font-serif);
            font-size: 4.5rem;
            font-weight: 400;
            line-height: 1.2;
            color: var(--md-text);
            margin-bottom: 16px;
        }
        
        .hero-title-italic {
            font-style: italic;
            color: rgba(245, 245, 240, 0.9);
        }
        
        .hero-description {
            font-size: 1.125rem;
            color: rgba(245, 245, 240, 0.7);
            margin-bottom: 40px;
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
            font-size: 0.875rem;
            font-weight: 700;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--md-primary);
            margin-bottom: 12px;
        }
        
        .section-title {
            font-family: var(--md-font-serif);
            font-size: 2.5rem;
            color: var(--md-text);
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
            font-family: var(--md-font-serif);
            font-size: 1.25rem;
            color: var(--md-text);
            margin-bottom: 8px;
        }
        
        .dish-price {
            color: var(--md-primary);
            font-weight: 700;
            font-size: 1.125rem;
        }
        
        .dish-description {
            color: var(--md-text-muted);
            font-size: 0.875rem;
            margin: 12px 0 16px;
            line-height: 1.6;
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
            font-family: var(--md-font-serif);
            font-size: 1.75rem;
            font-style: italic;
            color: var(--md-text);
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto 32px;
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
            <p class="hero-subtitle">Nhà Hàng Ẩm Thực & Công Nghệ Tương Lai</p>
            <h1 class="hero-title">
                Hương Vị Đánh Thức<br>
                <span class="hero-title-italic">Mọi Giác Quan</span>
            </h1>
            <p class="hero-description">
                Trải nghiệm ẩm thực đẳng cấp - Đặt bàn trực tuyến dễ dàng
            </p>
            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-primary" style="text-decoration: none; font-size: 1.125rem; padding: 16px 40px;">
                <span class="material-symbols-outlined" style="margin-right: 8px;">restaurant</span>
                Trải Nghiệm Đặt Bàn
            </a>
        </div>
        <div class="scroll-indicator">
            <span class="material-symbols-outlined" style="color: rgba(255,255,255,0.5); font-size: 32px;">keyboard_arrow_down</span>
        </div>
    </section>

    <!-- Menu Section -->
    <section style="padding: 80px 20px; background: var(--md-bg-dark);">
        <div class="md-container">
            <div class="section-header">
                <p class="section-subtitle">PREMIUM SELECTION</p>
                <h2 class="section-title">Thực Đơn Giới Hạn</h2>
                <p style="color: var(--md-text-muted); max-width: 600px; margin: 16px auto 0;">
                    Mỗi món ăn được chế biến từ nguyên liệu tươi ngon nhất, mang đến trải nghiệm ẩm thực đẳng cấp
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
                <p class="section-subtitle">KHÔNG GIAN ĐẲNG CẤP</p>
                <h2 class="section-title">Không Gian Đẳng Cấp</h2>
                <p style="color: var(--md-text-muted); max-width: 600px; margin: 16px auto 0;">
                    Tận hưởng không gian sang trọng với tầm nhìn tuyệt đẹp và phòng VIP riêng tư
                </p>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 24px;">
                <!-- Sky Lounge -->
                <div class="dish-card" style="cursor: pointer;">
                    <div class="dish-image" style="height: 400px;">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Sky Lounge & City View" style="filter: brightness(0.7);">
                        <div style="position: absolute; bottom: 24px; left: 24px; right: 24px;">
                            <h3 style="font-family: var(--md-font-serif); font-size: 2rem; color: white; margin-bottom: 8px;">Sky Lounge & City View</h3>
                            <p style="color: rgba(255,255,255,0.8); margin-bottom: 16px;">Tầm nhìn toàn cảnh thành phố từ tầng cao, không gian mở thoáng đãng</p>
                            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-ghost" style="text-decoration: none; border-color: rgba(255,255,255,0.3); color: white;">
                                Đi tới đặt chỗ ngay
                                <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 16px;">arrow_forward</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Private VIP Rooms -->
                <div class="dish-card" style="cursor: pointer;">
                    <div class="dish-image" style="height: 400px;">
                        <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Private VIP Rooms" style="filter: brightness(0.7);">
                        <div style="position: absolute; bottom: 24px; left: 24px; right: 24px;">
                            <h3 style="font-family: var(--md-font-serif); font-size: 2rem; color: white; margin-bottom: 8px;">Private VIP Rooms</h3>
                            <p style="color: rgba(255,255,255,0.8); margin-bottom: 16px;">Phòng riêng sang trọng cho các buổi gặp gỡ quan trọng</p>
                            <a href="${pageContext.request.contextPath}/booking" class="md-btn md-btn-ghost" style="text-decoration: none; border-color: rgba(255,255,255,0.3); color: white;">
                                Đặt Phòng VIP
                                <span class="material-symbols-outlined" style="margin-left: 8px; font-size: 16px;">arrow_forward</span>
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
