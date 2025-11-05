<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>직원 목록 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empList.css">
</head>
<body>
	<div class="emp-layout">
		<!-- 왼쪽 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>

		<!-- 오른쪽 콘텐츠 -->
		<main class="emp-content">
			<header class="emp-header">
				<h1>직원 목록</h1>
				<a href="${pageContext.request.contextPath}/emp/addEmp" class="btn-add">+ 사원 추가</a>
			</header>

			<section class="emp-table-wrap">
				<table class="emp-table">
					<thead>
						<tr>
							<th>사번</th>
							<th>아이디</th>
							<th>이름</th>
							<th>등록일</th>
							<th>상태</th>
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
									<a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&nextActive=${nextActive}&currentPage=${currentPage}"
									   class="status ${e.active == 1 ? 'active' : 'inactive'}">
										${e.active == 1 ? '활성화' : '비활성화'}
									</a>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty empList}">
							<tr>
								<td colspan="5" class="empty-msg">등록된 직원이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</section>

			<!-- 페이징 -->
			<div class="pagination">
				<c:if test="${currentPage > 1}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage - 1}" class="page-btn">이전</a>
				</c:if>

				<span class="page-info">${currentPage} / ${lastPage}</span>

				<c:if test="${currentPage < lastPage}">
					<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage + 1}" class="page-btn">다음</a>
				</c:if>
			</div>
		</main>
	</div>
</body>
</html>
