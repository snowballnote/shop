<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/goodsOne.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/view/customer/customerHeader.jsp" />
	
	<div class="page-container">
	    <div class="goods-detail-wrap">
	    
	        <div class="img-area">
				<img src="${pageContext.request.contextPath}/upload/${goods.filename}" alt="${goods.goodsName}">
			</div>
			
			<div class="info-area">
				<form id="myForm">
					<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}"> 
					<input type="hidden" name="goodsOne" value="${goods.goodsCode}">
					
					<table class="goods-info-table">
						<tr>
							<td>상품명</td>
							<td>
								<input type="text" value="${goods.goodsName}" id="goodsName" name="goodsName" readonly>
							</td>
						</tr>
						<tr>
							<td>판매가</td>
							<td>${goods.goodsPrice} 원</td>
						</tr>
						<tr>
							<td>적립률</td>
							<td>${goods.pointRate} %</td>
						</tr>
						<tr>
							<td>품절 여부</td>
							<td>
							    <c:choose>
							        <c:when test="${goods.soldout eq '1'}">
							            <span class="soldout-status">품절 (SOLD OUT)</span>
							        </c:when>
							        <c:otherwise>
							            <span class="stock-status">재고 있음 (IN STOCK)</span>
							        </c:otherwise>
							    </c:choose>
							</td>
						</tr>
						<tr class="quantity-row"> 
    <td>수량</td>
    <td>
        <select name="quantity"> 
            <c:forEach var="n" begin="1" end="10">
                <option value="${n}">${n}</option>
            </c:forEach>
        </select>
    </td>
</tr>
					</table>
					
					<div class="button-group">
					    <button id="cartBtn" type="button">장바구니</button><button id="orderBtn" type="button">바로주문</button></div>
				</form>
			</div>
		</div>
	</div>
	<script>
		// jQuery를 사용하기 위해 <head>에 script src 링크가 있는지 확인하세요.
		
		$('#cartBtn').click(function(){
			$('#myForm').attr('method', 'post');
			// 🚨 컨텍스트 경로를 hidden input이 아닌 id로 가져와서 사용하도록 수정
			$('#myForm').attr('action', $('#contextPath').val() + '/customer/addCart');
			
			alert('cartBtn: ' + $('#myForm').attr('method') + ',' + $('#myForm').attr('action'));
			// $('#myForm').submit(); // 실제 전송 시 주석 해제
		});
		
		$('#orderBtn').click(function(){
			$('#myForm').attr('method', 'get');
			// 🚨 컨텍스트 경로를 hidden input이 아닌 id로 가져와서 사용하도록 수정
			$('#myForm').attr('action', $('#contextPath').val() + '/customer/insertOrder');
			
			alert('orderBtn: ' + $('#myForm').attr('method') + ',' + $('#myForm').attr('action')); 
			// $('#myForm').submit(); // 실제 전송 시 주석 해제
		});
	</script>
</body>
</html>