<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>강제탈퇴 확인 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empList.css">
</head>
<body>
<div class="admin-layout">
	<!-- 왼쪽 메뉴 -->
	<jsp:include page="/WEB-INF/view/inc/empMenu.jsp" />

	<!-- 오른쪽 콘텐츠 -->
	<main class="admin-content">
		<header class="emp-header">
			<h1 class="page-title">강제 탈퇴</h1>
		</header>

		<section>
			<p>고객 ID <strong>${customerId}</strong> 계정을 정말 강제 탈퇴하시겠습니까?</p>

			<form method="post" action="${pageContext.request.contextPath}/emp/removeCustomerByEmp">
				<input type="hidden" name="customerId" value="${customerId}">
				<div class="input-row">
					<textarea name="memo" class="input" rows="4" placeholder="탈퇴 사유 (선택)"></textarea>
				</div>
				<div style="margin-top:16px;">
					<button type="submit" class="btn btn--dark">탈퇴 처리</button>
					<a href="${pageContext.request.contextPath}/emp/customerList" class="page-btn">취소</a>
				</div>
			</form>
		</section>
	</main>
</div>
</body>
</html>
