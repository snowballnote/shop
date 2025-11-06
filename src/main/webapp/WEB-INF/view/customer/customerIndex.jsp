<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>My Account | Shop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerIndex.css">
</head>
<body>

  <!-- 비로그인 가드 -->
  <c:if test="${empty sessionScope.loginCustomer}">
    <script>
      alert('로그인이 필요합니다.');
      location.href='${pageContext.request.contextPath}/out/login';
    </script>
  </c:if>

  <c:if test="${not empty sessionScope.loginCustomer}">
    <!-- 상단 타이틀 (센터) -->
    <header class="cx-header">
      <h1>My Account</h1>
    </header>

    <!-- 중앙 컨텐츠: 966px 고정폭, 화면 정중앙 정렬 -->
    <main class="cx-main">
      <!-- Account Details -->
      <section class="cx-section">
        <h2 class="cx-subtitle">Account Details</h2>

        <div class="cx-account">
          <p class="cx-line">${loginCustomer.customerName}</p>
          <p class="cx-line">${loginCustomer.customerPhone}</p>

          <nav class="cx-links">
            <a class="cx-link" href="${pageContext.request.contextPath}/customer/addressList">YOUR ADDRESSES</a>
            <a class="cx-link" href="${pageContext.request.contextPath}/customer/wishlist">YOUR WISHLIST</a>
            <a class="cx-link" href="${pageContext.request.contextPath}/customer/customerLogout">LOG OUT</a>
          </nav>
        </div>
      </section>

      <!-- Order History -->
      <section class="cx-section">
        <h2 class="cx-subtitle">Order History</h2>

        <c:choose>
          <c:when test="${empty recentOrders}">
            <p class="cx-empty">You haven't placed any orders yet.</p>
          </c:when>
          <c:otherwise>
            <div class="cx-tablewrap">
              <table class="cx-table">
                <thead>
                  <tr>
                    <th>Order #</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="o" items="${recentOrders}">
                    <tr>
                      <td>
                        <a class="cx-underline" href="${pageContext.request.contextPath}/order/detail?orderCode=${o.orderCode}">
                          ${o.orderCode}
                        </a>
                      </td>
                      <td><fmt:formatDate value="${o.createdate}" pattern="yyyy.MM.dd" /></td>
                      <td><fmt:formatNumber value="${o.totalPrice}" type="number" /></td>
                      <td>${o.orderState}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </section>
    </main>

    <!-- 푸터 (필요 시 내용 추가) -->
    <footer class="cx-footer">
      <small>© <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> Shop</small>
    </footer>
  </c:if>

</body>
</html>
