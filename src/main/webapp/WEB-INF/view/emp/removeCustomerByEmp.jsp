<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>강제탈퇴 확인 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/removeCustomer.css">
</head>
<body>
	<div class="emp-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 오른쪽 콘텐츠 -->
		<main class="emp-content">
			<header class="emp-header">
				<h1 class="page-title">강제 탈퇴</h1>
			</header>

			<section class="confirm-box">
				<p class="confirm-text">
					고객 ID <strong>${customerId}</strong> 계정을<br>
					정말 <span class="warn">강제 탈퇴</span> 처리하시겠습니까?
				</p>

				<form method="post" action="${pageContext.request.contextPath}/emp/removeCustomerByEmp" class="confirm-form">
					<input type="hidden" name="customerId" value="${customerId}">
					
					<div class="form-group">
						<label for="memo">탈퇴 사유 (선택)</label>
						<textarea name="memo" id="memo" rows="4" placeholder="예: 부정 이용 의심, 요청에 의한 탈퇴 등"></textarea>
					</div>

					<div class="form-actions">
						<button type="submit" class="btn btn-danger">탈퇴 처리</button>
						<a href="${pageContext.request.contextPath}/emp/customerList" class="btn btn-cancel">취소</a>
					</div>
				</form>
			</section>
		</main>
	</div>
</body>
</html>
