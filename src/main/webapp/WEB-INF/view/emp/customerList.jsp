<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>CUSTOMER 목록 | Shop Admin</title>
	<!-- 순서 중요: 공통 → 메뉴 → 페이지전용 -->
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
				<h1 class="page-title">고객 관리</h1>
				<div class="header-actions">
					<a class="btn btn--dark" href="${pageContext.request.contextPath}/emp/outidList">탈퇴 ID 관리</a>
				</div>
			</header>
			
			<section>
				<table class="r-table">
					<thead>
						<tr>
							<th>customerCode</th>
							<th>customerId</th>
							<th>customerName</th>
							<th>phone</th>
							<th>point</th>
							<th>createdate</th>
							<th>주문</th>
							<th>강제탈퇴</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${customerList}">
							<tr>
								<td>${c.customerCode}</td>
								<td>${c.customerId}</td>
								<td>${c.customerName}</td>
								<td>${c.customerPhone}</td>
								<td>${c.point}</td>
								<td>${c.createdate}</td>
								<td style="text-align:center;">
									<a class="page-btn"
										href="${pageContext.request.contextPath} /emp/customerOrders?customerCode=${c.customerCode}&currentPage=${currentPage}">
										주문 보기
									</a>
								</td>
								<td>
									<a class="page-btn page-btn--danger"
										href="${pageContext.request.contextPath}/emp/removeCustomerByEmp?customerId=${c.customerId}&currentPage=${currentPage}">
										강제탈퇴
									</a>
								</td>
							</tr>
						</c:forEach>
						
						<c:if test="${empty customerList}">
							<tr>
								<td>
									데이터가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				
				<!-- 페이징 -->
				<div class="pager">
					<c:if test="${currentPage > 1}">
						<a class="page-btn"
							href="${pageContext.request.contextPath}/emp/customerList?currentPage=${currentPage - 1}">
							이전
						</a>
					</c:if>
					
					<span class="page-info">${currentPage} / ${lastPage}</span>
					
					<c:if test="${currentPage < lastPage}">
						<a class="page-btn"
						   href="${pageContext.request.contextPath}/emp/customerList?currentPage=${currentPage + 1}">
							다음
						</a>
					</c:if>
				</div>
			</section>
		</main>
	</div>
</body>
</html>