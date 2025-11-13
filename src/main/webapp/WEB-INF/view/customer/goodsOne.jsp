<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 - ${goods.goodsName}</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/goodsOne.css">
</head>
<body>
    <c:import url="/WEB-INF/view/customer/customerHeader.jsp" />
    
    <div class="product-detail-container">
        <div class="goods-detail-wrap">
        
            <div class="product-image-area">
                <img src="${pageContext.request.contextPath}/upload/${goods.filename}" alt="${goods.goodsName}" class="main-product-image">
            </div>
            
            <div class="product-info-area">
                <form id="myForm">
                    <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}"> 
                    <input type="hidden" name="goodsCode" value="${goods.goodsCode}">
                    
                    <h1 class="product-name">${goods.goodsName}</h1>
                    <p class="product-price"><strong>${goods.goodsPrice}</strong> 원</p>
                    
                    <div class="info-divider"></div>

                    <div class="info-row">
                        <span class="info-label">💰 적립률</span>
                        <span class="info-content">${goods.pointRate} %</span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">📦 재고 상태</span>
                        <span class="info-content">
                            <c:choose>
                                <c:when test="${goods.soldout eq '1'}">
                                    <span class="soldout-status">품절 (SOLD OUT)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="stock-status in-stock">재고 있음 (IN STOCK)</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="info-divider"></div>
                    
                    <div class="info-row quantity-selector"> 
                        <span class="info-label">수량 선택</span>
                        <select name="cartQuantity" class="quantity-input"> 
                            <option value="1" selected>1</option> 
                            <c:forEach var="n" begin="2" end="10">
                                <option value="${n}">${n}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="info-divider"></div>

                    <div class="button-area button-group"> 
                        <button id="cartBtn" type="button" class="action-button add-to-cart-button">🛒 장바구니</button>
                        <button id="orderBtn" type="button" class="action-button buy-now-button">🛍️ 바로주문</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
	 // 장바구니 버튼 클릭 이벤트
	    $('#cartBtn').click(function(){
	        $('#myForm').attr('method', 'post');
	        // contextPath는 hidden input에서 가져옴
	        $('#myForm').attr('action', $('#contextPath').val() + '/customer/addCart'); 
	        
	        // console.log('장바구니 전송 준비: ' + $('#myForm').attr('action'));
	        $('#myForm').submit(); 
	    });
	    
	    // 바로주문 버튼 클릭 이벤트
	    $('#orderBtn').click(function(){
	        $('#myForm').attr('method', 'post');
	        // contextPath는 hidden input에서 가져옴
	        $('#myForm').attr('action', $('#contextPath').val() + '/customer/addOrders'); 
	        
	        // console.log('바로주문 전송 준비: ' + $('#myForm').attr('action'));
	        $('#myForm').submit(); 
	    });
    </script>
</body>
</html>