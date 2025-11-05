<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>
	
	<form enctype="multipart/for-data" action="${pageContext.request.contextPath}/emp/addGoods" method="post" enctype="m">
		<table border="1">
			<tr>
				<td>goodsName</td>
				<td><input type="text" name="goodsName"></td>
			</tr>
			<tr>
				<td>goodsPrice</td>
				<td><input type="text" name="goodsPrice"></td>
			</tr>
			<tr>
				<td>pointRate</td>
				<td><td><input type="text" name="pointRate"></td></td>
			</tr>
			<tr>
				<td>goodsImg</td>
				<td><td><input type="file" name="goodsImg"></td></td>
			</tr>
		</table>
		<button type="submut">상품등록</button>
	</form>
</body>
</html>