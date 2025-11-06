<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 직원용 사이드 메뉴 -->
<nav class="emp-menu">
	<!-- 직원 메인 이동 -->
	<div class="emp-home">
		<a href="${pageContext.request.contextPath}/emp/empIndex" class="home-link">
			<span class="emoji">🏬</span>
			Shop Admin
		</a>
	</div>

	<!-- 로그인 직원 정보 -->
	<c:if test="${not empty loginEmp}">
		<div class="emp-profile" style="padding: 10px 18px; border-bottom: 1px solid #e5e7eb;">
			<div style="font-weight:600; margin-bottom:4px;">
				<span class="emoji">👤</span>
				${loginEmp.empName} 님
			</div>
			<a href="${pageContext.request.contextPath}/emp/empLogout" style="color:#666; font-size:14px;">로그아웃</a>
		</div>
	</c:if>

	<!-- 직원 관리 -->
	<div class="emp-menu__title">직원 관리</div>
	<ul class="emp-nav">
		<li>
			<a href="${pageContext.request.contextPath}/emp/empList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/empList') ? 'is-active' : ''}">
				<span class="emoji">👥</span> 직원 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/addEmp"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/addEmp') ? 'is-active' : ''}">
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
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/customerList') ? 'is-active' : ''}">
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
			<a href="${pageContext.request.contextPath}/emp/goodsList"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/goodsList') ? 'is-active' : ''}">
				<span class="emoji">🛍️</span> 상품 목록
			</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/emp/addGoods"
			   class="${fn:endsWith(pageContext.request.requestURI, '/emp/addGoods') ? 'is-active' : ''}">
				<span class="emoji">📦</span> 상품 등록
			</a>
		</li>
	</ul>
</nav>
