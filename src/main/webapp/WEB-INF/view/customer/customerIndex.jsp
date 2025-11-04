<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>My Page | Shop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mypage.css">
</head>
<body>

  <!-- Auth Guard: 비로그인 시 안내 후 이동 -->
  <c:if test="${empty sessionScope.loginCustomer}">
    <script>
      alert('로그인이 필요합니다.');
      location.href='${pageContext.request.contextPath}/out/login';
    </script>
  </c:if>

  <!-- 실제 콘텐츠는 로그인 상태에서만 렌더 -->
  <c:if test="${not empty sessionScope.loginCustomer}">
    <div class="page">

      <!-- Header -->
      <header class="mp-header">
        <h1 class="mp-title">My Account</h1>
        <div class="mp-welcome">
          <span class="mp-user">
            ${loginCustomer.customerName} 님 반갑습니다.
          </span>
          <span class="mp-point">
            (point :
            <strong><fmt:formatNumber value="${loginCustomer.point}" /></strong>)
          </span>
          <a class="underline-link"
             href="${pageContext.request.contextPath}/customer/customerLogout">LOG OUT</a>
        </div>
      </header>

      <!-- KPI Cards -->
      <section class="kpi-grid" aria-label="요약 정보">
        <div class="kpi-card">
          <span>포인트</span>
          <strong><fmt:formatNumber value="${loginCustomer.point}" /></strong>
        </div>
      </section>

      <!-- Quick Links -->
      <nav class="links" aria-label="빠른 이동">
        <a class="underline-link" href="${pageContext.request.contextPath}/customer/profile">프로필 수정</a>
        <a class="underline-link" href="${pageContext.request.contextPath}/customer/address">배송지 관리</a>
        <a class="underline-link" href="${pageContext.request.contextPath}/cart/list">장바구니</a>
        <a class="underline-link" href="${pageContext.request.contextPath}/order/list">주문내역</a>
      </nav>

      <!-- Recent Orders -->
      <section class="mp-section" aria-labelledby="recent-orders-title">
        <h2 id="recent-orders-title" class="mp-section-title">최근 주문</h2>

        <c:choose>
          <c:when test="${empty recentOrders}">
            <div class="msg">최근 주문이 없습니다.</div>
          </c:when>
          <c:otherwise>
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">주문번호</th>
                  <th scope="col">주문일</th>
                  <th scope="col">금액</th>
                  <th scope="col">상태</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="o" items="${recentOrders}">
                  <tr>
                    <td>
                      <a href="${pageContext.request.contextPath}/order/detail?orderCode=${o.orderCode}">
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
          </c:otherwise>
        </c:choose>
      </section>

      <!-- Notices -->
      <section class="mp-section" aria-labelledby="notices-title">
        <h2 id="notices-title" class="mp-section-title">공지사항</h2>

        <c:choose>
          <c:when test="${empty topNotices}">
            <div class="msg">공지사항이 없습니다.</div>
          </c:when>
          <c:otherwise>
            <ul class="notice-list">
              <c:forEach var="n" items="${topNotices}">
                <li>
                  <a href="${pageContext.request.contextPath}/notice/detail?noticeCode=${n.noticeCode}">
                    ${n.noticeTitle}
                  </a>
                  <span class="notice-date">
                    · <fmt:formatDate value="${n.createdate}" pattern="yyyy.MM.dd" />
                  </span>
                </li>
              </c:forEach>
            </ul>
          </c:otherwise>
        </c:choose>
      </section>

    </div>
  </c:if>

</body>
</html>
