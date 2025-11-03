<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>회원가입</h1>
	
	<!-- 실패 메시지 출력 -->
	<c:if test="${not empty idCheckMsg}">
  		<div class="msg ${idCheckResult ? 'ok' : 'err'}">${idCheckMsg}</div>
	</c:if>
	
	<form method="post" action="${pageContext.request.contextPath}/out/addCustomer">
		<table>
			<tr>
				<th>ID</th>
	      		<td>
					<input type="text" name="id" id="id" value="${param.id}" required>
				    <!-- 버튼: 동기 요청 -->
        			<button
					  type="submit"
					  formaction="${pageContext.request.contextPath}/out/addCustomerCheck"
					  formmethod="post"
					  formnovalidate>중복확인</button>
	     		</td>
	     	</tr>
	     	<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw" id="pw" required></td>
	     	</tr>
	     	<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="pw2" id="pw2" required></td>
	     	</tr>
	     	<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name" value="${param.name}" required></td>
	     	</tr>
	     	<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone" id="phone" value="${param.phone}" placeholder="010-0000-0000" required></td>
	     	</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
	<div style="margin-top:12px;">
  		<a href="${pageContext.request.contextPath}/out/login">로그인으로</a>
	</div>
</body>
</html>