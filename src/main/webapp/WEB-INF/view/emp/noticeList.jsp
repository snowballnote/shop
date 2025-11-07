<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>공지 목록 | Shop Admin</title>
	<!-- 공통 레이아웃 / 메뉴 / 페이지 전용 CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/noticeList.css" />
</head>
<body>
	<div class="admin-layout">
		<!-- 왼쪽 메뉴 -->
		<jsp:include page="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 오른쪽 콘텐츠 -->
		<main class="admin-content">
			<header class="emp-header">
				<h1 class="page-title">공지 목록</h1>
				<a class="btn btn--dark" href="${pageContext.request.contextPath}/emp/addNotice">공지 등록</a>
			</header>

			<section>
				<div class="table-wrap">
					<table class="r-table">
						<thead>
							<tr>
								<th style="width:120px;">코드</th>
								<th>제목</th>
								<th style="width:180px;">작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="n" items="${list}">
								<tr>
									<td>${n.noticeCode}</td>
									<td class="title-cell">
										<a class="link" href="${pageContext.request.contextPath}/emp/noticeOne?noticeCode=${n.noticeCode}">
											${n.noticeTitle}
										</a>
									</td>
									<td>${n.createdate}</td>
								</tr>
							</c:forEach>

							<c:if test="${empty list}">
								<tr>
									<td colspan="3" class="empty">등록된 공지가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>

				<!-- 페이징 -->
				<nav class="pager" aria-label="페이지 이동">
					<div class="pager-left">
						<c:if test="${startPage > 1}">
							<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList?currentPage=1">처음</a>
							<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage - 10}">이전</a>
						</c:if>
					</div>

					<div class="pager-pages">
						<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
							<c:choose>
								<c:when test="${currentPage == i}">
									<span class="page-btn is-active">${i}</span>
								</c:when>
								<c:otherwise>
									<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>

					<div class="pager-right">
						<!-- 다음: 아직 다음 구간이 있을 때만 -->
						<c:if test="${endPage < lastPage}">
							<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${startPage + 10}">다음</a>
						</c:if>

						<!-- 끝: 현재 페이지가 마지막 페이지보다 작을 때만 -->
						<c:if test="${currentPage < lastPage}">
							<a class="page-btn" href="${pageContext.request.contextPath}/emp/noticeList?currentPage=${lastPage}">끝</a>
						</c:if>
					</div>
				</nav>
			</section>
		</main>
	</div>
</body>
</html>
