<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Bàn - Maison D'Or</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style>
        body {
            background: #0a0a0a;
            margin: 0;
            padding: 0;
        }
        
        .booking-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px 120px;
        }
        
        .booking-title {
            text-align: center;
            margin-bottom: 16px;
        }
        
        .booking-title h1 {
            font-family: var(--md-font-serif);
            font-size: 2.5rem;
            color: var(--md-text);
            margin: 0 0 8px 0;
        }
        
        .booking-subtitle {
            text-align: center;
            color: var(--md-text-muted);
            font-size: 0.95rem;
            margin-bottom: 40px;
        }
        
        .booking-filters {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-bottom: 48px;
            flex-wrap: wrap;
        }
        
        .filter-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--md-border);
            border-radius: var(--md-radius-lg);
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 200px;
        }
        
        .filter-item select,
        .filter-item input {
            background: transparent;
            border: none;
            color: var(--md-text);
            font-size: 0.95rem;
            flex: 1;
            outline: none;
        }
        
        .filter-item .material-symbols-outlined {
            color: var(--md-primary);
            font-size: 20px;
        }
        
        .find-btn {
            background: var(--md-primary);
            color: #0a0a0a;
            border: none;
            padding: 12px 32px;
            border-radius: var(--md-radius-lg);
            font-weight: 700;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .find-btn:hover {
            background: var(--md-primary-light);
            transform: translateY(-2px);
        }
        
        .zone-tabs {
            display: flex;
            border-bottom: 1px solid var(--md-border);
            margin-bottom: 48px;
            gap: 8px;
        }
        
        .zone-tab {
            flex: 1;
            padding: 16px;
            background: transparent;
            border: none;
            border-bottom: 2px solid transparent;
            color: var(--md-text-muted);
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .zone-tab.active {
            border-bottom-color: var(--md-primary);
            color: var(--md-primary);
        }
        
        .zone-tab:hover {
            color: var(--md-primary);
        }
        
        .zone-subtitle {
            text-align: center;
            color: var(--md-text-muted);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.2em;
            margin-top: 4px;
        }
        
        .tables-area {
            position: relative;
            min-height: 500px;
            background: rgba(255, 255, 255, 0.01);
            border-radius: var(--md-radius-lg);
            padding: 60px 40px;
            margin-bottom: 40px;
        }
        
        .table-item {
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .table-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 2px solid var(--md-border);
            background: rgba(255, 255, 255, 0.02);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--md-font-serif);
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--md-text);
            transition: all 0.3s;
        }
        
        .table-rect {
            width: 120px;
            height: 80px;
            border-radius: var(--md-radius);
            border: 2px solid var(--md-border);
            background: rgba(255, 255, 255, 0.02);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--md-font-serif);
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--md-text);
            transition: all 0.3s;
        }
        
        .table-item.available .table-circle,
        .table-item.available .table-rect {
            border-color: rgba(40, 209, 124, 0.5);
            background: radial-gradient(circle at 0 0, rgba(40, 209, 124, 0.1), transparent 55%);
        }
        
        .table-item.available:hover .table-circle,
        .table-item.available:hover .table-rect {
            border-color: var(--md-primary);
            background: radial-gradient(circle at 0 0, rgba(212, 175, 53, 0.2), transparent 55%);
            transform: scale(1.1);
            box-shadow: var(--md-glow);
        }
        
        .table-item.selected .table-circle,
        .table-item.selected .table-rect {
            border-color: var(--md-primary);
            background: var(--md-primary);
            color: #0a0a0a;
            transform: scale(1.15);
            box-shadow: var(--md-glow);
        }
        
        .table-item.occupied .table-circle,
        .table-item.occupied .table-rect,
        .table-item.reserved .table-circle,
        .table-item.reserved .table-rect {
            opacity: 0.3;
            cursor: not-allowed;
        }
        
        .table-status {
            margin-top: 8px;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }
        
        .table-item.available .table-status {
            color: #28d17c;
        }
        
        .table-item.occupied .table-status {
            color: #ef4444;
        }
        
        .table-item.reserved .table-status {
            color: #f59e0b;
        }
        
        .legend {
            display: flex;
            justify-content: center;
            gap: 32px;
            margin-top: 32px;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.875rem;
            color: var(--md-text-muted);
        }
        
        .legend-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        
        .legend-dot.available {
            background: #28d17c;
        }
        
        .legend-dot.selected {
            background: var(--md-primary);
        }
        
        .legend-dot.occupied {
            background: #ef4444;
        }
        
        .booking-footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(23, 22, 17, 0.98);
            border-top: 1px solid var(--md-border-gold);
            padding: 20px;
            backdrop-filter: blur(14px);
            z-index: 40;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .selected-info {
            display: none;
        }
        
        .selected-info.show {
            display: block;
        }
        
        .selected-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.18em;
            color: var(--md-text-muted);
            margin-bottom: 4px;
        }
        
        .selected-table {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--md-primary);
            font-family: var(--md-font-serif);
        }
        
        .selected-details {
            font-size: 0.875rem;
            color: var(--md-text-muted);
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/views/includes/header.jsp"/>
    
    <!-- Main Content -->
    <div class="booking-container">
        <div class="booking-title">
            <h1>Đặt Bàn Thượng Hạng</h1>
        </div>
        <p class="booking-subtitle">Trải nghiệm ẩm thực đẳng cấp 5 sao tại không gian sang trọng bậc nhất</p>
        
        <!-- Filters -->
        <form id="bookingForm" action="${pageContext.request.contextPath}/booking" method="post">
            <input type="hidden" name="action" value="selectTable">
            <input type="hidden" name="tableId" id="selectedTableId">
            
            <div class="booking-filters">
                <div class="filter-item">
                    <span class="material-symbols-outlined">calendar_today</span>
                    <input type="date" name="date" required 
                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                           value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                </div>
                
                <div class="filter-item">
                    <span class="material-symbols-outlined">schedule</span>
                    <select name="time" required>
                        <option value="">Chọn giờ</option>
                        <option value="11:00">11:00 - Bữa Trưa</option>
                        <option value="12:00">12:00 - Bữa Trưa</option>
                        <option value="13:00">13:00 - Bữa Trưa</option>
                        <option value="18:00">18:00 - Bữa Tối</option>
                        <option value="19:00" selected>19:00 - Bữa Tối</option>
                        <option value="20:00">20:00 - Bữa Tối</option>
                        <option value="21:00">21:00 - Bữa Tối</option>
                    </select>
                </div>
                
                <div class="filter-item">
                    <span class="material-symbols-outlined">group</span>
                    <select name="guestCount" required>
                        <option value="">Số khách</option>
                        <option value="2" selected>2 Khách</option>
                        <option value="4">4 Khách</option>
                        <option value="6">6 Khách</option>
                        <option value="8">8 Khách</option>
                    </select>
                </div>
                
                <button type="button" class="find-btn" onclick="filterTables()">Tìm Bàn</button>
            </div>
            
            <!-- Zone Tabs -->
            <div class="zone-tabs">
                <button type="button" class="zone-tab active" data-zone="Khu Vực Cửa Sổ" onclick="switchZone(this)">
                    <div>Khu Vực Cửa Sổ</div>
                    <div class="zone-subtitle">City View</div>
                </button>
                <button type="button" class="zone-tab" data-zone="Khu Vườn Nhiệt Đới" onclick="switchZone(this)">
                    <div>Khu Vườn Nhiệt Đới</div>
                    <div class="zone-subtitle">Garden Lounge</div>
                </button>
                <button type="button" class="zone-tab" data-zone="Khu Vực VIP" onclick="switchZone(this)">
                    <div>Khu Vực VIP</div>
                    <div class="zone-subtitle">Private Dining</div>
                </button>
            </div>
            
            <!-- Tables Area -->
            <div class="tables-area" id="tablesArea">
                <c:forEach var="table" items="${tables}">
                    <div class="table-item ${table.status == 'AVAILABLE' ? 'available' : table.status == 'OCCUPIED' ? 'occupied' : 'reserved'}" 
                         data-table-id="${table.tableId}"
                         data-zone="${table.area}"
                         data-capacity="${table.capacity}"
                         style="display: none;"
                         onclick="selectTable(this, ${table.tableId}, '${table.area}', ${table.capacity})">
                        <c:choose>
                            <c:when test="${table.capacity <= 4}">
                                <div class="table-circle">${table.tableId}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-rect">${table.tableId}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="table-status">
                            <c:choose>
                                <c:when test="${table.status == 'AVAILABLE'}">Trống</c:when>
                                <c:when test="${table.status == 'OCCUPIED'}">Đang Dùng</c:when>
                                <c:when test="${table.status == 'RESERVED'}">Đã Đặt</c:when>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Legend -->
            <div class="legend">
                <div class="legend-item">
                    <div class="legend-dot available"></div>
                    <span>Trống</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot selected"></div>
                    <span>Đang Chọn</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot occupied"></div>
                    <span>Đã Đặt</span>
                </div>
            </div>
        </form>
    </div>
    
    <!-- Footer -->
    <div class="booking-footer">
        <div class="footer-content">
            <div class="selected-info" id="selectedInfo">
                <div class="selected-label">Đã chọn</div>
                <div class="selected-table" id="selectedTableText">Bàn A2</div>
                <div class="selected-details" id="selectedDetails">Khu Vực Cửa Sổ • 4 Người</div>
            </div>
            <button type="submit" form="bookingForm" class="md-btn md-btn-primary" style="padding: 16px 32px;" disabled id="submitBtn">
                <span class="material-symbols-outlined" style="font-size: 20px; margin-right: 8px;">arrow_forward</span>
                <span id="submitBtnText">Tiếp Tục Chọn Món</span>
            </button>
        </div>
    </div>
    
    <script>
        let selectedTableId = null;
        let currentZone = 'Khu Vực Cửa Sổ';
        let hasMenuItems = false;
        
        // Check if cart exists in session
        function checkCart() {
            const savedCart = sessionStorage.getItem('restaurantCart');
            if (savedCart) {
                const cart = JSON.parse(savedCart);
                if (cart && cart.length > 0) {
                    hasMenuItems = true;
                    document.getElementById('submitBtnText').textContent = 'Xác Nhận Đặt Bàn';
                    return true;
                }
            }
            hasMenuItems = false;
            document.getElementById('submitBtnText').textContent = 'Tiếp Tục Chọn Món';
            return false;
        }
        
        // Layout positions for tables
        const tablePositions = {
            'Khu Vực Cửa Sổ': {
                1: {top: '50px', left: '100px'},
                2: {top: '50px', left: '250px'},
                3: {top: '50px', left: '450px'},
                4: {top: '50px', left: '650px'},
                5: {top: '200px', left: '175px'},
                6: {top: '200px', left: '375px'},
                7: {top: '200px', left: '575px'},
                8: {top: '350px', left: '250px'},
                9: {top: '350px', left: '450px'},
                10: {top: '350px', left: '650px'}
            },
            'Khu Vườn Nhiệt Đới': {
                11: {top: '50px', left: '150px'},
                12: {top: '50px', left: '350px'},
                13: {top: '50px', left: '550px'},
                14: {top: '200px', left: '100px'},
                15: {top: '200px', left: '300px'},
                16: {top: '200px', left: '500px'},
                17: {top: '200px', left: '700px'},
                18: {top: '350px', left: '200px'},
                19: {top: '350px', left: '400px'},
                20: {top: '350px', left: '600px'}
            },
            'Khu Vực VIP': {
                21: {top: '80px', left: '150px'},
                22: {top: '80px', left: '400px'},
                23: {top: '80px', left: '650px'},
                24: {top: '250px', left: '150px'},
                25: {top: '250px', left: '400px'},
                26: {top: '250px', left: '650px'},
                27: {top: '420px', left: '150px'},
                28: {top: '420px', left: '400px'},
                29: {top: '420px', left: '650px'},
                30: {top: '300px', left: '275px'}
            }
        };
        
        function switchZone(button) {
            // Update tabs
            document.querySelectorAll('.zone-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            button.classList.add('active');
            
            currentZone = button.dataset.zone;
            displayTables();
        }
        
        function displayTables() {
            const tables = document.querySelectorAll('.table-item');
            tables.forEach(table => {
                const tableZone = table.dataset.zone;
                const tableId = parseInt(table.dataset.tableId);
                
                if (tableZone === currentZone && tablePositions[currentZone][tableId]) {
                    const pos = tablePositions[currentZone][tableId];
                    table.style.top = pos.top;
                    table.style.left = pos.left;
                    table.style.display = 'flex';
                } else {
                    table.style.display = 'none';
                }
            });
        }
        
        function selectTable(element, tableId, zone, capacity) {
            if (!element.classList.contains('available')) {
                alert('Bàn này đã được đặt hoặc đang sử dụng');
                return;
            }
            
            // Remove previous selection
            document.querySelectorAll('.table-item').forEach(t => {
                t.classList.remove('selected');
            });
            
            // Select this table
            element.classList.add('selected');
            selectedTableId = tableId;
            
            // Update hidden input
            document.getElementById('selectedTableId').value = tableId;
            
            // Update footer
            document.getElementById('selectedTableText').textContent = 'Bàn ' + tableId;
            document.getElementById('selectedDetails').textContent = zone + ' • ' + capacity + ' Người';
            document.getElementById('selectedInfo').classList.add('show');
            document.getElementById('submitBtn').disabled = false;
        }
        
        function filterTables() {
            // This would filter tables based on date, time, guest count
            // For now, just display current zone
            displayTables();
        }
        
        // Initialize
        window.addEventListener('load', function() {
            displayTables();
            checkCart();
        });
        
        // Form validation and submission
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!selectedTableId) {
                alert('Vui lòng chọn bàn');
                return false;
            }
            
            // If cart exists, go to confirmation page
            if (hasMenuItems) {
                // TODO: Navigate to booking confirmation page
                alert('Đặt bàn thành công! Món ăn đã được lưu.');
                // window.location.href = '${pageContext.request.contextPath}/booking/confirm';
            } else {
                // Go to menu selection page
                window.location.href = '${pageContext.request.contextPath}/booking/menu';
            }
        });
    </script>
</body>
</html>
