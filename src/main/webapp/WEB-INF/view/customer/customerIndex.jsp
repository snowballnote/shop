<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>My Account | Shop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerIndex.css">
</head>
<body>

  <!-- 비로그인 가드 -->
  <c:if test="${empty sessionScope.loginCustomer}">
    <script>
      alert('로그인이 필요합니다.');
      location.href='${pageContext.request.contextPath}/out/login';
    </script>
  </c:if>

  <c:if test="${not empty sessionScope.loginCustomer}">
    <!-- 상단 타이틀 (센터) -->
    <header class="cx-header">
      <h1>My Account</h1>
    </header>

    <main>
    	<div>
    		님 반갑습니다.
    		(point)
    	</div>
    	
    	<h2> 베스트 상품 목록</h2>
    	<!-- 베스트 : 가장 많이 주문(주문완료)된 상품 5개 -->
    	<div>
    		베스트상품5개
    		${bestGoodsList}
    	</div>
    	
    	<hr>
    	
    	<h2>상품목록</h2>
    	<div>
    		<table border="1" width="100%">
			    <c:forEach var="m" items="${goodsList}" varStatus="state">
			        <c:if test="${state.index % 5 == 0}">
			            <tr>
			        </c:if>
			
			        <td align="center" valign="top">
			            <!-- 이미지 출력 -->
			            <div>
			                <img src="${pageContext.request.contextPath}/upload/${m.filename}" width="100" height="100" alt="상품 이미지">
			            </div>
			            <!-- 상품명 및 가격 -->
			            <div>
			                ${m.goodsName}<br>
			                ${m.goodsPrice}원
			            </div>
			        </td>
			
			        <c:if test="${state.index % 5 == 4 || state.last}">
			            </tr>
			        </c:if>
			    </c:forEach>
			</table>
    	</div>
    </main>

    <!-- 푸터 -->
    <footer class="cx-footer">
      <small>© <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> Shop</small>
    </footer>
  </c:if>

</body>
</html>
