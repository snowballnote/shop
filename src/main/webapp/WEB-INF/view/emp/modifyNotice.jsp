<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<title>공지 수정 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/modifyNotice.css" />
</head>
<body>
<div class="admin-layout">
	<!-- 왼쪽 사이드 메뉴 -->
	<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

	<!-- 오른쪽 콘텐츠 -->
	<main class="admin-content">
		<div class="page-center">
			<div class="form-wrap">
				<h2 class="form-title">공지 수정</h2>

				<c:choose>
					<c:when test="${empty notice}">
						<div class="readonly-box">공지 정보를 불러올 수 없습니다.</div>
						<div class="link-row">
							<a href="${pageContext.request.contextPath}/emp/noticeList">← Back to List</a>
						</div>
					</c:when>

					<c:otherwise>
						<!-- action: modifyNotice (POST) -->
						<form method="post" action="${pageContext.request.contextPath}/emp/modifyNotice">
							<input type="hidden" name="noticeCode" value="${notice.noticeCode}" />

							<div class="input-row">
								<label for="noticeTitle"><strong>제목</strong></label>
								<input id="noticeTitle" name="noticeTitle" type="text"
									   value="${fn:escapeXml(notice.noticeTitle)}" required />
							</div>

							<div class="input-row">
								<label><strong>작성자</strong></label>
								<div class="readonly-box">사번(코드): ${notice.empCode}</div>
							</div>

							<div class="input-row">
								<label for="noticeContent">내용</label>
								<textarea id="noticeContent" name="noticeContent" required>${fn:escapeXml(notice.noticeContent)}</textarea>
							</div>

							<div class="btn-row">
								<button type="submit" class="btn">저장</button>
								<a class="btn btn--ghost" href="${pageContext.request.contextPath}/emp/noticeOne?noticeCode=${notice.noticeCode}">취소</a>
							</div>

							<div class="link-row">
								<a href="${pageContext.request.contextPath}/emp/noticeList">← Back to List</a>
							</div>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</main>
</div>
</body>
</html>
