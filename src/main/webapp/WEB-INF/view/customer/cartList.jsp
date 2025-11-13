<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>cartList</h1>
	<c:import url="/WEB-INF/view/customer/customerHeader.jsp" />
	<form method="post" action="${pageContext.request.contextPath}/customer/addOrders">
		<table border="1">
		    <tr>
		        <th>선택</th>
		        <th>goodsName</th>
		        <th>goodsPrice</th>
		        <th>cartQuantity</th>
		        <th>totalPrice</th>
		        <th>soldout</th>
		    </tr>
		    <c:forEach var="m" items="${list}">
		        <tr> 
		            <td>
		                <c:if test="${m.soldout == 'soldout'}">
		                    soldout
		                </c:if>
		                <c:if test="${m.soldout != 'soldout'}">
		                    <input type="checkbox" name="cartCodeList" value="${m.cartCode}">
		                </c:if>
		            </td>
		            <td>${m.goodsName }</td>
		            <td>${m.goodsPrice }</td>
		            <td>
		                <c:if test="${m.soldout == 'soldout'}">
		                    soldout
		                </c:if>
		                <c:if test="${m.soldout != 'soldout'}">
		                    <input type="number" name="cartQuantityList" value="${m.cartQuantity }">
		                </c:if>
		            </td>
		            <td>${m.totalPrice }</td>
		            <td>${m.soldout }</td>
		        </tr>
		        
		   </c:forEach>
		</table>
		<button type="submit">주문하기</button>
	</form>
</body>
</html>