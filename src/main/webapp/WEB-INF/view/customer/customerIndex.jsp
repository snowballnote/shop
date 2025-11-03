<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>고객 메인 페이지</h1>
	<div>
		${loginCustomer.customerName}님 반갑습니다.
		(point : ${loginCustomer.point})
		<a href="${pageContext.request.contextPath}/customer/customerLogout">로그아웃</a>
	</div>
</body>
</html>