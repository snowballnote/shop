<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 직원용 사이드 메뉴 -->
<nav class="emp-menu">
	<!-- 직원 메인 이동 -->
	<div class="emp-home">
		<a href="${pageContext.request.contextPath}/emp/empIndex" class="home-link">
			<span class="emoji">🏬</span>
			관리자
		</a>
	</div>

	<!-- 로그인 직원 정보 -->
	<c:if test="${not empty loginEmp}">
		<div class="emp-profile" style="padding: 10px 18px; border-bottom: 1px solid #e5e7eb;">
			<div style="font-weight:600; margin-bottom:4px;">
				<span class="emoji">👤</span>
				${loginEmp.empName} 님
			</div>
		</div>
	</c:if>

	<!-- 직원 관리 -->
	<div class="emp-menu__title">직원 관리</div>
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/empList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/empList') ? 'is-active' : ''}">
				<span class="emoji">👥</span> 직원 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/addEmp"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/addEmp') ? 'is-active' : ''}">
				<span class="emoji">➕</span> 직원 추가
			</a>
		</li>
	</ul>

	<div class="emp-sep"></div>

	<!-- 고객 관리 -->
	<div class="emp-menu__title">고객 관리</div>
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/customerList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/customerList') ? 'is-active' : ''}">
				<span class="emoji">🙋‍♀️</span> 고객 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/outidList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/outidList') ? 'is-active' : ''}">
				<span class="emoji">🚫</span> 탈퇴 ID 관리
			</a>
		</li>
	</ul>

	<div class="emp-sep"></div>

	<!-- 상품 관리 -->
	<div class="emp-menu__title">상품 관리</div>
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/empGoodsList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/goodsList') ? 'is-active' : ''}">
				<span class="emoji">🛍️</span> 상품 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/addGoods"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/addGoods') ? 'is-active' : ''}">
				<span class="emoji">📦</span> 상품 등록
			</a>
		</li>
	</ul>
	
	<div class="emp-sep"></div>
	
	<!-- 공지 사항 -->
	<div class="emp-menu__title">ETC</div>
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/noticeList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/noticeList') ? 'is-active' : ''}">
				<span class="emoji">📢</span> 공지 사항
			</a>
		</li>
	</ul>
	
	<!-- 주문 질문 관리 -->
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/questionList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/questionList') ? 'is-active' : ''}">
				<span class="emoji">💬</span> 주문 질문 관리
			</a>
		</li>
	</ul>
	
	<!-- 상품 리뷰 관리 -->
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/reviweList"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/reviweList') ? 'is-active' : ''}">
				<span class="emoji">⭐</span> 상품 리뷰 관리
			</a>
		</li>
	</ul>
	
	<!-- 통계 자료 -->
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/stats"
			   class="${fn:contains(pageContext.request.requestURI, '/emp/stats') ? 'is-active' : ''}">
				<span class="emoji">📊</span> 통계 자료
			</a>
		</li>
	</ul>
</nav>
