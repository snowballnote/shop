<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>empList</h1>
	<!-- emp menu include -->
	<jsp:include page="/WEB-INF/view/inc/header.jsp" />
	<jsp:include page="/WEB-INF/view/inc/empMenu.jsp" />
	<hr>
	
	<div>
		<!-- 
			1) 리스트
			2) (비)활성화
			3) 추가
		 -->
		 ${empList.size()}
		 <a href="${pageContext.request.contextPath}/emp/addEmp">사원추가</a>
		 <table border="1">
		 	<tr>
		 		<td>empCode</td>
		 		<td>empId</td>
		 		<td>empName</td>
		 		<td>createdate</td>
		 		<td>활성화/비활성화</td>
		 	</tr>
		 	
		 	<c:forEach var="e" items="${empList}">
				<tr>
					<td>${e.empCode}</td>
					<td>${e.empId}</td>
					<td>${e.empName}</td>
					<td>${e.createdate}</td>
					<td>
						<c:set var="nextActive" value="${e.active == 1 ? 0 : 1}" />
						<a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&nextActive=${nextActive}&currentPage=${currentPage}">
							${e.active == 1 ? '활성화' : '비활성화'}
						</a>
					</td>
				</tr>
			</c:forEach>
		 </table>
		 <div>
		 	<!-- 이전 페이지로 이동 -->
		 	<c:if test="${currentPage > 1}">
				<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage - 1}">[이전]</a>
			</c:if>

			<!-- 현재 페이지 / 마지막 페이지 표시 -->
			<span>${currentPage} / ${lastPage}</span>

			<!-- 다음 페이지로 이동 -->
			<c:if test="${currentPage < lastPage}">
				<a href="${pageContext.request.contextPath}/emp/empList?currentPage=${currentPage + 1}">[다음]</a>
			</c:if>
		</div>
	</div>
</body>
</html>