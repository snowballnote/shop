<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Login | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css">
</head>
<body>
	<div class="login-page">
		<div class="login-wrap">
			<h1 class="login-title">Login</h1>

			<c:if test="${not empty loginMsg}">
				<div class="msg" style="display:block;">${loginMsg}</div>
			</c:if>

			<form id="loginForm" method="post" action="${pageContext.request.contextPath}/out/login" autocomplete="off">
				<div class="role-row" style="justify-content:center; margin-bottom:18px;">
					<label>
						<input type="radio" name="customerOrEmpSel" id="selCustomer" value="customer" checked
							<c:if test="${empty param.customerOrEmpSel or param.customerOrEmpSel == 'customer'}">checked</c:if>>
						Customer
					</label>
					<label>
						<input type="radio" name="customerOrEmpSel" id="selEmp" value="emp" 
							<c:if test="${param.customerOrEmpSel == 'emp'}">checked</c:if>>
						Employee
					</label>
				</div>

				<div class="input-row">
					<input value="customer1" type="text" name="id" id="id" class="input" placeholder="ID">
				</div>
				<div class="input-row">
					<input value="1234" type="password" name="pw" id="pw" class="input" placeholder="Password">
				</div>

				<button type="submit" class="btn">Sign In</button>
			</form>

			<div class="link-row">
				or <em><a href="${pageContext.request.contextPath}/out/addCustomer">Register</a></em>
			</div>
			<a class="underline-link" href="">Forgot your password?</a>
		</div>
	</div>
</body>
</html>
