<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Món Mới - Maison D'Or</title>
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
            color: #ffffff;
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
            color: #ffffff;
            letter-spacing: 0.5px;
        }

        .btn-back {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: transparent;
            color: #999;
            border: 1px solid #3a3a3a;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-back:hover {
            border-color: #D4AF37;
            color: #D4AF37;
        }

        .content-wrapper {
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .form-container {
            background: linear-gradient(135deg, #1f1f1f 0%, #1a1a1a 100%);
            border: 1px solid #2a2a2a;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.5);
        }

        .form-layout {
            display: grid;
            grid-template-columns: 400px 1fr;
            min-height: 600px;
        }

        .image-section {
            background: #0d0d0d;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-right: 1px solid #2a2a2a;
            position: relative;
        }

        .image-upload-area {
            width: 100%;
            aspect-ratio: 1;
            border-radius: 16px;
            overflow: hidden;
            background: #1a1a1a;
            border: 2px dashed #3a3a3a;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .image-upload-area:hover {
            border-color: #D4AF37;
            background: #222;
        }

        .image-upload-area.has-image {
            border-style: solid;
            border-color: #D4AF37;
        }

        .upload-placeholder {
            text-align: center;
            pointer-events: none;
        }

        .upload-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .upload-text {
            color: #666;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .upload-hint {
            color: #444;
            font-size: 12px;
        }

        .image-preview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
            position: absolute;
            inset: 0;
        }

        .image-preview.show {
            display: block;
        }

        .form-section {
            padding: 40px;
            overflow-y: auto;
        }

        .form-header {
            margin-bottom: 32px;
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: #D4AF37;
            margin-bottom: 8px;
            font-style: italic;
        }

        .form-subtitle {
            color: #666;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 28px;
        }

        .form-group label {
            display: block;
            margin-bottom: 12px;
            color: #999;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group label .required {
            color: #D4AF37;
            margin-left: 4px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 16px 20px;
            background: rgba(13, 13, 13, 0.8);
            border: 1px solid #2a2a2a;
            border-radius: 12px;
            color: #fff;
            font-size: 15px;
            transition: all 0.3s;
            font-family: 'Inter', sans-serif;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #D4AF37;
            background: rgba(13, 13, 13, 1);
            box-shadow: 0 0 0 4px rgba(212, 175, 55, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.6;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-actions {
            display: flex;
            gap: 16px;
            margin-top: 40px;
            padding-top: 32px;
            border-top: 1px solid #2a2a2a;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 12px;
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
            box-shadow: 0 8px 24px rgba(212, 175, 55, 0.4);
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

        .input-hint {
            font-size: 12px;
            color: #555;
            margin-top: 8px;
            font-style: italic;
        }

        @media (max-width: 968px) {
            .main-content {
                margin-left: 70px;
            }

            .form-layout {
                grid-template-columns: 1fr;
            }

            .image-section {
                border-right: none;
                border-bottom: 1px solid #2a2a2a;
                min-height: 400px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <%@ include file="/views/includes/admin-sidebar.jsp" %>
        
        <div class="main-content">
            <div class="top-header">
                <h1 class="header-title">Thêm Món Ăn Mới</h1>
                <a href="${pageContext.request.contextPath}/admin/food" class="btn-back">
                    ← Quay lại
                </a>
            </div>

            <div class="content-wrapper">
                <form method="post" action="${pageContext.request.contextPath}/admin/food/add" enctype="multipart/form-data" accept-charset="UTF-8">
                    <div class="form-container">
                        <div class="form-layout">
                            <!-- Image Upload Section -->
                            <div class="image-section">
                                <input type="file" name="imageFile" id="imageFile" accept="image/*" required style="display: none;" onchange="previewImage(event)">
                                <label for="imageFile" class="image-upload-area" id="uploadArea">
                                    <div class="upload-placeholder" id="placeholder">
                                        <div class="upload-icon">📸</div>
                                        <p class="upload-text">Click để tải ảnh món ăn</p>
                                        <p class="upload-hint">JPG, PNG (Tối đa 5MB)</p>
                                    </div>
                                    <img id="preview" class="image-preview" src="" alt="Preview">
                                </label>
                            </div>

                            <!-- Form Section -->
                            <div class="form-section">
                                <div class="form-header">
                                    <h2 class="form-title">Thông tin món ăn</h2>
                                    <p class="form-subtitle">Điền đầy đủ thông tin để thêm món ăn vào thực đơn</p>
                                </div>

                                <div class="form-group">
                                    <label>Tên món ăn <span class="required">*</span></label>
                                    <input type="text" name="name" placeholder="VD: Bò Wagyu A5 Kagoshima" required>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Danh mục <span class="required">*</span></label>
                                        <select name="category" required>
                                            <option value="">-- Chọn danh mục --</option>
                                            <option value="Khai vị">Khai vị</option>
                                            <option value="Bít tết">Bít tết</option>
                                            <option value="Món chính">Món chính</option>
                                            <option value="Rượu vang">Rượu vang</option>
                                            <option value="Đồ uống">Đồ uống</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Giá bán (VNĐ) <span class="required">*</span></label>
                                        <input type="number" name="price" placeholder="4500000" step="1000" min="0" required>
                                        <p class="input-hint">Nhập giá không có dấu phẩy</p>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label>Mô tả món ăn</label>
                                    <textarea name="description" placeholder="Mô tả chi tiết về món ăn, nguyên liệu, hương vị đặc trưng..."></textarea>
                                    <p class="input-hint">Mô tả hấp dẫn sẽ giúp khách hàng dễ dàng lựa chọn</p>
                                </div>

                                <div class="form-actions">
                                    <button type="button" class="btn btn-cancel" onclick="window.location.href='${pageContext.request.contextPath}/admin/food'">
                                        Hủy bỏ
                                    </button>
                                    <button type="submit" class="btn btn-submit">
                                        💾 Lưu món ăn
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('preview');
                    const placeholder = document.getElementById('placeholder');
                    const uploadArea = document.getElementById('uploadArea');
                    
                    preview.src = e.target.result;
                    preview.classList.add('show');
                    placeholder.style.display = 'none';
                    uploadArea.classList.add('has-image');
                }
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>
