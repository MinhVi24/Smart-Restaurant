<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực Đơn - Maison D'Or</title>
    
    <!-- CSS Thống Nhất -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>
    <!-- Header Thống Nhất -->
    <jsp:include page="/views/includes/header.jsp"/>
    
    <!-- Main Content -->
    <main class="md-container" style="padding: 60px 20px;">
        <!-- Page Header -->
        <div style="text-align: center; margin-bottom: 60px;">
            <span style="color: var(--md-primary); font-size: 0.875rem; font-weight: 700; letter-spacing: 0.2em; text-transform: uppercase;">Menu Bữa Tối</span>
            <h1 style="font-family: var(--md-font-serif); font-size: 3rem; color: var(--md-text); margin-top: 12px; margin-bottom: 16px;">Nghệ Thuật Bít Tết Thượng Hạng</h1>
            <p style="color: var(--md-text-muted); font-size: 1.125rem; max-width: 700px; margin: 0 auto;">
                Trải nghiệm ẩm thực đẳng cấp với những phần cắt thượng hạng từ khắp nơi trên thế giới.
            </p>
        </div>

        <!-- Filter Tabs -->
        <div style="display: flex; justify-content: center; gap: 32px; margin-bottom: 48px; flex-wrap: wrap; border-bottom: 1px solid var(--md-border); padding-bottom: 16px;">
            <a href="#" style="color: var(--md-primary); text-decoration: none; font-weight: 700; border-bottom: 2px solid var(--md-primary); padding-bottom: 8px;">Tất Cả</a>
            <a href="#" style="color: var(--md-text-muted); text-decoration: none; padding-bottom: 8px;">Khai Vị</a>
            <a href="#" style="color: var(--md-text-muted); text-decoration: none; padding-bottom: 8px;">Bít Tết</a>
            <a href="#" style="color: var(--md-text-muted); text-decoration: none; padding-bottom: 8px;">Món Chính</a>
            <a href="#" style="color: var(--md-text-muted); text-decoration: none; padding-bottom: 8px;">Món Phụ</a>
            <a href="#" style="color: var(--md-text-muted); text-decoration: none; padding-bottom: 8px;">Đồ Uống</a>
        </div>

        <!-- Featured Dish -->
        <div class="md-card" style="display: grid; grid-template-columns: 1fr 1fr; gap: 0; overflow: hidden; margin-bottom: 60px;">
            <div style="position: relative; height: 400px;">
                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Wagyu A5" style="width: 100%; height: 100%; object-fit: cover;">
                <div style="position: absolute; top: 24px; left: 24px;">
                    <span class="md-badge md-badge-gold">Signature</span>
                </div>
            </div>
            <div style="padding: 48px;">
                <span style="color: var(--md-primary); font-size: 0.875rem; font-weight: 700; letter-spacing: 0.15em; text-transform: uppercase;">Miyazaki, Nhật Bản</span>
                <h3 style="font-family: var(--md-font-serif); font-size: 2rem; color: var(--md-text); margin: 16px 0;">Wagyu A5 Miyazaki</h3>
                <p style="color: var(--md-text-muted); margin-bottom: 24px; line-height: 1.6;">
                    Bò Wagyu A5 thượng hạng từ tỉnh Miyazaki. Vân mỡ cẩm thạch hoàn hảo (BMS 11-12), tan chảy ngay trong miệng với hương vị umami đậm đà khó quên.
                </p>
                <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 32px; color: var(--md-text-muted); font-size: 0.875rem;">
                    <span class="material-symbols-outlined" style="color: var(--md-primary);">wine_bar</span>
                    <span>Gợi ý: Cabernet Sauvignon 2015</span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 24px; border-top: 1px solid var(--md-border);">
                    <div>
                        <span style="color: var(--md-text-muted); font-size: 0.875rem;">Giá theo trọng lượng</span>
                        <div style="color: var(--md-primary); font-family: var(--md-font-serif); font-size: 1.75rem; font-weight: 700; margin-top: 4px;">
                            2.500.000₫ <span style="font-size: 0.875rem; font-weight: 400; color: var(--md-text-muted);">/ 100g</span>
                        </div>
                    </div>
                    <button class="md-btn md-btn-primary">Thêm Vào Bữa Tiệc</button>
                </div>
            </div>
        </div>

        <!-- Menu Grid -->
        <h2 style="font-family: var(--md-font-serif); font-size: 2rem; color: var(--md-text); margin-bottom: 32px;">Bộ Sưu Tập Thượng Hạng</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 24px;">
            <!-- Menu Item 1 -->
            <div class="md-card" style="display: flex; gap: 20px; padding: 20px;">
                <div style="width: 120px; height: 120px; flex-shrink: 0; border-radius: var(--md-radius); overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Ribeye" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div style="flex: 1; display: flex; flex-direction: column;">
                    <h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-text); margin-bottom: 8px;">Thăn Lưng Black Angus</h4>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 4px;">Ribeye • USDA Prime • Dry-aged 45 ngày</p>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 16px;">Hương vị hạt dẻ đặc trưng nhờ quá trình ủ khô.</p>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 12px; border-top: 1px solid var(--md-border);">
                        <span style="color: var(--md-primary); font-weight: 700; font-size: 1.125rem;">1.200.000₫</span>
                        <button class="md-btn md-btn-secondary" style="padding: 8px 16px; font-size: 0.875rem;">Thêm</button>
                    </div>
                </div>
            </div>

            <!-- Menu Item 2 -->
            <div class="md-card" style="display: flex; gap: 20px; padding: 20px;">
                <div style="width: 120px; height: 120px; flex-shrink: 0; border-radius: var(--md-radius); overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Tenderloin" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div style="flex: 1; display: flex; flex-direction: column;">
                    <h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-text); margin-bottom: 8px;">Thăn Nội Tenderloin</h4>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 4px;">Chateaubriand • Úc • Grass-fed</p>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 16px;">Phần thịt mềm nhất, ít mỡ, hương vị thanh tao.</p>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 12px; border-top: 1px solid var(--md-border);">
                        <span style="color: var(--md-primary); font-weight: 700; font-size: 1.125rem;">1.450.000₫</span>
                        <button class="md-btn md-btn-secondary" style="padding: 8px 16px; font-size: 0.875rem;">Thêm</button>
                    </div>
                </div>
            </div>

            <!-- Menu Item 3 -->
            <div class="md-card" style="display: flex; gap: 20px; padding: 20px;">
                <div style="width: 120px; height: 120px; flex-shrink: 0; border-radius: var(--md-radius); overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Tomahawk" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div style="flex: 1; display: flex; flex-direction: column;">
                    <h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-text); margin-bottom: 8px;">Tomahawk Dát Vàng</h4>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 4px;">Wagyu F1 • Úc • Gold Leaf 24K</p>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 16px;">Sườn bò nguyên xương phủ vàng lá 24K.</p>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 12px; border-top: 1px solid var(--md-border);">
                        <span style="color: var(--md-primary); font-weight: 700; font-size: 1.125rem;">4.500.000₫</span>
                        <button class="md-btn md-btn-secondary" style="padding: 8px 16px; font-size: 0.875rem;">Thêm</button>
                    </div>
                </div>
            </div>

            <!-- Menu Item 4 -->
            <div class="md-card" style="display: flex; gap: 20px; padding: 20px;">
                <div style="width: 120px; height: 120px; flex-shrink: 0; border-radius: var(--md-radius); overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Striploin" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <div style="flex: 1; display: flex; flex-direction: column;">
                    <h4 style="font-family: var(--md-font-serif); font-size: 1.25rem; color: var(--md-text); margin-bottom: 8px;">Thăn Ngoại Striploin</h4>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 4px;">New York Strip • Canada • Corn-fed</p>
                    <p style="color: var(--md-text-muted); font-size: 0.875rem; margin-bottom: 16px;">Cân bằng hoàn hảo giữa độ mềm và hương vị.</p>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 12px; border-top: 1px solid var(--md-border);">
                        <span style="color: var(--md-primary); font-weight: 700; font-size: 1.125rem;">950.000₫</span>
                        <button class="md-btn md-btn-secondary" style="padding: 8px 16px; font-size: 0.875rem;">Thêm</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sides Section -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 48px; margin-top: 80px; padding-top: 48px; border-top: 1px solid var(--md-border);">
            <div>
                <h3 style="font-family: var(--md-font-serif); font-size: 1.5rem; color: var(--md-text); margin-bottom: 24px;">Món Ăn Kèm</h3>
                <div style="display: flex; flex-direction: column; gap: 16px;">
                    <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px; border-bottom: 1px solid var(--md-border);">
                        <div>
                            <p style="color: var(--md-text); font-weight: 600;">Khoai tây nghiền Truffle</p>
                            <p style="color: var(--md-text-muted); font-size: 0.875rem;">Nấm Truffle đen, bơ Pháp</p>
                        </div>
                        <span style="color: var(--md-primary); font-weight: 700;">180.000₫</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px; border-bottom: 1px solid var(--md-border);">
                        <div>
                            <p style="color: var(--md-text); font-weight: 600;">Măng tây nướng than hoa</p>
                            <p style="color: var(--md-text-muted); font-size: 0.875rem;">Parmesan bào, dầu oliu chanh</p>
                        </div>
                        <span style="color: var(--md-primary); font-weight: 700;">150.000₫</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px; border-bottom: 1px solid var(--md-border);">
                        <div>
                            <p style="color: var(--md-text); font-weight: 600;">Rau chân vịt xào kem</p>
                            <p style="color: var(--md-text-muted); font-size: 0.875rem;">Kem tươi, tỏi phi</p>
                        </div>
                        <span style="color: var(--md-primary); font-weight: 700;">140.000₫</span>
                    </div>
                </div>
            </div>

            <div>
                <h3 style="font-family: var(--md-font-serif); font-size: 1.5rem; color: var(--md-text); margin-bottom: 24px;">Sốt Đặc Trưng</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                    <div class="md-card" style="padding: 16px; text-align: center;">
                        <p style="color: var(--md-text); font-weight: 600; margin-bottom: 4px;">Sốt Vang Đỏ</p>
                        <p style="color: var(--md-text-muted); font-size: 0.875rem;">Red Wine Jus</p>
                    </div>
                    <div class="md-card" style="padding: 16px; text-align: center;">
                        <p style="color: var(--md-text); font-weight: 600; margin-bottom: 4px;">Sốt Tiêu Đen</p>
                        <p style="color: var(--md-text-muted); font-size: 0.875rem;">Phú Quốc Peppercorn</p>
                    </div>
                    <div class="md-card" style="padding: 16px; text-align: center;">
                        <p style="color: var(--md-text); font-weight: 600; margin-bottom: 4px;">Sốt Nấm</p>
                        <p style="color: var(--md-text-muted); font-size: 0.875rem;">Wild Mushroom</p>
                    </div>
                    <div class="md-card" style="padding: 16px; text-align: center;">
                        <p style="color: var(--md-text); font-weight: 600; margin-bottom: 4px;">Sốt Phô Mai Xanh</p>
                        <p style="color: var(--md-text-muted); font-size: 0.875rem;">Blue Cheese</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer style="background: var(--md-surface-dark); border-top: 1px solid var(--md-border); padding: 32px 20px; text-align: center;">
        <div class="md-container">
            <p style="color: var(--md-text-muted); font-size: 0.875rem;">© 2024 Maison D'Or Luxury Steakhouse. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
