<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Thực đơn - Maison D'Or</title>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Inter', sans-serif;
                background: #0a0a0a;
                color: #fff;
                min-height: 100vh;
                margin: 0;
            }
            .admin-layout {
                display: flex;
                min-height: 100vh;
            }
            .main-content {
                flex: 1;
                margin-left: 280px;
                background: linear-gradient(135deg, #1a1a1a 0%, #0d0d0d 100%);
            }
            .top-header {
                background: rgba(26, 26, 26, 0.95);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid #2a2a2a;
                padding: 20px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: sticky;
                top: 0;
                z-index: 100;
            }
            .header-title {
                font-family: 'Playfair Display', serif;
                font-size: 28px;
                font-weight: 600;
                font-style: italic;
                color: #fff;
                letter-spacing: 0.5px;
            }
            .header-actions {
                display: flex;
                gap: 16px;
                align-items: center;
            }
            .search-box {
                position: relative;
            }
            .search-box input {
                width: 350px;
                padding: 12px 20px 12px 45px;
                background: rgba(42, 42, 42, 0.6);
                border: 1px solid #3a3a3a;
                border-radius: 8px;
                color: #999;
                font-size: 14px;
                transition: all 0.3s;
            }
            .search-box input:focus {
                outline: none;
                border-color: #D4AF37;
                background: rgba(42, 42, 42, 0.9);
            }
            .search-box::before {
                content: "🔍";
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 16px;
                opacity: 0.5;
            }
            .btn-add-new {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 12px 28px;
                background: #D4AF37;
                color: #1a1a1a;
                border: none;
                border-radius: 8px;
                font-weight: 700;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s;
                text-decoration: none;
            }
            .btn-add-new:hover {
                background: #f0c14b;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
            }
            .btn-add-new::before {
                content: "➕";
                font-size: 14px;
            }
            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #D4AF37 0%, #f0c14b 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-weight: 700;
                color: #1a1a1a;
            }
            .content-wrapper {
                padding: 40px;
            }
            .tabs-container {
                display: flex;
                gap: 32px;
                margin-bottom: 32px;
                border-bottom: 2px solid #2a2a2a;
                padding-bottom: 0;
            }
            .tab-item {
                padding: 12px 0;
                color: #666;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                border-bottom: 3px solid transparent;
                margin-bottom: -2px;
                transition: all 0.3s;
            }
            .tab-item:hover {
                color: #D4AF37;
            }
            .tab-item.active {
                color: #D4AF37;
                border-bottom-color: #D4AF37;
            }
            .food-grid-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
                gap: 24px;
            }
            .food-card {
                background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
                border: 1px solid #2a2a2a;
                border-radius: 16px;
                overflow: hidden;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                cursor: pointer;
            }
            .food-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6);
                border-color: #D4AF37;
            }
            .food-card:hover .food-image img {
                transform: scale(1.1);
            }
            .food-card-inner {
                display: grid;
                grid-template-columns: 140px 1fr;
                gap: 20px;
                padding: 20px;
            }
            .food-image {
                width: 140px;
                height: 140px;
                border-radius: 12px;
                overflow: hidden;
                background: #0d0d0d;
                position: relative;
            }
            .food-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.4s;
            }
            .food-badge {
                position: absolute;
                top: 8px;
                right: 8px;
                padding: 4px 10px;
                background: rgba(212, 175, 55, 0.95);
                color: #1a1a1a;
                font-size: 10px;
                font-weight: 700;
                border-radius: 4px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .food-info {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .food-name {
                font-family: 'Playfair Display', serif;
                font-size: 20px;
                font-weight: 600;
                color: #fff;
                margin-bottom: 6px;
                line-height: 1.3;
            }
            .food-code {
                font-size: 11px;
                color: #666;
                margin-bottom: 12px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .food-description {
                font-size: 13px;
                color: #999;
                line-height: 1.6;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            .food-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 16px;
                border-top: 1px solid #2a2a2a;
                margin-top: 12px;
            }
            .food-price-label {
                font-size: 10px;
                color: #666;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 4px;
            }
            .food-price {
                font-size: 22px;
                font-weight: 700;
                color: #D4AF37;
                font-family: 'Playfair Display', serif;
            }
            .food-actions {
                display: flex;
                gap: 8px;
            }
            .btn-icon {
                width: 36px;
                height: 36px;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
                font-size: 16px;
            }
            .btn-edit {
                background: rgba(52, 152, 219, 0.15);
                color: #3498db;
            }
            .btn-edit:hover {
                background: #3498db;
                color: white;
                transform: scale(1.1);
            }
            .btn-delete {
                background: rgba(231, 76, 60, 0.15);
                color: #e74c3c;
            }
            .btn-delete:hover {
                background: #e74c3c;
                color: white;
                transform: scale(1.1);
            }
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.85);
                backdrop-filter: blur(8px);
                z-index: 2000;
                align-items: center;
                justify-content: center;
            }
            .modal.active {
                display: flex;
            }
            .modal-content {
                background: #1a1a1a;
                border-radius: 20px;
                width: 90%;
                max-width: 1000px;
                max-height: 90vh;
                overflow: hidden;
                border: 1px solid #2a2a2a;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.8);
            }
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 28px 32px;
                border-bottom: 1px solid #2a2a2a;
                background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            }
            .modal-header h2 {
                font-family: 'Playfair Display', serif;
                color: #D4AF37;
                font-size: 26px;
                font-weight: 600;
                font-style: italic;
            }
            .btn-close {
                background: rgba(255, 255, 255, 0.05);
                border: none;
                color: #999;
                font-size: 24px;
                cursor: pointer;
                padding: 8px;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                transition: all 0.3s;
            }
            .btn-close:hover {
                background: rgba(231, 76, 60, 0.2);
                color: #e74c3c;
                transform: rotate(90deg);
            }
            .modal-body {
                display: grid;
                grid-template-columns: 380px 1fr;
                max-height: calc(90vh - 180px);
            }
            .modal-image-section {
                background: #0d0d0d;
                padding: 32px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                border-right: 1px solid #2a2a2a;
            }
            .modal-image-preview {
                width: 100%;
                aspect-ratio: 1;
                border-radius: 16px;
                overflow: hidden;
                background: #1a1a1a;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                cursor: pointer;
                transition: all 0.3s;
            }
            .modal-image-preview:hover {
                transform: scale(1.02);
            }
            .modal-image-preview img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .image-upload-overlay {
                position: absolute;
                inset: 0;
                background: rgba(0, 0, 0, 0.7);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 0.3s;
            }
            .modal-image-preview:hover .image-upload-overlay {
                opacity: 1;
            }
            .upload-icon-large {
                font-size: 48px;
                margin-bottom: 12px;
            }
            .upload-text-large {
                color: #D4AF37;
                font-weight: 600;
                font-size: 14px;
            }
            .modal-form-section {
                padding: 32px;
                overflow-y: auto;
            }
            .form-section-title {
                font-size: 12px;
                color: #666;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                margin-bottom: 20px;
                font-weight: 700;
            }
            .form-group {
                margin-bottom: 24px;
            }
            .form-group label {
                display: block;
                margin-bottom: 10px;
                color: #999;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .form-group label .required {
                color: #D4AF37;
            }
            .form-group input, .form-group select, .form-group textarea {
                width: 100%;
                padding: 14px 16px;
                background: rgba(13, 13, 13, 0.8);
                border: 1px solid #2a2a2a;
                border-radius: 10px;
                color: #fff;
                font-size: 15px;
                transition: all 0.3s;
                font-family: 'Inter', sans-serif;
            }
            .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
                outline: none;
                border-color: #D4AF37;
                background: rgba(13, 13, 13, 1);
                box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
            }
            .form-group textarea {
                resize: vertical;
                min-height: 100px;
            }
            .modal-footer {
                padding: 24px 32px;
                border-top: 1px solid #2a2a2a;
                display: flex;
                gap: 12px;
                background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            }
            .btn-modal {
                flex: 1;
                padding: 14px;
                border: none;
                border-radius: 10px;
                font-weight: 700;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .btn-submit {
                background: #D4AF37;
                color: #1a1a1a;
            }
            .btn-submit:hover {
                background: #f0c14b;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
            }
            .btn-cancel {
                background: transparent;
                color: #666;
                border: 1px solid #2a2a2a;
            }
            .btn-cancel:hover {
                border-color: #666;
                color: #999;
            }
            .empty-state {
                text-align: center;
                padding: 100px 20px;
                color: #666;
            }
            .empty-icon {
                font-size: 80px;
                margin-bottom: 24px;
                opacity: 0.3;
            }
            .empty-state h3 {
                font-family: 'Playfair Display', serif;
                font-size: 24px;
                margin-bottom: 12px;
                color: #999;
            }
            @media (max-width: 968px) {
                .main-content {
                    margin-left: 70px;
                }
                .modal-body {
                    grid-template-columns: 1fr;
                }
                .food-grid-container {
                    grid-template-columns: 1fr;
                }
                .search-box input {
                    width: 250px;
                }
            }
        </style>
    </head>
    <body>
        <div class="admin-layout">
            <%@ include file="/views/includes/admin-sidebar.jsp" %>

            <div class="main-content">
                <div class="top-header">
                    <h1 class="header-title">Quản lý Thực đơn Thượng Hạng</h1>
                    <div class="header-actions">
                        <div class="search-box">
                            <input type="text" placeholder="Tìm kiếm món ăn, danh mục...">
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/food/add" class="btn-add-new">Thêm Món Mới</a>
                        <div class="user-avatar">A</div>
                    </div>
                </div>

                <div class="content-wrapper">
                    <div class="tabs-container">
                        <div class="tab-item <c:if test="${empty selectedCategory || selectedCategory == 'Tất cả'}">active</c:if>" onclick="filterCategory('Tất cả')">Tất cả</div>
                        <div class="tab-item <c:if test="${selectedCategory == 'Khai vị'}">active</c:if>" onclick="filterCategory('Khai vị')">Khai vị</div>
                        <div class="tab-item <c:if test="${selectedCategory == 'Bít tết'}">active</c:if>" onclick="filterCategory('Bít tết')">Bít tết</div>
                        <div class="tab-item <c:if test="${selectedCategory == 'Món chính'}">active</c:if>" onclick="filterCategory('Món chính')">Món chính</div>
                        <div class="tab-item <c:if test="${selectedCategory == 'Rượu vang'}">active</c:if>" onclick="filterCategory('Rượu vang')">Rượu vang</div>
                        <div class="tab-item <c:if test="${selectedCategory == 'Đồ uống'}">active</c:if>" onclick="filterCategory('Đồ uống')">Đồ uống</div>
                        </div>

                    <c:choose>
                        <c:when test="${empty foods}">
                            <div class="empty-state">
                                <div class="empty-icon">🍽️</div>
                                <h3>Chưa có món ăn nào</h3>
                                <p>Hãy thêm món ăn đầu tiên của bạn</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="food-grid-container">
                                <c:forEach var="food" items="${foods}">
                                    <div class="food-card">
                                        <div class="food-card-inner">
                                            <div class="food-image">
                                                <img src="${pageContext.request.contextPath}/${food.image}" alt="${food.name}" onerror="this.src='${pageContext.request.contextPath}/assets/images/pizza.jpg'">
                                                <div class="food-badge"><c:out value="${food.category != null ? food.category : 'Món ăn'}"/></div>
                                            </div>
                                            <div class="food-info">
                                                <div class="food-header">
                                                    <h3 class="food-name"><c:out value="${food.name}"/></h3>
                                                    <p class="food-code">MÃ: STK-${food.id}</p>
                                                    <p class="food-description"><c:out value="${food.description != null ? food.description : 'Món ăn đặc biệt từ Maison D\\'Or'}"/></p>
                                                                                                </div>
                                                                                                <div class="food-footer">
                                                                                                <div>
                                                                                                <div class="food-price-label">Giá bán (VNĐ)</div>
                                                                                                <div class="food-price"><fmt:formatNumber value="${food.price}" type="number" groupingUsed="true"/></div>
                                                                                                </div>
                                                                                                <div class="food-actions">
                                                                                                <button class="btn-icon btn-edit" onclick="editFood(${food.id})" title="Chỉnh sửa">✏️</button>
                                                                                                <button class="btn-icon btn-delete" onclick="confirmDelete(${food.id}, '<c:out value="${food.name}"/>')" title="Xóa">🗑️</button>
                                                                                                </div>
                                                                                                </div>
                                                                                                </div>
                                                                                                </div>
                                                                                                </div>
                                                                                                </c:forEach>
                                                                                                </div>
                                                                                                </c:otherwise>
                                                                                                </c:choose>
                                                                                                </div>
                                                                                                </div>
                                                                                                </div>

                                                                                                <div id="editModal" class="modal">
                                                                                                <div class="modal-content">
                                                                                                <div class="modal-header">
                                                                                                <h2>Chỉnh sửa nhanh</h2>
                                                                                                <button class="btn-close" onclick="closeEditModal()">×</button>
                                                                                                </div>
                                                                                                <form id="editForm" method="post" action="${pageContext.request.contextPath}/admin/food/update" enctype="multipart/form-data" accept-charset="UTF-8">
                                                                                                <input type="hidden" id="edit_id" name="id">
                                                                                                <div class="modal-body">
                                                                                                <div class="modal-image-section">
                                                                                                <input type="file" id="edit_image" name="imageFile" accept="image/*" style="display: none;" onchange="previewEditImage(event)">
                                                                                                <label for="edit_image" class="modal-image-preview">
                                                                                                <img id="edit_preview_img" src="" alt="Food Image">
                                                                                                <div class="image-upload-overlay">
                                                                                                <div class="upload-icon-large">📷</div>
                                                                                                <div class="upload-text-large">Click để thay đổi ảnh</div>
                                                                                                </div>
                                                                                                </label>
                                                                                                </div>
                                                                                                <div class="modal-form-section">
                                                                                                <div class="form-section-title">Thông tin món ăn</div>
                                                                                                <div class="form-group">
                                                                                                <label>Tên món ăn <span class="required">*</span></label>
                                                                                                <input type="text" id="edit_name" name="name" required>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                <label>Mô tả món ăn</label>
                                                                                                <textarea id="edit_description" name="description" placeholder="Mô tả chi tiết về món ăn..."></textarea>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                <label>Giá bán (VNĐ) <span class="required">*</span></label>
                                                                                                <input type="number" id="edit_price" name="price" step="1000" required>
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                <label>Danh mục <span class="required">*</span></label>
                                                                                                <select id="edit_category" name="category" required>
                                                                                                <option value="Khai vị">Khai vị</option>
                                                                                                <option value="Bít tết">Bít tết</option>
                                                                                                <option value="Món chính">Món chính</option>
                                                                                                <option value="Rượu vang">Rượu vang</option>
                                                                                                <option value="Đồ uống">Đồ uống</option>
                                                                                                </select>
                                                                                                </div>
                                                                                                </div>
                                                                                                </div>
                                                                                                <div class="modal-footer">
                                                                                                <button type="button" class="btn-modal btn-cancel" onclick="closeEditModal()">Hủy</button>
                                                                                                <button type="submit" class="btn-modal btn-submit">Lưu thay đổi</button>
                                                                                                </div>
                                                                                                </form>
                                                                                                </div>
                                                                                                </div>

                                                                                                <script>
                                                                                                function filterCategory(category) {
                                                                                                window.location.href = '${pageContext.request.contextPath}/admin/food?category=' + encodeURIComponent(category);
                                                                                                }
                                                                                                function editFood(id) {
                                                                                                fetch('${pageContext.request.contextPath}/api/food/' + id)
                                                                                                .then(response => response.json())
                                                                                                .then(food => {
                                                                                                document.getElementById('edit_id').value = food.id;
                                                                                                document.getElementById('edit_name').value = food.name;
                                                                                                document.getElementById('edit_category').value = food.category || 'Bít tết';
                                                                                                document.getElementById('edit_description').value = food.description || '';
                                                                                                document.getElementById('edit_price').value = food.price;
                                                                                                document.getElementById('edit_preview_img').src = '${pageContext.request.contextPath}/' + food.image;
                                                                                                document.getElementById('editModal').classList.add('active');
                                                                                                })
                                                                                                .catch(error => alert('Không thể tải thông tin món ăn'));
                                                                                                }
                                                                                                function closeEditModal() {
                                                                                                document.getElementById('editModal').classList.remove('active');
                                                                                                }
                                                                                                function previewEditImage(event) {
                                                                                                const file = event.target.files[0];
                                                                                                if (file) {
                                                                                                const reader = new FileReader();
                                                                                                reader.onload = function(e) {
                                                                                                document.getElementById('edit_preview_img').src = e.target.result;
                                                                                                }
                                                                                                reader.readAsDataURL(file);
                                                                                                }
                                                                                                }
                                                                                                function confirmDelete(id, name) {
                                                                                                if (confirm('Bạn có chắc muốn xóa món "' + name + '"?')) {
                                                                                                const form = document.createElement('form');
                                                                                                form.method = 'POST';
                                                                                                form.action = '${pageContext.request.contextPath}/admin/food/delete';
                                                                                                const input = document.createElement('input');
                                                                                                input.type = 'hidden';
                                                                                                input.name = 'id';
                                                                                                input.value = id;
                                                                                                form.appendChild(input);
                                                                                                document.body.appendChild(form);
                                                                                                form.submit();
                                                                                                }
                                                                                                }
                                                                                                document.getElementById('editModal').addEventListener('click', function(e) {
                                                                                                if (e.target === this) closeEditModal();
                                                                                                });
                                                                                                </script>
                                                                                                </body>
                                                                                                </html>
