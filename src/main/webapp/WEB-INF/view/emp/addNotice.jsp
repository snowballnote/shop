<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>공지 등록 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/addNoticeForm.css" /> <%-- 새 스타일 적용 --%>
</head>
<body>
	<div class="admin-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"/>

		<!-- 오른쪽 콘텐츠 -->
		<main class="admin-content">
			<div class="page-center">
				<div class="form-wrap">
					<h2 class="form-title">공지 등록</h2>

					<!-- 서버 메시지 -->
					<c:if test="${not empty msg}">
						<div class="msg">${msg}</div>
					</c:if>

					<form method="post" action="${pageContext.request.contextPath}/emp/addNotice" autocomplete="off">
						<div class="input-row">
							<input type="text" name="noticeTitle" class="input" placeholder="제목 (Title)" required />
						</div>

						<div class="input-row">
							<textarea name="noticeContent" class="textarea" placeholder="내용 (Content)" required></textarea>
						</div>

						<input type="hidden" name="empCode" value="${loginEmp.empCode}" />

						<button type="submit" class="btn">등록</button>

						<div class="link-row">
							<a href="${pageContext.request.contextPath}/emp/noticeList">← Back to List</a>
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
</body>
</html>
