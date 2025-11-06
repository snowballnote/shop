<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<!-- 왼쪽 메뉴 -->
      <c:import url="/WEB-INF/view/inc/customerMenu.jsp" />
      <hr>
      
      <div>
      	<a href="${pageContext.request.contextPath}/customer/addAddress">[배송ㅈ지추가]</a>
      	<!-- 배송지 최대 5개: 6번째 이ㅏㅂ력시 가장 오ㄹ래된 -->
      </div>
</body>
</html>