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
				<button type="button">로그인</button>
			</div>
			<div>
				<input type="radio" name="customerOrEmpSel" id="customerOrEmpSel" value="customer" checked>customer
				<input type="radio" name="customerOrEmpSel" id="customerOrEmpSel" value="emp">emp
			</div>
		</div>
	</form>
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
			<button type="button">로그인</button>
		</div>
		<div>
			<input type="radio" name="customerOrEmpSel" id="customerOrEmpSel" value="customer" checked>customer
			<input type="radio" name="customerOrEmpSel" id="customerOrEmpSel" value="emp">emp
		</div>
	</div>
	<a href="${pageContext.request.contextPath}/out/addMember">회원가입</a>
</body>
</html>