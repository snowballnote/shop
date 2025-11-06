<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Add Employee | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/addEmp.css?v=20251107">
</head>
<body>

	<div class="page-center">
		<div class="form-wrap">
			<h1 class="form-title">Add Employee</h1>

			<!-- 서버 메시지 -->
			<c:if test="${not empty msg}">
				<div class="msg" style="display:block;">${msg}</div>
			</c:if>

			<form method="post" action="${pageContext.request.contextPath}/emp/addEmp" autocomplete="off" id="empForm">
				<div class="input-row">
					<input type="text"
						   name="empId"
						   id="empId"
						   class="input"
						   placeholder="Employee ID (4자 이상)"
						   value="${empty param.empId ? '' : param.empId}"
						   required>
				</div>

				<div class="input-row">
					<input type="password"
						   name="empPw"
						   id="empPw"
						   class="input"
						   placeholder="Password (8자 이상)"
						   required>
				</div>

				<div class="input-row">
					<input type="password"
						   name="empPw2"
						   id="empPw2"
						   class="input"
						   placeholder="Confirm Password"
						   required>
				</div>

				<div class="input-row">
					<input type="text"
						   name="empName"
						   id="empName"
						   class="input"
						   placeholder="Name (한글/영문 2자 이상)"
						   value="${empty param.empName ? '' : param.empName}"
						   required>
				</div>

				<button type="submit" class="btn">Create</button>
			</form>

			<div class="link-row">
				<a href="${pageContext.request.contextPath}/emp/empList">← Back to List</a>
			</div>
		</div>
	</div>

	<script>
		// 가벼운 프론트 유효성 (서버 검증은 반드시 유지)
		(function () {
			const empForm = document.getElementById('empForm');
			const empId   = document.getElementById('empId');
			const pw      = document.getElementById('empPw');
			const pw2     = document.getElementById('empPw2');
			const name    = document.getElementById('empName');

			empForm.addEventListener('submit', function (e) {
				if (empId.value.trim().length < 4) {
					alert('ID는 4자 이상 입력해 주세요.');
					empId.focus();
					e.preventDefault();
					return;
				}
				if (pw.value.length < 8) {
					alert('비밀번호는 8자 이상으로 입력해 주세요.');
					pw.focus();
					e.preventDefault();
					return;
				}
				if (pw.value !== pw2.value) {
					alert('비밀번호가 일치하지 않습니다.');
					pw2.focus();
					e.preventDefault();
					return;
				}
				if (name.value.trim().length < 2) {
					alert('이름은 2자 이상 입력해 주세요.');
					name.focus();
					e.preventDefault();
				}
			});
		})();
	</script>
</body>
</html>
