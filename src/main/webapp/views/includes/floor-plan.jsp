<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="lux-floor">
  <c:forEach var="t" items="${tables}">
    <c:set var="st" value="${empty t.status ? '' : fn:toLowerCase(t.status)}"/>
    <c:set var="available" value="${st == '' || st == 'available' || st == 'empty' || st == 'trong'}"/>
    <c:set var="reserved" value="${st == 'reserved' || st == 'occupied' || st == 'booked'}"/>

    <button
      type="button"
      class="lux-tabletile
             ${available ? ' lux-tabletile--available' : ''}
             ${reserved  ? ' lux-tabletile--reserved'  : ''}"
      data-table-id="${t.tableId}"
      data-area="${t.area}"
      data-capacity="${t.capacity}"
      ${includeMode eq 'user' && !available ? 'disabled' : ''}
    >
      <div class="lux-tabletile__id">#<c:out value="${t.tableId}"/></div>
      <div class="lux-tabletile__meta">
        <div><c:out value="${empty t.area ? '—' : t.area}"/></div>
        <div>Sức chứa: <c:out value="${t.capacity}"/></div>
        <div>Trạng thái: <c:out value="${empty t.status ? 'AVAILABLE' : t.status}"/></div>
      </div>
    </button>
  </c:forEach>
</div>

