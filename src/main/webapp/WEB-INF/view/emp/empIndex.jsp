<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>직원 메인 페이지</h1>
	<div>
		${loginEmp.empName}님 반갑습니다.
		<a href="${pageContext.request.contextPath}/emp/empLogout">로그아웃</a>
	</div>
</body>
</html>