<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Admin Dashboard | Shop</title>
	<!-- 공통 레이아웃 / 메뉴 / 페이지 전용 CSS (필요 시 마지막 줄을 만들어 사용) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminIndex.css" />
</head>
<body>
	<!-- 로그인 가드 -->
	<c:if test="${empty sessionScope.loginEmp}">
		<script>
			alert('로그인이 필요합니다.');
			location.href='${pageContext.request.contextPath}/out/login';
		</script>
	</c:if>

	<c:if test="${not empty sessionScope.loginEmp}">
		<div class="admin-layout"><%-- 좌: 메뉴 / 우: 콘텐츠 --%>

			<!-- 좌측 메뉴 -->
			<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

			<!-- 우측 메인 콘텐츠 -->
			<main class="admin-content">

				<header class="emp-header">
					<h1 class="page-title">관리자 대시보드</h1>
					<div class="emp-user">
						<span class="emp-name">${sessionScope.loginEmp.empName} 님 반갑습니다 👋</span>
						<a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a>
					</div>
				</header>
			</main>
		</div>
	</c:if>
</body>
</html>
