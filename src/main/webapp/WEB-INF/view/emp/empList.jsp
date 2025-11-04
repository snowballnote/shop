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
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
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
		 				<a href="${pageContext.request.contextPath}/emp/modifyEmpActive?empCode=${e.empCode}&currentActive=${e.active}"></a><!-- 버튼 클릭시 비활성화 활성화 시키기. -->
		 				${e.active == 0 ? '비활성화' : '활성화'}
		 			</td>
		 		</tr>
		 	</c:forEach>
		 </table>
		 <!-- 
		 <div>
		 	<a href="">[이전]</a>
		 	${page }
		 	<a href="">[다음]</a>
		 </div>
		  -->
	</div>
</body>
</html>