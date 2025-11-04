<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Add Employee | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/recess.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div class="page-center">
	<div class="login-wrap">
		<h1 class="login-title">Add Employee</h1>

		<c:if test="${not empty msg}">
			<div class="msg" style="display:block;">${msg}</div>
		</c:if>

		<form method="post" action="${pageContext.request.contextPath}/emp/addEmp" autocomplete="off" id="empForm">

			<!-- 아이디 -->
			<div class="input-row">
				<input type="text"
					   name="empId" id="empId" class="input"
					   placeholder="ID (4자 이상)"
					   value="${empty empId ? (empty param.empId ? '' : param.empId) : empId}"
					   required>
			</div>
			<div id="empIdMsg" class="msg" style="display:none;"></div>

			<!-- 비밀번호 -->
			<div class="input-row">
				<input type="password" name="empPw" id="empPw" class="input"
					   placeholder="Password (4자 이상)" required>
			</div>

			<!-- 비밀번호 확인 -->
			<div class="input-row">
				<input type="password" name="empPw2" id="empPw2" class="input"
					   placeholder="Confirm Password" required>
			</div>

			<!-- 이름 -->
			<div class="input-row">
				<input type="text" name="empName" id="empName" class="input"
					   placeholder="Name (한글 2자 이상)"
					   value="${empty empName ? (empty param.empName ? '' : param.empName) : empName}"
					   required>
			</div>
			<div id="empNameMsg" class="msg" style="display:none;"></div>

			<!-- 활성화 -->
			<div class="input-row" style="margin-top:10px;">
				<label><input type="radio" name="active" value="1"
					${(empty active && empty param.active) || (active==1) || (param.active=='1') ? 'checked' : ''}> 활성화</label>
				<label style="margin-left:10px;"><input type="radio" name="active" value="0"
					${(active==0) || (param.active=='0') ? 'checked' : ''}> 비활성화</label>
			</div>

			<div style="margin-top:18px;">
				<button type="submit" class="btn">Create</button>
			</div>
		</form>

		<div class="link-row">
			직원 목록으로 돌아가기
			<a href="${pageContext.request.contextPath}/emp/empList"><em>Emp List</em></a>
		</div>
	</div>
</div>

<script>
$(function(){
	const ctx = '${pageContext.request.contextPath}';

	const $id = $('#empId'), $idMsg = $('#empIdMsg');
	const $name = $('#empName'), $nameMsg = $('#empNameMsg');

	const nameReg = /^[가-힣]{2,}$/;
	function show($el, text){ $el.show().text(text); }
	function clear($el){ $el.hide().text(''); }

	// ID 입력중 메시지 클리어
	$id.on('input', function(){ clear($idMsg); });

	// IdCk 호출
	$id.on('blur', function(){
		const v = $.trim($id.val());
		if (v.length < 4) { show($idMsg, '아이디는 4자 이상이어야 합니다.'); return; }
		$.ajax({
			url: ctx + '/IdCk',
			type: 'POST',
			data: { id: v },
			dataType: 'json'
		}).done(function(data){
			if (!data || data.ok === false) {
				show($idMsg, (data && data.msg) ? data.msg : '중복확인 실패');
				return;
			}
			show($idMsg, data.exists ? '이미 사용 중인 아이디입니다.' : '사용 가능한 아이디입니다.');
		}).fail(function(){
			show($idMsg, '네트워크 오류가 발생했습니다.');
		});
	});

	// 이름 blur 간단 검증
	$name.on('input', function(){ clear($nameMsg); });
	$name.on('blur', function(){
		const v = $.trim($name.val());
		if (!nameReg.test(v)) show($nameMsg, '이름은 한글 2자 이상 입력해주세요.');
		else show($nameMsg, '사용 가능한 이름 형식입니다.');
	});
});
</script>
</body>
</html>
