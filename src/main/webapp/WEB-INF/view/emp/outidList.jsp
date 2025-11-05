<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>탈퇴 회원 목록 | Shop Admin</title>
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
				<h1 class="page-title">탈퇴 ID 관리</h1>
			</header>

			<section>
				<table class="r-table">
					<thead>
						<tr>
							<th>ID</th>
							<th>메모</th>
							<th>탈퇴일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="o" items="${outidList}">
							<tr>
								<td>${o.id}</td>
								<td>${empty o.memo ? '-' : o.memo}</td>
								<td>${o.createdate}</td>
							</tr>
						</c:forEach>

						<c:if test="${empty outidList}">
							<tr>
								<td colspan="3" style="text-align:center; color:#888; padding:20px 0;">
									탈퇴한 회원이 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<!-- 페이징 -->
				<div class="pager">
					<c:if test="${currentPage > 1}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/outidList?currentPage=${currentPage - 1}">이전</a>
					</c:if>

					<span class="page-info">${currentPage} / ${lastPage}</span>

					<c:if test="${currentPage < lastPage}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/outidList?currentPage=${currentPage + 1}">다음</a>
					</c:if>
				</div>
			</section>
		</main>
	</div>
</body>
</html>
