<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>VESPER • Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lux.css">
  </head>
  <body class="lux-body">
    <header class="lux-header">
      <div class="lux-container lux-header__inner">
        <a class="lux-brand" href="${pageContext.request.contextPath}/">
          <span class="lux-brand__mark">V</span>
          <span class="lux-brand__title">
            <span class="lux-brand__name">VESPER</span>
            <span class="lux-brand__sub">Executive Admin</span>
          </span>
        </a>
        <nav class="lux-nav" aria-label="Admin navigation">
          <a aria-current="page" href="${pageContext.request.contextPath}/views/admin/food/admin-dashboard.jsp">Dashboard</a>
          <a href="${pageContext.request.contextPath}/menu">Thực đơn</a>
          <a href="${pageContext.request.contextPath}/booking">Đặt bàn</a>
          <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </nav>
      </div>
    </header>

    <main class="lux-main">
      <div class="lux-container">
        <div class="lux-row" style="align-items:flex-end;">
          <div>
            <h1 class="lux-title">Tổng quan vận hành</h1>
            <p class="lux-subtitle">Theo dõi bàn, booking và doanh thu theo thời gian thực.</p>
          </div>
          <span class="lux-badge lux-badge--gold">Admin panel</span>
        </div>

        <div class="lux-grid" style="grid-template-columns: repeat(auto-fit,minmax(220px,1fr)); gap:16px; margin-top:14px;">
          <section class="lux-card">
            <div class="lux-card__body">
              <div class="lux-kpi">
                <span class="lux-kpi__label">Tổng đơn</span>
                <span class="lux-kpi__value"><c:out value="${kpiTotalOrders != null ? kpiTotalOrders : 0}"/></span>
              </div>
            </div>
          </section>
          <section class="lux-card">
            <div class="lux-card__body">
              <div class="lux-kpi">
                <span class="lux-kpi__label">Reservations</span>
                <span class="lux-kpi__value"><c:out value="${kpiReservations != null ? kpiReservations : 0}"/></span>
              </div>
            </div>
          </section>
          <section class="lux-card">
            <div class="lux-card__body">
              <div class="lux-kpi">
                <span class="lux-kpi__label">Doanh thu</span>
                <span class="lux-kpi__value"><c:out value="${kpiRevenue != null ? kpiRevenue : 0}"/></span>
              </div>
            </div>
          </section>
        </div>

        <div class="lux-grid lux-grid--2" style="margin-top:18px;">
          <section class="lux-card">
            <div class="lux-card__body">
              <h2 class="lux-card__title">Sơ đồ bàn</h2>
              <p class="lux-help">Sử dụng chung component với màn hình khách hàng, mapping trạng thái: AVAILABLE → trống, RESERVED/OCCUPIED → đã đặt.</p>
              <div class="lux-divider"></div>
              <c:set var="includeMode" value="admin"/>
              <jsp:include page="/views/includes/floor-plan.jsp">
                <jsp:param name="includeMode" value="admin"/>
              </jsp:include>
            </div>
          </section>

          <section class="lux-card">
            <div class="lux-card__body">
              <h2 class="lux-card__title">Reservations đang diễn ra</h2>
              <table class="lux-table" aria-label="Active reservations">
                <thead>
                  <tr>
                    <th>Mã</th>
                    <th>Bàn</th>
                    <th>Trạng thái</th>
                  </tr>
                </thead>
                <tbody>
                  <c:choose>
                    <c:when test="${empty activeReservations}">
                      <tr><td colspan="3" class="lux-muted">Chưa có dữ liệu.</td></tr>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="r" items="${activeReservations}">
                        <tr>
                          <td>#<c:out value="${r.reservationId}"/></td>
                          <td><c:out value="${r.tableId != null ? r.tableId.tableId : '-'}"/></td>
                          <td><c:out value="${r.status}"/></td>
                        </tr>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </tbody>
              </table>
              <p class="lux-help">Controller Admin sẽ gán danh sách `activeReservations` khi load trang.</p>
            </div>
          </section>
        </div>
      </div>
    </main>
  </body>
</html>