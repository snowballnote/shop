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
	
	<c:import url="/WEB-INF/view/customer/customerHeader.jsp" />
	
	<div>
		<form method="post" action="${pageContext.request.contextPath}/customer/addOrders">
			
            <table border="1">
				<tr>
					<th>이미지</th>
					<th>상품명</th>
					<th>단가</th>
					<th>적립률</th>
					<th>수량</th>
				</tr>
				<c:forEach var="m" items="${list}">
					<input type="hidden" name="goodsCodeList" value="${m.goodsCode}">
					<input type="hidden" name="OrderQuantityList" value="${m.cartQuantity}">
					<input type="hidden" name="goodsPriceList" value="${m.goodsPrice}">
					<tr>
						<td><img src="${pageContext.request.contextPath}/upload/${m.filename}" width="100px"></td>
						<td>${m.goodsName}</td>
						<td>${m.goodsPrice}</td>
						<td>${m.pointRate}</td>
						<td>${m.cartQuantity}</td>
					</tr>
				</c:forEach>
			</table>
            
            <div>
				<h3>배송지 선택:</h3>
				<select id="addressList" size="5">	
					<c:forEach var="addr" items="${addressList}">
						<option class="addrOpt" value="${addr.addressCode}">${addr.address}</option>
					</c:forEach>
				</select>
			</div>
            
			<div>
                <input type="text" id="addressCode" name="addressCode" readonly placeholder="선택된 주소 코드">
				<input type="text" id="address" readonly placeholder="선택된 주소 전체">
			</div>
            
            <div>
				<div>
					결제금액 :
                    <input type="number" name="orderPrice" value="${orderPrice}" readonly>
				</div>
			</div>
			<div>
				<button type="submit">결제하기(주문완료)</button>
			</div>
		</form>
	</div>
	
	<script>
		$(document).ready(function() {
            // 1. 페이지 로드 시 첫 번째 주소 선택 (사용자 편의성)
            var firstOption = $('#addressList option:first');
            if(firstOption.length) {
                $('#addressCode').val(firstOption.val());
                $('#address').val(firstOption.text());
                firstOption.prop('selected', true);
            }
            
            // 2. 주소 리스트에서 항목 더블 클릭 이벤트
			$('#addressList').dblclick(function(){
                // 현재 선택된 option을 정확하게 찾습니다.
				var selectedOption = $(this).find('option:selected'); 
                
                // 선택된 주소의 value (addressCode)와 text (주소 전체)를 input 필드에 채웁니다.
				$('#addressCode').val(selectedOption.val()); 
				$('#address').val(selectedOption.text());
			});
            
            // 3. (옵션) select 박스에서 enter 키를 눌렀을 때도 dblclick과 동일하게 작동하도록 처리할 수도 있습니다.
            $('#addressList').on('keypress', function(e) {
                if (e.which === 13) { // Enter 키 코드
                    e.preventDefault();
                    $(this).find('option:selected').trigger('dblclick');
                }
            });
            
		});
	</script>
</body>
</html>