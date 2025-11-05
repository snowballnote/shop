<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>goodsList</h1>
	
	<!-- 왼쪽 메뉴 -->
    <c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
    <hr>
    
    <a href="${pageContext.request.contextPath}/emp/addGoods">상품추가</a>
</body>
</html>