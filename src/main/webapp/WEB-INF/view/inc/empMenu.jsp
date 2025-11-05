<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">

<aside class="emp-menu">

	<!-- 직원 메인으로 이동 -->
	<div class="emp-home">
		<a href="${pageContext.request.contextPath}/emp/empIndex" class="home-link">
			<span class="emoji">🏠</span>
		</a>
	</div>

	<!-- 메뉴 타이틀 -->
	<div class="emp-menu__title">EMP MENU</div>

	<ul class="emp-nav">
		<!-- 직원 관리 -->
		<li>
			<a href="${pageContext.request.contextPath}/emp/empList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/empList') ? 'is-active' : ''}">
				<span class="emoji">👥</span>
				직원 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/addEmp"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/addEmp') ? 'is-active' : ''}">
				<span class="emoji">➕</span>
				직원 추가
			</a>
		</li>

		<!-- 고객 관리 -->
		<li>
			<a href="${pageContext.request.contextPath}/customer/customerList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/customerList') ? 'is-active' : ''}">
				<span class="emoji">🙋‍♀️</span>
				고객 관리
			</a>
		</li>

		<!-- 탈퇴 ID 관리 -->
		<li>
			<a href="${pageContext.request.contextPath}/emp/outidList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/outidList') ? 'is-active' : ''}">
				<span class="emoji">🚫</span>
				탈퇴 ID 관리
			</a>
		</li>

		<!-- 상품 관리 -->
		<li>
			<a href="${pageContext.request.contextPath}/emp/goodsList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/goodsList') ? 'is-active' : ''}">
				<span class="emoji">🛍️</span>
				상품 관리
			</a>
		</li>
		<!-- 
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/addGoods') ? 'is-active' : ''}">
				<span class="emoji">📦</span>
				상품 등록
			</a>
		</li>
		 -->
		<!-- 주문 관리 -->
		<li>
			<a href="${pageContext.request.contextPath}/emp/orderList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/orderList') ? 'is-active' : ''}">
				<span class="emoji">🧾</span>
				주문 관리
			</a>
		</li>
		
		<!-- 공지사항 -->
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/noticeList') ? 'is-active' : ''}">
				<span class="emoji">📢</span>
				공지사항
			</a>
		</li>

		<!-- 리뷰 / 포인트 / 문의 -->
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/reviewList') ? 'is-active' : ''}">
				<span class="emoji">⭐</span>
				리뷰 관리
			</a>
		</li>
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/pointHistory') ? 'is-active' : ''}">
				<span class="emoji">💰</span>
				포인트 내역
			</a>
		</li>
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/questionList') ? 'is-active' : ''}">
				<span class="emoji">❓</span>
				문의 관리
			</a>
		</li>
	</ul>

	<div class="emp-sep"></div>

	<ul class="emp-nav">
		<!-- 내 정보 수정 -->
		<li>
			<a href=""
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/profile') ? 'is-active' : ''}">
				<span class="emoji">👤</span>
				내 정보 수정
			</a>
		</li>

		<!-- 로그아웃 -->
		<li>
			<a href="${pageContext.request.contextPath}/emp/empLogout">
				<span class="emoji">🚪</span>
				로그아웃
			</a>
		</li>
	</ul>
</aside>
