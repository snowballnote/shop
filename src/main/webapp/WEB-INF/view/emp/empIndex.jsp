<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>My Account | Shop</title>
	<!-- 순서: 공용 레이아웃 → 고객 메뉴 → 페이지 전용 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerLayout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerIndex.css">
</head>
<body>

	<!-- [비로그인 가드] 세션에 고객정보 없으면 로그인으로 보냄 -->
	<c:if test="${empty sessionScope.loginCustomer}">
		<script>
			alert('로그인이 필요합니다.');
			location.href='${pageContext.request.contextPath}/out/login';
		</script>
	</c:if>

	<!-- [로그인 상태] 본문 렌더링 -->
	<c:if test="${not empty sessionScope.loginCustomer}">
		<div class="customer-layout"><%-- 좌: 메뉴 / 우: 콘텐츠 --%>

			<!-- 좌측: 고객 메뉴 (환영영역 포함) -->
			<c:import url="/WEB-INF/view/inc/customerMenu.jsp" />

			<!-- 우측: 페이지 콘텐츠 -->
			<main class="customer-content">
				<header class="cx-header">
					<h1>My Account</h1>
				</header>

				<!-- 베스트 상품 (주문완료 기준 Top 5) -->
				<section class="cx-section">
					<h2 class="cx-subtitle">베스트 상품</h2>

					<c:choose>
						<c:when test="${empty bestGoodsList}">
							<p class="cx-empty">베스트 상품이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table class="cx-grid" border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="b" items="${bestGoodsList}" varStatus="st">
									<c:if test="${st.index % 5 == 0}">
										<tr>
									</c:if>

									<td class="cx-card">
										<a class="cx-thumb" href="${pageContext.request.contextPath}/goods/detail?goodsCode=${b.goodsCode}">
											<img
												src="${pageContext.request.contextPath}/upload/${b.filename}"
												alt="${fn:escapeXml(b.goodsName)}">
										</a>
										<div class="cx-info">
											<a class="cx-name" href="${pageContext.request.contextPath}/goods/detail?goodsCode=${b.goodsCode}">
												<c:out value="${b.goodsName}"/>
											</a>
											<div class="cx-price">
												<fmt:formatNumber value="${b.goodsPrice}" type="number"/>원
											</div>
										</div>
									</td>

									<c:if test="${st.index % 5 == 4 || st.last}">
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</c:otherwise>
					</c:choose>
				</section>

				<hr class="cx-sep">

				<!-- 전체 상품 목록 -->
				<section class="cx-section">
					<h2 class="cx-subtitle">상품 목록</h2>

					<c:choose>
						<c:when test="${empty goodsList}">
							<p class="cx-empty">등록된 상품이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table class="cx-grid" border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="m" items="${goodsList}" varStatus="state">
									<c:if test="${state.index % 5 == 0}">
										<tr>
									</c:if>

									<td class="cx-card">
										<a class="cx-thumb" href="${pageContext.request.contextPath}/goods/detail?goodsCode=${m.goodsCode}">
											<img
												src="${pageContext.request.contextPath}/upload/${m.filename}"
												alt="${fn:escapeXml(m.goodsName)}">
										</a>
										<div class="cx-info">
											<a class="cx-name" href="${pageContext.request.contextPath}/goods/detail?goodsCode=${m.goodsCode}">
												<c:out value="${m.goodsName}"/>
											</a>
											<div class="cx-price">
												<fmt:formatNumber value="${m.goodsPrice}" type="number"/>원
											</div>
										</div>
									</td>

									<c:if test="${state.index % 5 == 4 || state.last}">
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</c:otherwise>
					</c:choose>
				</section>

				<!-- (선택) 페이지네이션 필요 시 여기에 배치
				<nav class="cx-paging">
					<c:if test="${currentPage > 1}">
						<a class="pg-btn" href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${currentPage-1}">이전</a>
					</c:if>
					<span class="pg-info">${currentPage} / ${lastPage}</span>
					<c:if test="${currentPage < lastPage}">
						<a class="pg-btn" href="${pageContext.request.contextPath}/customer/customerIndex?currentPage=${currentPage+1}">다음</a>
					</c:if>
				</nav>
				-->

				<footer class="cx-footer">
					<small>© <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> Shop</small>
				</footer>
			</main>
		</div>
	</c:if>

</body>
</html>
