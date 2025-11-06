<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>orderCode</th>
			<th>goodsName</th>
			<th>goodsPrice</th>
			<th>orderQuantity</th>
			<th>orderPrice</th>
			<th>customerName</th>
			<th>customerPhone</th>
			<th>address</th>
			<th>createdate</th>
			<th>orderState</th>
		</tr>
		<c:forEach var="m" items="${list }">
			<tr>
				<td>${m.orderCode}</td>
				<td>${m.goodsName}</td>
				<td>${m.goodsPrice}</td>
				<td>${m.orderQuantity}</td>
				<td>${m.orderPrice}</td>
				<td>${m.customerName}</td>
				<td>${m.customerPhone}</td>
				<td>${m.address}</td>
				<td>${m.createdate}</td>
				<td>${m.orderState}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>