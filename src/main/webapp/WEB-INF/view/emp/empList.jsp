<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>EMP 목록 | Shop Admin</title>
	<!-- 순서 중요: 공통 → 메뉴 → 페이지전용 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empList.css">
</head>
<body>
	<div class="admin-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 오른쪽 콘텐츠 -->
		<main class="admin-content">
			<header class="emp-header">
				<h1 class="page-title">직원 목록</h1>
				<a class="btn btn--dark" href="${pageContext.request.contextPath}/emp/addEmp">직원추가</a>
			</header>

			<section>
				<table class="r-table">
					<thead>
						<tr>
							<th style="text-align:center;">empCode</th>
							<th style="text-align:center;">empId</th>
							<th style="text-align:center;">empName</th>
							<th style="text-align:center;">createdate</th>
							<th style="text-align:center;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="e" items="${empList}">
							<tr>
								<td>${e.empCode}</td>
								<td>${e.empId}</td>
								<td>${e.empName}</td>
								<td>${e.createdate}</td>
								<td>
									<c:set var="nextActive" value="${e.active == 1 ? 0 : 1}" />
									<a class="page-btn"
									   href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&nextActive=${nextActive}&currentPage=${currentPage}">
										${e.active == 1 ? '활성화' : '비활성화'}
									</a>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty empList}">
							<tr>
								<td colspan="5" style="text-align:center; color:#888; padding:24px 0;">
									데이터가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<div class="pager">
					<c:if test="${currentPage > 1}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage - 1}">이전</a>
					</c:if>
					<span class="page-info">${currentPage} / ${lastPage}</span>
					<c:if test="${currentPage < lastPage}">
						<a class="page-btn" href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage + 1}">다음</a>
					</c:if>
				</div>
			</section>
		</main>
	</div>
</body>
</html>
