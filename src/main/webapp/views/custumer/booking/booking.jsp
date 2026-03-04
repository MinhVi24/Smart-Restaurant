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
        :root {
            --floor-bg: #1a1a1a;
            --wall-color: #2a2a2a;
            --window-color: rgba(135, 206, 235, 0.3);
            --plant-color: rgba(34, 139, 34, 0.4);
        }
        
        body {
            background: #0a0a0a;
            margin: 0;
            padding: 0;
        }
        
        .booking-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px 140px;
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
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding-right: 20px;
        }
        
        .filter-item select {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23d4af35' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 0 center;
        }
        
        .filter-item select option {
            background: #1a1a1a;
            color: var(--md-text);
            padding: 8px;
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
            background: rgba(212, 175, 53, 0.05);
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
        
        /* Floor Plan Container */
        .tables-area {
            position: relative;
            min-height: 700px;
            background: var(--floor-bg);
            border-radius: var(--md-radius-lg);
            padding: 40px;
            margin-bottom: 40px;
            border: 2px solid var(--md-border);
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .tables-container {
            position: relative;
            width: 100%;
            max-width: 1100px;
            height: 650px;
            margin: 0 auto;
        }
        
        /* Decorative Elements */
        .floor-decoration {
            position: absolute;
            pointer-events: none;
            z-index: 0;
        }
        
        .window-wall {
            background: linear-gradient(180deg, 
                rgba(135, 206, 235, 0.4) 0%, 
                rgba(135, 206, 235, 0.2) 50%,
                transparent 100%);
            border: 3px solid rgba(135, 206, 235, 0.6);
            border-radius: 8px;
            box-shadow: inset 0 0 20px rgba(135, 206, 235, 0.3);
            position: relative;
        }
        
        .window-wall::before {
            content: '🪟';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 24px;
            opacity: 0.6;
        }
        
        .entrance {
            background: linear-gradient(90deg, 
                transparent, 
                rgba(212, 175, 53, 0.3) 20%,
                rgba(212, 175, 53, 0.3) 80%,
                transparent);
            border-top: 4px dashed var(--md-primary);
            border-bottom: 4px dashed var(--md-primary);
            position: relative;
        }
        
        .entrance::before {
            content: '🚪 ENTRANCE';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 12px;
            color: var(--md-primary);
            font-weight: 700;
            letter-spacing: 0.2em;
        }
        
        .plant-decoration {
            width: 50px;
            height: 50px;
            background: radial-gradient(circle, 
                rgba(34, 139, 34, 0.5), 
                rgba(34, 139, 34, 0.2) 60%,
                transparent 80%);
            border-radius: 50%;
            border: 3px solid rgba(34, 139, 34, 0.7);
            position: relative;
            animation: plantSway 3s ease-in-out infinite;
        }
        
        .plant-decoration::before {
            content: '🌿';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 28px;
        }
        
        @keyframes plantSway {
            0%, 100% { transform: rotate(-2deg); }
            50% { transform: rotate(2deg); }
        }
        
        .bar-counter {
            background: linear-gradient(135deg, 
                rgba(139, 69, 19, 0.4), 
                rgba(101, 67, 33, 0.4));
            border: 3px solid rgba(139, 69, 19, 0.7);
            border-radius: 12px;
            position: relative;
        }
        
        .bar-counter::before {
            content: '🍷 BAR';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 14px;
            color: var(--md-primary);
            font-weight: 700;
            letter-spacing: 0.2em;
        }
        
        .zone-label {
            position: absolute;
            top: 15px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.75rem;
            color: var(--md-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.2em;
            z-index: 0;
            pointer-events: none;
        }
        
        /* Table Items */
        .table-item {
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
            z-index: 10;
        }
        
        .table-wrapper {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        /* Table Shapes */
        .table-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid rgba(255, 255, 255, 0.15);
            background: radial-gradient(circle at 30% 30%, rgba(255, 255, 255, 0.08), rgba(255, 255, 255, 0.02));
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--md-font-serif);
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--md-text);
            transition: all 0.3s ease;
            position: relative;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }
        
        .table-rect {
            width: 120px;
            height: 80px;
            border-radius: 8px;
            border: 3px solid rgba(255, 255, 255, 0.15);
            background: radial-gradient(ellipse at 30% 30%, rgba(255, 255, 255, 0.08), rgba(255, 255, 255, 0.02));
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: var(--md-font-serif);
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--md-text);
            transition: all 0.3s ease;
            position: relative;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }
        
        /* Chair Indicators */
        .chair-indicator {
            position: absolute;
            width: 20px;
            height: 24px;
            background: rgba(139, 69, 19, 0.4);
            border: 2px solid rgba(139, 69, 19, 0.6);
            border-radius: 4px 4px 0 0;
            transition: all 0.3s;
        }
        
        .chair-top {
            top: -28px;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .chair-bottom {
            bottom: -28px;
            left: 50%;
            transform: translateX(-50%) rotate(180deg);
        }
        
        .chair-left {
            left: -28px;
            top: 50%;
            transform: translateY(-50%) rotate(-90deg);
        }
        
        .chair-right {
            right: -28px;
            top: 50%;
            transform: translateY(-50%) rotate(90deg);
        }
        
        /* Table States */
        .table-item.available .table-circle,
        .table-item.available .table-rect {
            border-color: rgba(40, 209, 124, 0.6);
            background: radial-gradient(circle at 30% 30%, rgba(40, 209, 124, 0.15), rgba(40, 209, 124, 0.05));
        }
        
        .table-item.available:hover .table-circle,
        .table-item.available:hover .table-rect {
            border-color: var(--md-primary);
            background: radial-gradient(circle at 30% 30%, rgba(212, 175, 53, 0.25), rgba(212, 175, 53, 0.1));
            transform: scale(1.05);
            box-shadow: 0 8px 24px rgba(212, 175, 53, 0.4);
        }
        
        .table-item.available:hover .chair-indicator {
            border-color: var(--md-primary);
            background: rgba(212, 175, 53, 0.3);
        }
        
        .table-item.selected .table-circle,
        .table-item.selected .table-rect {
            border-color: var(--md-primary);
            background: var(--md-primary);
            color: #0a0a0a;
            transform: scale(1.08);
            box-shadow: 0 8px 32px rgba(212, 175, 53, 0.6);
        }
        
        .table-item.selected .chair-indicator {
            border-color: var(--md-primary);
            background: rgba(212, 175, 53, 0.8);
        }
        
        .table-item.occupied .table-circle,
        .table-item.occupied .table-rect,
        .table-item.reserved .table-circle,
        .table-item.reserved .table-rect {
            opacity: 0.4;
            cursor: not-allowed;
            filter: grayscale(0.5);
        }
        
        /* Tooltip */
        .table-tooltip {
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%) translateY(-10px);
            background: rgba(23, 22, 17, 0.95);
            border: 1px solid var(--md-primary);
            border-radius: 8px;
            padding: 12px 16px;
            min-width: 180px;
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s;
            z-index: 100;
            backdrop-filter: blur(10px);
        }
        
        .table-item:hover .table-tooltip {
            opacity: 1;
            transform: translateX(-50%) translateY(-5px);
        }
        
        .tooltip-title {
            font-family: var(--md-font-serif);
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--md-primary);
            margin-bottom: 6px;
        }
        
        .tooltip-info {
            font-size: 0.85rem;
            color: var(--md-text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 4px;
        }
        
        .tooltip-info .material-symbols-outlined {
            font-size: 16px;
        }
        
        .tooltip-arrow {
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 8px 8px 0 8px;
            border-color: var(--md-primary) transparent transparent transparent;
        }
        
        /* Legend */
        .legend {
            display: flex;
            justify-content: center;
            gap: 32px;
            margin-top: 32px;
            flex-wrap: wrap;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.875rem;
            color: var(--md-text-muted);
        }
        
        .legend-dot {
            width: 14px;
            height: 14px;
            border-radius: 50%;
            border: 2px solid currentColor;
        }
        
        .legend-dot.available {
            background: rgba(40, 209, 124, 0.3);
            border-color: #28d17c;
        }
        
        .legend-dot.selected {
            background: var(--md-primary);
            border-color: var(--md-primary);
        }
        
        .legend-dot.occupied {
            background: rgba(239, 68, 68, 0.3);
            border-color: #ef4444;
        }
        
        .legend-chair {
            width: 16px;
            height: 20px;
            background: rgba(139, 69, 19, 0.4);
            border: 2px solid rgba(139, 69, 19, 0.6);
            border-radius: 3px 3px 0 0;
        }
        
        /* Footer */
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
            max-width: 1400px;
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
        
        @media (max-width: 768px) {
            .tables-area {
                padding: 30px 20px;
                min-height: 600px;
            }
            
            .table-circle {
                width: 65px;
                height: 65px;
                font-size: 1.1rem;
            }
            
            .table-rect {
                width: 100px;
                height: 65px;
                font-size: 1.1rem;
            }
            
            .chair-indicator {
                width: 16px;
                height: 20px;
            }
            
            .footer-content {
                flex-direction: column;
                gap: 16px;
            }
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
                <div class="tables-container">
                    <!-- Zone Label -->
                    <div class="zone-label" id="zoneLabel">Khu Vực Cửa Sổ</div>
                    
                    <!-- Decorative Elements (will be added dynamically) -->
                    <div id="decorations"></div>
                    
                    <!-- Tables -->
                    <c:forEach var="table" items="${tables}">
                    <div class="table-item ${table.status == 'AVAILABLE' ? 'available' : table.status == 'OCCUPIED' ? 'occupied' : 'reserved'}" 
                         data-table-id="${table.tableId}"
                         data-zone="${table.area}"
                         data-capacity="${table.capacity}"
                         style="display: none;"
                         onclick="selectTable(this, ${table.tableId}, '${table.area}', ${table.capacity})">
                        
                        <!-- Tooltip -->
                        <div class="table-tooltip">
                            <div class="tooltip-title">Bàn #${table.tableId}</div>
                            <div class="tooltip-info">
                                <span class="material-symbols-outlined">group</span>
                                <span>Sức chứa: ${table.capacity} người</span>
                            </div>
                            <div class="tooltip-info">
                                <span class="material-symbols-outlined">
                                    <c:choose>
                                        <c:when test="${table.status == 'AVAILABLE'}">check_circle</c:when>
                                        <c:when test="${table.status == 'OCCUPIED'}">cancel</c:when>
                                        <c:otherwise>schedule</c:otherwise>
                                    </c:choose>
                                </span>
                                <span>
                                    <c:choose>
                                        <c:when test="${table.status == 'AVAILABLE'}">Còn trống</c:when>
                                        <c:when test="${table.status == 'OCCUPIED'}">Đang sử dụng</c:when>
                                        <c:otherwise>Đã đặt trước</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="tooltip-arrow"></div>
                        </div>
                        
                        <div class="table-wrapper">
                            <c:choose>
                                <c:when test="${table.capacity == 2}">
                                    <div class="table-circle">
                                        ${table.tableId}
                                        <div class="chair-indicator chair-top"></div>
                                        <div class="chair-indicator chair-bottom"></div>
                                    </div>
                                </c:when>
                                <c:when test="${table.capacity == 4}">
                                    <div class="table-circle">
                                        ${table.tableId}
                                        <div class="chair-indicator chair-top"></div>
                                        <div class="chair-indicator chair-bottom"></div>
                                        <div class="chair-indicator chair-left"></div>
                                        <div class="chair-indicator chair-right"></div>
                                    </div>
                                </c:when>
                                <c:when test="${table.capacity == 6}">
                                    <div class="table-rect">
                                        ${table.tableId}
                                        <!-- 6 chairs: 3 on top, 3 on bottom -->
                                        <div class="chair-indicator" style="top: -28px; left: 20%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="top: -28px; left: 50%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="top: -28px; left: 80%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 20%; transform: translateX(-50%) rotate(180deg);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 50%; transform: translateX(-50%) rotate(180deg);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 80%; transform: translateX(-50%) rotate(180deg);"></div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-rect">
                                        ${table.tableId}
                                        <!-- 8 chairs: 3 on top, 3 on bottom, 1 left, 1 right -->
                                        <div class="chair-indicator" style="top: -28px; left: 20%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="top: -28px; left: 50%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="top: -28px; left: 80%; transform: translateX(-50%);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 20%; transform: translateX(-50%) rotate(180deg);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 50%; transform: translateX(-50%) rotate(180deg);"></div>
                                        <div class="chair-indicator" style="bottom: -28px; left: 80%; transform: translateX(-50%) rotate(180deg);"></div>
                                        <div class="chair-indicator chair-left"></div>
                                        <div class="chair-indicator chair-right"></div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
            
            <!-- Legend -->
            <div class="legend">
                <div class="legend-item">
                    <div class="legend-dot available"></div>
                    <span>Còn Trống</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot selected"></div>
                    <span>Đang Chọn</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot occupied"></div>
                    <span>Đã Đặt</span>
                </div>
                <div class="legend-item">
                    <div class="legend-chair"></div>
                    <span>Ghế Ngồi</span>
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
        
        // Enhanced layout - PERFECTLY CENTERED with proper spacing
        const tablePositions = {
            'Khu Vực Cửa Sổ': {
                1: {top: '180px', left: '150px'},
                2: {top: '180px', left: '380px'},
                3: {top: '180px', left: '650px'},
                4: {top: '180px', left: '880px'},
                5: {top: '380px', left: '265px'},
                6: {top: '380px', left: '515px'},
                7: {top: '380px', left: '765px'},
                8: {top: '560px', left: '380px'},
                9: {top: '560px', left: '650px'},
                10: {top: '560px', left: '880px'}
            },
            'Khu Vườn Nhiệt Đới': {
                11: {top: '180px', left: '200px'},
                12: {top: '180px', left: '515px'},
                13: {top: '180px', left: '830px'},
                14: {top: '380px', left: '150px'},
                15: {top: '380px', left: '400px'},
                16: {top: '380px', left: '630px'},
                17: {top: '380px', left: '880px'},
                18: {top: '560px', left: '300px'},
                19: {top: '560px', left: '550px'},
                20: {top: '560px', left: '800px'}
            },
            'Khu Vực VIP': {
                21: {top: '180px', left: '200px'},
                22: {top: '180px', left: '515px'},
                23: {top: '180px', left: '830px'},
                24: {top: '380px', left: '200px'},
                25: {top: '380px', left: '515px'},
                26: {top: '380px', left: '830px'},
                27: {top: '560px', left: '200px'},
                28: {top: '560px', left: '515px'},
                29: {top: '560px', left: '830px'},
                30: {top: '470px', left: '357px'}
            }
        };
        
        // Decorations - CLEAN and NOT OVERLAPPING
        const zoneDecorations = {
            'Khu Vực Cửa Sổ': [
                {type: 'window', top: '10px', left: '100px', width: '900px', height: '90px'},
                {type: 'plant', top: '120px', left: '20px'},
                {type: 'plant', top: '120px', left: '1020px'},
                {type: 'plant', top: '400px', left: '20px'},
                {type: 'plant', top: '400px', left: '1020px'}
            ],
            'Khu Vườn Nhiệt Đới': [
                {type: 'plant', top: '100px', left: '20px'},
                {type: 'plant', top: '100px', left: '1020px'},
                {type: 'plant', top: '320px', left: '20px'},
                {type: 'plant', top: '320px', left: '1020px'},
                {type: 'plant', top: '520px', left: '20px'},
                {type: 'plant', top: '520px', left: '1020px'},
                {type: 'bar', top: '615px', left: '410px', width: '260px', height: '55px'}
            ],
            'Khu Vực VIP': [
                {type: 'entrance', top: '10px', left: '437px', width: '230px', height: '70px'},
                {type: 'plant', top: '100px', left: '20px'},
                {type: 'plant', top: '100px', left: '1020px'},
                {type: 'plant', top: '340px', left: '20px'},
                {type: 'plant', top: '340px', left: '1020px'},
                {type: 'plant', top: '540px', left: '20px'},
                {type: 'plant', top: '540px', left: '1020px'},
                {type: 'window', top: '615px', left: '150px', width: '800px', height: '55px'}
            ]
        };
        
        function switchZone(button) {
            // Update tabs
            document.querySelectorAll('.zone-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            button.classList.add('active');
            
            currentZone = button.dataset.zone;
            document.getElementById('zoneLabel').textContent = currentZone;
            
            displayTables();
            displayDecorations();
        }
        
        function displayDecorations() {
            const decorationsContainer = document.getElementById('decorations');
            decorationsContainer.innerHTML = '';
            
            const decorations = zoneDecorations[currentZone] || [];
            decorations.forEach(deco => {
                const el = document.createElement('div');
                el.className = 'floor-decoration';
                el.style.top = deco.top;
                el.style.left = deco.left;
                
                if (deco.type === 'window') {
                    el.classList.add('window-wall');
                    el.style.width = deco.width;
                    el.style.height = deco.height;
                } else if (deco.type === 'plant') {
                    el.classList.add('plant-decoration');
                } else if (deco.type === 'entrance') {
                    el.classList.add('entrance');
                    el.style.width = deco.width;
                    el.style.height = deco.height;
                } else if (deco.type === 'bar') {
                    el.classList.add('bar-counter');
                    el.style.width = deco.width;
                    el.style.height = deco.height;
                }
                
                decorationsContainer.appendChild(el);
            });
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
            // Prevent selection if not available
            if (!element.classList.contains('available')) {
                alert('Bàn này đã được đặt hoặc đang sử dụng. Vui lòng chọn bàn khác.');
                return false;
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
            document.getElementById('selectedTableText').textContent = 'Bàn #' + tableId;
            document.getElementById('selectedDetails').textContent = zone + ' • ' + capacity + ' Người';
            document.getElementById('selectedInfo').classList.add('show');
            document.getElementById('submitBtn').disabled = false;
            
            // Smooth scroll to footer
            setTimeout(() => {
                window.scrollTo({
                    top: document.body.scrollHeight,
                    behavior: 'smooth'
                });
            }, 100);
        }
        
        function filterTables() {
            const date = document.querySelector('input[name="date"]').value;
            const time = document.querySelector('select[name="time"]').value;
            const guestCount = document.querySelector('select[name="guestCount"]').value;
            
            if (!date || !time || !guestCount) {
                alert('Vui lòng chọn đầy đủ ngày, giờ và số khách');
                return;
            }
            
            // Show loading state
            const findBtn = document.querySelector('.find-btn');
            const originalText = findBtn.textContent;
            findBtn.textContent = 'Đang tìm...';
            findBtn.disabled = true;
            
            // Call AJAX to get available tables
            fetch('${pageContext.request.contextPath}/booking?action=filterTables&date=' + encodeURIComponent(date) + 
                  '&time=' + encodeURIComponent(time) + '&guestCount=' + encodeURIComponent(guestCount))
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const availableTableIds = data.availableTableIds || [];
                        
                        // Update all tables based on availability
                        document.querySelectorAll('.table-item').forEach(table => {
                            const tableId = parseInt(table.dataset.tableId);
                            const tableCapacity = parseInt(table.dataset.capacity);
                            const capacity = parseInt(guestCount);
                            
                            // Remove all status classes first
                            table.classList.remove('available', 'occupied', 'reserved');
                            
                            // Check if table is available for this date/time
                            if (availableTableIds.includes(tableId)) {
                                // Check capacity
                                if (tableCapacity >= capacity) {
                                    table.classList.add('available');
                                    table.style.opacity = '1';
                                    table.style.pointerEvents = 'auto';
                                } else {
                                    // Not enough capacity
                                    table.classList.add('occupied');
                                    table.style.opacity = '0.4';
                                    table.style.pointerEvents = 'none';
                                }
                            } else {
                                // Table is reserved/occupied at this time
                                table.classList.add('reserved');
                                table.style.opacity = '0.4';
                                table.style.pointerEvents = 'none';
                            }
                        });
                        
                        // Display tables for current zone
                        displayTables();
                        
                        // Show success message
                        const availableCount = availableTableIds.filter(id => {
                            const table = document.querySelector('[data-table-id="' + id + '"]');
                            return table && parseInt(table.dataset.capacity) >= capacity;
                        }).length;
                        
                        if (availableCount === 0) {
                            alert('Không có bàn trống phù hợp. Vui lòng chọn thời gian khác.');
                        }
                    } else {
                        alert('Lỗi: ' + (data.error || 'Không thể tìm bàn'));
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi tìm bàn. Vui lòng thử lại.');
                })
                .finally(() => {
                    findBtn.textContent = originalText;
                    findBtn.disabled = false;
                });
        }
        
        // Initialize on page load
        window.addEventListener('load', function() {
            // Show all tables initially (mark all as available until user filters)
            document.querySelectorAll('.table-item').forEach(table => {
                // Set initial state based on database status
                const hasAvailable = table.classList.contains('available');
                const hasOccupied = table.classList.contains('occupied');
                const hasReserved = table.classList.contains('reserved');
                
                // If no status class, default to available
                if (!hasAvailable && !hasOccupied && !hasReserved) {
                    table.classList.add('available');
                }
            });
            
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
