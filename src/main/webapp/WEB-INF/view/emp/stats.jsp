<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<button type="button" id="">특정년도의 월별 주문금액(누적) : 선 차트</button>
	<button type="button" id="">특정년도의 월별 주문수량 : 막대 차트</button>
	<button type="button" id="">특정년도의 월별 주문금액 : 막대 차트</button>
	<button type="button" id="">고객별 주문횟수 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="">고객별 총금액 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="">상품별 주문횟수 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="">상품별 주문금액 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="">성별 총주문 금액 : 파이차트</button>
	<button type="button" id="">성별 총주문 수량 : 파이차트</button>
	
	<div id = "chartOutput">
	</div>
</body>
</html>