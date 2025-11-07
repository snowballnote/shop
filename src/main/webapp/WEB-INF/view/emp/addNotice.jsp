<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>공지 등록 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/noticeForm.css" />
</head>
<body>
	<div class="admin-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"/>

		<!-- 오른쪽 콘텐츠 -->
		<main class="admin-content">
			<header class="emp-header">
				<h1 class="page-title">공지 등록</h1>
				<a class="btn btn--ghost" href="${pageContext.request.contextPath}/emp/noticeList">목록</a>
			</header>

			<section class="nf-section">
				<!-- 서버 메시지 -->
				<c:if test="${not empty msg}">
					<div class="nf-msg">${msg}</div>
				</c:if>

				<form method="post" action="${pageContext.request.contextPath}/emp/addNotice" class="nf-form" autocomplete="off">
					<div class="form-row">
						<label for="noticeTitle">제목</label>
						<input type="text" id="noticeTitle" name="noticeTitle" required />
					</div>

					<div class="form-row">
						<label for="noticeContent">내용</label>
						<textarea id="noticeContent" name="noticeContent" rows="10" required></textarea>
					</div>

					<!-- 현재는 hidden으로 받되, 추후 세션 사용으로 변경 권장 -->
					<input type="hidden" name="empCode" value="${loginEmp.empCode}" />

					<div class="form-actions">
						<button type="submit" class="btn btn--dark">등록</button>
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList">목록</a>
					</div>
				</form>
			</section>
		</main>
	</div>
</body>
</html>
