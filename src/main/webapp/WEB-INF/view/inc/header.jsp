<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="uri" value="${pageContext.request.requestURI}" />

<header class="r-header">
	<div class="r-header__inner">
		<!-- 가운데 브랜드 -->
		<a href="${ctx}/emp/empList" class="r-brand">BRAND NAME</a>

		<!-- 우측 아이콘 -->
		<div class="r-nav-right">
			<a href="${ctx}/emp/empList" class="r-icon" aria-label="Search">
				<svg viewBox="0 0 24 24" aria-hidden="true">
					<circle cx="11" cy="11" r="7"></circle>
					<line x1="21" y1="21" x2="16.65" y2="16.65"></line>
				</svg>
			</a>
			<a href="${ctx}/emp/addEmp" class="r-icon" aria-label="Account">
				<svg viewBox="0 0 24 24" aria-hidden="true">
					<circle cx="12" cy="8" r="4"></circle>
					<path d="M4 20c0-4 4-6 8-6s8 2 8 6"></path>
				</svg>
			</a>
			<a href="${ctx}/emp/empLogout" class="r-icon" aria-label="Logout">
				<svg viewBox="0 0 24 24" aria-hidden="true">
					<path d="M10 17l-5-5 5-5M3 12h12"></path>
					<path d="M21 4v16a2 2 0 0 1-2 2H11a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2z"></path>
				</svg>
			</a>
		</div>
	</div>
	<div class="r-header__underline"></div>
</header>
