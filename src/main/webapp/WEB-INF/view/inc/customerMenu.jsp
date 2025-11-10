<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 고객 메뉴 (include 전용) --%>

<aside class="customer-menu">

	<!-- 고객 메인 이동 -->
	<div class="customer-home">
		<a href="${pageContext.request.contextPath}/customer/customerIndex" class="home-link" aria-label="Shop 메인으로 이동">
			Shop Main
		</a>
	</div>

	<!-- 환영 영역 -->
	<h2 class="cm-title">ACCOUNT DETAILS</h2>
	<div class="cm-welcome">
		<c:if test="${not empty sessionScope.loginCustomer}">
			<p class="cm-name">
				<strong>${sessionScope.loginCustomer.customerName}</strong>님 반갑습니다.
			</p>
			<p class="cm-point">
				보유 포인트 :
				<strong><fmt:formatNumber value="${sessionScope.loginCustomer.point}" type="number"/></strong> P
			</p>
			<a class="cm-logout"
			   href="${pageContext.request.contextPath}/customer/customerLogout">로그아웃</a>
		</c:if>
	</div>

	<hr class="cm-sep">

	<!-- 네비게이션 링크 -->
	<nav class="cm-links">

		<!-- 메인 (상품 목록) -->
		<a href="${pageContext.request.contextPath}/customer/customerIndex"
		   class="${fn:contains(pageContext.request.requestURI, '/customer/customerIndex') ? 'is-active' : ''}">
			상품 목록
		</a>

		<!-- 개인 정보 -->
		<a href="${pageContext.request.contextPath}/customer/customerInfo"
		   class="${fn:contains(pageContext.request.requestURI, '/customer/customerInfo') ? 'is-active' : ''}">
			개인 정보
		</a>

		<!-- 배송지 관리 -->
		<a href="${pageContext.request.contextPath}/customer/addressList"
		   class="${fn:contains(pageContext.request.requestURI, '/customer/addressList') ? 'is-active' : ''}">
			배송지 관리
		</a>
		<a href="${pageContext.request.contextPath}/customer/addAddress"
		   class="${fn:endsWith(pageContext.request.requestURI, '/customer/addAddress') ? 'is-active' : ''}">
			배송지 추가
		</a>

		<!-- 장바구니 -->
		<a href="${pageContext.request.contextPath}/customer/cartList"
		   class="${fn:contains(pageContext.request.requestURI, '/customer/cartList') ? 'is-active' : ''}">
			장바구니
		</a>

	</nav>
</aside>