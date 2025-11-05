<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>EMP | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empIndex.css">
</head>
<body>
	<!-- 세션 가드: 없으면 로그인으로 -->
	<c:if test="${empty sessionScope.loginEmp}">
		<script>
			alert('직원 로그인 후 이용 가능합니다.');
			location.href='${pageContext.request.contextPath}/out/login';
		</script>
	</c:if>

	<div class="emp-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>

		<!-- 오른쪽 콘텐츠 -->
		<main class="emp-content">
			<header class="emp-header">
				<h1>직원 메인 페이지</h1>
				<div class="emp-user">
					<span class="emp-name">
						<c:choose>
							<c:when test="${not empty loginEmp}">
								${loginEmp.empName}님 반갑습니다 👋
							</c:when>
							<c:otherwise>
								로그인 정보 없음
							</c:otherwise>
						</c:choose>
					</span>
					<a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a>
				</div>
			</header>

			
			<section class="emp-dashboard">
				<div class="emp-card">
					<h2>오늘의 주문</h2>
					<p class="num">${todayOrders}</p>
				</div>
				<div class="emp-card">
					<h2>대기중인 문의</h2>
					<p class="num">${pendingQuestions}</p>
				</div>
				<div class="emp-card">
					<h2>신규 리뷰</h2>
					<p class="num">${newReviews}</p>
				</div>
			</section>
			
		</main>
	</div>
</body>
</html>
