<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Goods List | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/goodsList.css" />
</head>
<body>
	<div class="emp-layout">
		<!-- 왼쪽 사이드 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 오른쪽 콘텐츠 -->
		<main class="emp-content">
			<header class="emp-header">
				<h1>상품 목록</h1>
				<a href="${pageContext.request.contextPath}/emp/addGoods" class="btn-add">+ 상품 등록</a>
			</header>

			<!-- 테이블 영역 -->
			<div class="emp-table-wrap">
				<c:choose>
					<c:when test="${empty goodsList}">
						<div class="empty-msg">등록된 상품이 없습니다.</div>
					</c:when>
					<c:otherwise>
						<table class="emp-table">
							<thead>
								<tr>
									<th style="width:100px;">코드</th>
									<th>상품명</th>
									<th style="width:140px;">가격</th>
									<th style="width:120px;">포인트율</th>
									<th style="width:160px;">등록일</th>
									<th style="width:120px;">관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="g" items="${goodsList}">
									<tr>
										<td>${g.goodsCode}</td>
										<td class="name-cell">
											<a class="row-link" href="${pageContext.request.contextPath}/emp/goodsOne?goodsCode=${g.goodsCode}">
												${g.goodsName}
											</a>
										</td>
										<td>
											<fmt:formatNumber value="${g.goodsPrice}" pattern="#,###" />원
										</td>
										<td>
											<c:out value="${g.pointRate}" />%
										</td>
										<td>${g.createdate}</td>
										<td>
											<a class="row-action" href="">수정</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- 페이징 -->
			<c:if test="${not empty goodsList}">
				<div class="pagination">
					<c:if test="${currentPage > 1}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/empGoodsList?currentPage=${currentPage - 1}">이전</a>
					</c:if>

					<span class="page-info">${currentPage} / ${lastPage}</span>

					<c:if test="${currentPage < lastPage}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/empGoodsList?currentPage=${currentPage + 1}">다음</a>
					</c:if>
				</div>
			</c:if>
		</main>
	</div>
</body>
</html>
