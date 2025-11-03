<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>shop</title>
</head>
<body>
	<h1>login</h1>
	<form method="post" action="${pageContext.request.contextPath}/out/login">
		<div>
			<div>
				<table>
					<tr>
						<td>id</td>
						<td><input type="text" name="id" id="id"></td>
					</tr>
					<tr>
						<td>pw</td>
						<td><input type="password" name="pw" id="pw"></td>
					</tr>
				</table>
				<button type="submit">로그인</button>
			</div>
			<div style="margin:8px 0">
        		<input type="radio" name="customerOrEmpSel" id="selCustomer" value="customer"
               		<c:if test="${empty param.customerOrEmpSel or param.customerOrEmpSel == 'customer'}">checked</c:if>>
        		<label for="selCustomer">customer</label>

        		<input type="radio" name="customerOrEmpSel" id="selEmp" value="emp"
               		<c:if test="${param.customerOrEmpSel == 'emp'}">checked</c:if>>
        		<label for="selEmp">emp</label>
      		</div>
		</div>
	</form>
	<a href="${pageContext.request.contextPath}/out/addCustomer">회원가입</a>
</body>
</html>