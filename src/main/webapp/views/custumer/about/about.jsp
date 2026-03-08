<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về Chúng Tôi - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        body {
            background: #0a0a0a;
            color: var(--md-text);
        }
        
        /* Hero Section */
        .hero-section {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, rgba(10, 10, 10, 0.8), rgba(26, 20, 16, 0.9)),
                        url('https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=1920') center/cover;
        }
        
        .hero-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 40px;
        }
        
        .hero-label {
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.2em;
            color: var(--md-primary);
            margin-bottom: 24px;
        }
        
        .hero-title {
            font-family: var(--md-font-serif);
            font-size: 4rem;
            font-weight: 700;
            color: var(--md-text);
            margin-bottom: 24px;
            line-height: 1.2;
        }
        
        .hero-subtitle {
            font-size: 1.125rem;
            color: var(--md-text-muted);
            max-width: 600px;
            line-height: 1.8;
        }
        
        /* Philosophy Section */
        .philosophy-section {
            padding: 120px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .philosophy-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 60px;
            margin-top: 80px;
        }
        
        .philosophy-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--md-border);
            border-radius: 16px;
            padding: 40px;
            transition: all 0.3s ease;
        }
        
        .philosophy-card:hover {
            background: rgba(255, 255, 255, 0.04);
            border-color: var(--md-primary);
            transform: translateY(-4px);
        }
        
        .philosophy-icon {
            width: 60px;
            height: 60px;
            background: rgba(212, 175, 53, 0.1);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
        }
        
        .philosophy-icon .material-symbols-outlined {
            font-size: 32px;
            color: var(--md-primary);
        }
        
        .philosophy-title {
            font-family: var(--md-font-serif);
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 16px;
        }
        
        .philosophy-text {
            color: var(--md-text-muted);
            line-height: 1.8;
        }
        
        /* Chef Section */
        .chef-section {
            background: linear-gradient(180deg, rgba(26, 20, 16, 0.5), rgba(10, 10, 10, 0.8));
            padding: 120px 40px;
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 80px;
        }
        
        .section-label {
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.2em;
            color: var(--md-primary);
            margin-bottom: 16px;
        }
        
        .section-title {
            font-family: var(--md-font-serif);
            font-size: 3rem;
            font-weight: 700;
            color: var(--md-text);
        }
        
        /* Executive Chef */
        .executive-chef {
            max-width: 1200px;
            margin: 0 auto 100px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 80px;
            align-items: center;
        }
        
        .chef-image {
            position: relative;
            border-radius: 16px;
            overflow: hidden;
            aspect-ratio: 3/4;
        }
        
        .chef-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: grayscale(20%);
        }
        
        .chef-info h3 {
            font-family: var(--md-font-serif);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        
        .chef-role {
            font-size: 1.125rem;
            color: var(--md-primary);
            margin-bottom: 32px;
            font-style: italic;
        }
        
        .chef-bio {
            color: var(--md-text-muted);
            line-height: 1.8;
            margin-bottom: 24px;
        }
        
        .chef-achievements {
            margin-top: 40px;
        }
        
        .achievement-item {
            display: flex;
            align-items: start;
            gap: 16px;
            margin-bottom: 20px;
        }
        
        .achievement-item .material-symbols-outlined {
            color: var(--md-primary);
            font-size: 24px;
        }
        
        /* Team Grid */
        .team-grid {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
        }
        
        .team-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--md-border);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .team-card:hover {
            transform: translateY(-8px);
            border-color: var(--md-primary);
        }
        
        .team-card-image {
            aspect-ratio: 3/4;
            overflow: hidden;
        }
        
        .team-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: grayscale(30%);
            transition: all 0.3s ease;
        }
        
        .team-card:hover .team-card-image img {
            filter: grayscale(0%);
            transform: scale(1.05);
        }
        
        .team-card-content {
            padding: 24px;
        }
        
        .team-card-name {
            font-family: var(--md-font-serif);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .team-card-role {
            color: var(--md-primary);
            font-size: 0.875rem;
            margin-bottom: 16px;
        }
        
        .team-card-specialty {
            color: var(--md-text-muted);
            font-size: 0.875rem;
            line-height: 1.6;
        }
        
        /* Awards Section */
        .awards-section {
            padding: 120px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .awards-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px;
            margin-top: 60px;
        }
        
        .award-card {
            text-align: center;
            padding: 32px;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--md-border);
            border-radius: 12px;
        }
        
        .award-year {
            font-family: var(--md-font-serif);
            font-size: 2rem;
            font-weight: 700;
            color: var(--md-primary);
            margin-bottom: 16px;
        }
        
        .award-title {
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .award-org {
            font-size: 0.875rem;
            color: var(--md-text-muted);
        }
    </style>
</head>
<body>
    <%@ include file="/views/includes/header.jsp" %>
    
    <div style="padding-top: 0;">
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <div class="hero-label">Về Chúng Tôi</div>
            <h1 class="hero-title">Antoine<br>Nguyen</h1>
            <p class="hero-subtitle">
                "Ẩm thực là một tác phẩm nghệ thuật, và mỗi món ăn là một câu chuyện kể về văn hóa, đam mê và sự tận tâm."
            </p>
        </div>
    </section>
    
    <!-- Philosophy Section -->
    <section class="philosophy-section">
        <div class="section-header">
            <div class="section-label">Triết Lý Ẩm Thực</div>
            <h2 class="section-title">Nghệ Thuật Trong Từng Món Ăn</h2>
        </div>
        
        <div class="philosophy-grid">
            <div class="philosophy-card">
                <div class="philosophy-icon">
                    <span class="material-symbols-outlined">restaurant</span>
                </div>
                <h3 class="philosophy-title">Nguyên Liệu Cao Cấp</h3>
                <p class="philosophy-text">
                    Chúng tôi chỉ sử dụng những nguyên liệu tươi ngon nhất, được tuyển chọn kỹ lưỡng từ các nhà cung cấp uy tín trên toàn thế giới. Mỗi thành phần đều được kiểm tra chất lượng nghiêm ngặt.
                </p>
            </div>
            
            <div class="philosophy-card">
                <div class="philosophy-icon">
                    <span class="material-symbols-outlined">auto_awesome</span>
                </div>
                <h3 class="philosophy-title">Kỹ Thuật Tinh Tế</h3>
                <p class="philosophy-text">
                    Kết hợp giữa kỹ thuật ẩm thực Pháp truyền thống và phương pháp hiện đại, chúng tôi tạo ra những món ăn độc đáo, tinh tế trong từng chi tiết.
                </p>
            </div>
            
            <div class="philosophy-card">
                <div class="philosophy-icon">
                    <span class="material-symbols-outlined">favorite</span>
                </div>
                <h3 class="philosophy-title">Đam Mê & Tận Tâm</h3>
                <p class="philosophy-text">
                    Mỗi món ăn được chế biến với tình yêu và sự tận tâm tuyệt đối. Chúng tôi không chỉ nấu ăn, mà còn tạo ra những trải nghiệm ẩm thực đáng nhớ.
                </p>
            </div>
            
            <div class="philosophy-card">
                <div class="philosophy-icon">
                    <span class="material-symbols-outlined">eco</span>
                </div>
                <h3 class="philosophy-title">Bền Vững & Trách Nhiệm</h3>
                <p class="philosophy-text">
                    Cam kết với môi trường và cộng đồng, chúng tôi ưu tiên sử dụng nguyên liệu địa phương, hữu cơ và thực hành ẩm thực bền vững.
                </p>
            </div>
        </div>
    </section>
    
    <!-- Chef Section -->
    <section class="chef-section">
        <div class="section-header">
            <div class="section-label">Hành Trình Sự Nghiệp</div>
            <h2 class="section-title">Đội Ngũ Bếp Trưởng</h2>
        </div>
        
        <!-- Executive Chef -->
        <div class="executive-chef">
            <div class="chef-image">
                <img src="https://images.unsplash.com/photo-1583394293214-28ded15ee548?w=800" alt="Chef Antoine Nguyen">
            </div>
            
            <div class="chef-info">
                <h3>Antoine Nguyen</h3>
                <div class="chef-role">Đầu Bếp Trưởng & Sáng Lập Viên</div>
                
                <p class="chef-bio">
                    Với hơn 20 năm kinh nghiệm trong ngành ẩm thực cao cấp, Chef Antoine đã từng làm việc tại các nhà hàng Michelin danh tiếng ở Paris và Lyon. Ông mang đến Việt Nam tinh hoa ẩm thực Pháp, kết hợp với hương vị địa phương để tạo nên phong cách độc đáo.
                </p>
                
                <p class="chef-bio">
                    Triết lý của Chef Antoine là "Ẩm thực không chỉ là món ăn, mà là nghệ thuật kể chuyện qua hương vị". Mỗi món ăn tại Maison D'Or đều mang dấu ấn cá nhân và tâm huyết của ông.
                </p>
                
                <div class="chef-achievements">
                    <div class="achievement-item">
                        <span class="material-symbols-outlined">star</span>
                        <div>
                            <strong>2 Sao Michelin</strong><br>
                            <span style="color: var(--md-text-muted); font-size: 0.875rem;">Le Cordon Bleu, Paris (2015-2018)</span>
                        </div>
                    </div>
                    
                    <div class="achievement-item">
                        <span class="material-symbols-outlined">emoji_events</span>
                        <div>
                            <strong>Best Chef Asia</strong><br>
                            <span style="color: var(--md-text-muted); font-size: 0.875rem;">Asia's 50 Best Restaurants (2022)</span>
                        </div>
                    </div>
                    
                    <div class="achievement-item">
                        <span class="material-symbols-outlined">school</span>
                        <div>
                            <strong>Tốt Nghiệp Xuất Sắc</strong><br>
                            <span style="color: var(--md-text-muted); font-size: 0.875rem;">Institut Paul Bocuse, Lyon</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Team Grid -->
        <div class="team-grid">
            <div class="team-card">
                <div class="team-card-image">
                    <img src="https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=600" alt="Sous Chef">
                </div>
                <div class="team-card-content">
                    <h4 class="team-card-name">Jean-Pierre Martin</h4>
                    <div class="team-card-role">Sous Chef de Cuisine</div>
                    <p class="team-card-specialty">
                        Chuyên môn về hải sản và các món ăn Địa Trung Hải. 15 năm kinh nghiệm tại các nhà hàng Michelin.
                    </p>
                </div>
            </div>
            
            <div class="team-card">
                <div class="team-card-image">
                    <img src="https://images.unsplash.com/photo-1581299894007-aaa50297cf16?w=600" alt="Pastry Chef">
                </div>
                <div class="team-card-content">
                    <h4 class="team-card-name">Sophie Dubois</h4>
                    <div class="team-card-role">Chef Pâtissier</div>
                    <p class="team-card-specialty">
                        Nghệ nhân bánh ngọt với bằng cấp từ École Lenôtre. Chuyên về bánh Pháp truyền thống và hiện đại.
                    </p>
                </div>
            </div>
            
            <div class="team-card">
                <div class="team-card-image">
                    <img src="https://images.unsplash.com/photo-1595273670150-bd0c3c392e46?w=600" alt="Sommelier">
                </div>
                <div class="team-card-content">
                    <h4 class="team-card-name">Luca Rossi</h4>
                    <div class="team-card-role">Head Sommelier</div>
                    <p class="team-card-specialty">
                        Chứng chỉ Master Sommelier. Quản lý hầm rượu với hơn 500 nhãn hiệu rượu vang cao cấp.
                    </p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Awards Section -->
    <section class="awards-section">
        <div class="section-header">
            <div class="section-label">Thành Tựu</div>
            <h2 class="section-title">Giải Thưởng & Danh Hiệu</h2>
        </div>
        
        <div class="awards-grid">
            <div class="award-card">
                <div class="award-year">2023</div>
                <div class="award-title">Best Fine Dining</div>
                <div class="award-org">Vietnam Restaurant Awards</div>
            </div>
            
            <div class="award-card">
                <div class="award-year">2022</div>
                <div class="award-title">Top 50 Asia</div>
                <div class="award-org">Asia's 50 Best Restaurants</div>
            </div>
            
            <div class="award-card">
                <div class="award-year">2022</div>
                <div class="award-title">Wine Spectator Award</div>
                <div class="award-org">Wine Spectator Magazine</div>
            </div>
            
            <div class="award-card">
                <div class="award-year">2021</div>
                <div class="award-title">Best New Restaurant</div>
                <div class="award-org">Gault & Millau Vietnam</div>
            </div>
        </div>
    </section>
    
    </div>
    
    <%@ include file="/views/includes/footer.jsp" %>
</body>
</html>
