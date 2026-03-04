<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Đặt Bàn - Maison D'Or Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/maison-dor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lux.css">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">

        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
        
    </head>
    <body style="display: flex; min-height: 100vh;">
        <jsp:include page="/views/admin/includes/sidebar.jsp" />

        <main class="flex-1 p-10 overflow-y-auto">
            <div class="md-container">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px;">
                    <div>
                        <h1 class="md-title">Sơ Đồ Tầng & Quản Lý Bàn</h1>
                        <p class="md-subtitle">Theo dõi và quản lý trạng thái bàn real-time</p>
                    </div>

                    <!-- Stats -->
                    <div style="display: flex; gap: 16px;">
                        <div class="md-card" style="padding: 16px; min-width: 120px;">
                            <p style="font-size: 10px; text-transform: uppercase; letter-spacing: 0.18em; color: var(--md-text-muted); margin-bottom: 8px;">Đã Đặt</p>
                            <p style="font-size: 24px; font-weight: 700; color: var(--md-primary);">
                                <c:set var="reservedCount" value="0"/>
                                <c:forEach var="table" items="${tables}">
                                    <c:if test="${table.status == 'RESERVED'}">
                                        <c:set var="reservedCount" value="${reservedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${reservedCount}
                            </p>
                        </div>
                        <div class="md-card" style="padding: 16px; min-width: 120px;">
                            <p style="font-size: 10px; text-transform: uppercase; letter-spacing: 0.18em; color: var(--md-text-muted); margin-bottom: 8px;">Đang Dùng</p>
                            <p style="font-size: 24px; font-weight: 700; color: var(--md-success);">
                                <c:set var="occupiedCount" value="0"/>
                                <c:forEach var="table" items="${tables}">
                                    <c:if test="${table.status == 'OCCUPIED'}">
                                        <c:set var="occupiedCount" value="${occupiedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${occupiedCount}
                            </p>
                        </div>
                        <div class="md-card" style="padding: 16px; min-width: 120px;">
                            <p style="font-size: 10px; text-transform: uppercase; letter-spacing: 0.18em; color: var(--md-text-muted); margin-bottom: 8px;">Trống</p>
                            <p style="font-size: 24px; font-weight: 700; color: var(--md-text);">
                                <c:set var="availableCount" value="0"/>
                                <c:forEach var="table" items="${tables}">
                                    <c:if test="${table.status == 'AVAILABLE'}">
                                        <c:set var="availableCount" value="${availableCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${availableCount}
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Floor Plan -->
                <div class="md-card">
                    <!-- Zone Tabs -->
                    <div style="display: flex; border-bottom: 1px solid var(--md-border); margin-bottom: 32px;">
                        <button class="zone-tab active" data-zone="all" style="flex: 1; padding: 16px; background: transparent; border: none; border-bottom: 2px solid var(--md-primary); color: var(--md-primary); font-weight: 600; cursor: pointer;">
                            Tất Cả Khu Vực
                        </button>
                        <button class="zone-tab" data-zone="Khu Vực Cửa Sổ" style="flex: 1; padding: 16px; background: transparent; border: none; border-bottom: 2px solid transparent; color: var(--md-text-muted); cursor: pointer;">
                            Khu Vực Cửa Sổ
                        </button>
                        <button class="zone-tab" data-zone="Khu Vườn Nhiệt Đới" style="flex: 1; padding: 16px; background: transparent; border: none; border-bottom: 2px solid transparent; color: var(--md-text-muted); cursor: pointer;">
                            Khu Vườn Nhiệt Đới
                        </button>
                        <button class="zone-tab" data-zone="Khu Vực VIP" style="flex: 1; padding: 16px; background: transparent; border: none; border-bottom: 2px solid transparent; color: var(--md-text-muted); cursor: pointer;">
                            Khu Vực VIP
                        </button>
                    </div>

                    <!-- Tables Grid -->
                    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 16px;">
                        <c:forEach var="table" items="${tables}">
                            <div class="table-card ${table.status}" data-zone="${table.area}" 
                                 style="padding: 20px; border-radius: var(--md-radius-md); border: 2px solid var(--md-border); background: rgba(255, 255, 255, 0.02); cursor: pointer; transition: all 0.3s;">

                                <!-- Table Number -->
                                <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">
                                    <div>
                                        <p style="font-size: 24px; font-weight: 700; font-family: var(--md-font-serif); color: var(--md-text);">
                                            Bàn ${table.tableId}
                                        </p>
                                        <p style="font-size: 11px; color: var(--md-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">
                                            ${table.capacity} người
                                        </p>
                                    </div>

                                    <!-- Status Badge -->
                                    <c:choose>
                                        <c:when test="${table.status == 'AVAILABLE'}">
                                            <span class="md-badge md-badge-success">Trống</span>
                                        </c:when>
                                        <c:when test="${table.status == 'RESERVED'}">
                                            <span class="md-badge md-badge-warning">Đã Đặt</span>
                                        </c:when>
                                        <c:when test="${table.status == 'OCCUPIED'}">
                                            <span class="md-badge md-badge-error">Đang Dùng</span>
                                        </c:when>
                                    </c:choose>
                                </div>

                                <!-- Area -->
                                <p style="font-size: 10px; color: var(--md-text-muted); margin-bottom: 16px;">
                                    <span class="material-symbols-outlined" style="font-size: 12px; vertical-align: middle;">location_on</span>
                                    ${table.area}
                                </p>

                                <!-- Admin Actions -->
                                <div style="display: flex; gap: 8px;">
                                    <button onclick="updateTableStatus(${table.tableId}, 'AVAILABLE')" 
                                            class="md-btn md-btn-ghost" style="flex: 1; padding: 8px; font-size: 10px;">
                                        Trống
                                    </button>
                                    <button onclick="updateTableStatus(${table.tableId}, 'OCCUPIED')" 
                                            class="md-btn md-btn-secondary" style="flex: 1; padding: 8px; font-size: 10px;">
                                        Đang Dùng
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </main>


        <script>
            // Zone filtering
            document.querySelectorAll('.zone-tab').forEach(tab => {
                tab.addEventListener('click', function () {
                    // Update active tab
                    document.querySelectorAll('.zone-tab').forEach(t => {
                        t.style.borderBottomColor = 'transparent';
                        t.style.color = 'var(--md-text-muted)';
                        t.classList.remove('active');
                    });
                    this.style.borderBottomColor = 'var(--md-primary)';
                    this.style.color = 'var(--md-primary)';
                    this.classList.add('active');

                    // Filter tables
                    const zone = this.dataset.zone;
                    document.querySelectorAll('.table-card').forEach(card => {
                        if (zone === 'all' || card.dataset.zone === zone) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });
            });

            // Update table status
            function updateTableStatus(tableId, status) {
                if (confirm('Bạn có chắc muốn thay đổi trạng thái bàn này?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/admin/bookings';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'updateStatus';

                    const tableIdInput = document.createElement('input');
                    tableIdInput.type = 'hidden';
                    tableIdInput.name = 'tableId';
                    tableIdInput.value = tableId;

                    const statusInput = document.createElement('input');
                    statusInput.type = 'hidden';
                    statusInput.name = 'status';
                    statusInput.value = status;

                    form.appendChild(actionInput);
                    form.appendChild(tableIdInput);
                    form.appendChild(statusInput);

                    document.body.appendChild(form);
                    form.submit();
                }
            }

            // Table card styling based on status
            document.querySelectorAll('.table-card').forEach(card => {
                if (card.classList.contains('AVAILABLE')) {
                    card.style.borderColor = 'rgba(40, 209, 124, 0.5)';
                    card.style.background = 'radial-gradient(circle at 0 0, rgba(40, 209, 124, 0.1), transparent 55%)';
                } else if (card.classList.contains('RESERVED')) {
                    card.style.borderColor = 'rgba(245, 158, 11, 0.5)';
                    card.style.background = 'radial-gradient(circle at 0 0, rgba(245, 158, 11, 0.1), transparent 55%)';
                } else if (card.classList.contains('OCCUPIED')) {
                    card.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                    card.style.background = 'radial-gradient(circle at 0 0, rgba(239, 68, 68, 0.1), transparent 55%)';
                }
            });
        </script>
    </body>
</html>
