<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Register | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/recess.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<div class="page-center">
		<div class="login-wrap">
			<h1 class="login-title">Register</h1>

			<!-- 서버측 메시지 (유효성 실패 등) -->
			<c:if test="${not empty msg}">
				<div class="msg" style="display:block;">${msg}</div>
			</c:if>

			<form
				method="post"
				action="${pageContext.request.contextPath}/out/addCustomer"
				autocomplete="off"
				id="customerForm">

				<!-- 아이디 -->
				<div class="input-row">
					<input
						type="text"
						name="id"
						id="id"
						class="input"
						placeholder="ID (4자 이상)"
						value="${empty id ? (empty param.id ? '' : param.id) : id}"
						required>
				</div>
				<div id="idMsg" class="msg" style="display:none;"></div>

				<!-- 비밀번호 -->
				<div class="input-row">
					<input
						type="password"
						name="pw"
						id="pw"
						class="input"
						placeholder="Password (4자 이상)"
						required>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="input-row">
					<input
						type="password"
						name="pw2"
						id="pw2"
						class="input"
						placeholder="Confirm Password"
						required>
				</div>

				<!-- 이름 -->
				<div class="input-row">
					<input
						type="text"
						name="name"
						id="name"
						class="input"
						placeholder="Name (한글 2자 이상)"
						value="${empty name ? (empty param.name ? '' : param.name) : name}"
						required>
				</div>
				<div id="nameMsg" class="msg" style="display:none;"></div>

				<!-- 전화번호 -->
				<div class="input-row">
					<input
						type="text"
						name="phone"
						id="phone"
						class="input"
						placeholder="01012345678 (숫자 10~11자리)"
						value="${empty phone ? (empty param.phone ? '' : param.phone) : phone}"
						required>
				</div>
				<div id="phoneMsg" class="msg" style="display:none;"></div>

				<!-- 버튼 -->
				<div style="margin-top:18px;">
					<button type="submit" class="btn" id="btnSubmit">Sign Up</button>
				</div>
			</form>

			<div class="link-row">
				Already have an account?
				<a href="${pageContext.request.contextPath}/out/login"><em>Login</em></a>
			</div>
		</div>
	</div>

	<script>
	// jQuery 버전: ID blur 시 /IdCk 로 AJAX 중복확인
	$(function(){
		const ctx = '${pageContext.request.contextPath}';

		const $id     = $('#id');
		const $idMsg  = $('#idMsg');
		const $name   = $('#name');
		const $nameMsg= $('#nameMsg');
		const $phone  = $('#phone');
		const $phoneMsg = $('#phoneMsg');

		const nameReg  = /^[가-힣]{2,}$/;
		const phoneReg = /^[0-9]{10,11}$/;

		function show($el, text){ $el.show().text(text); }
		function clear($el){ $el.hide().text(''); }

		// --- ID: 입력중 메시지 클리어 ---
		$id.on('input', function(){ clear($idMsg); });

		// --- ID: blur 시 중복확인 AJAX ---
		$id.on('blur', function(){
			const v = $.trim($id.val());
			if (v.length < 4) {
				show($idMsg, '아이디는 4자 이상이어야 합니다.');
				return;
			}
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

		// --- 이름: blur 간단 검증 (서버 검증은 반드시 유지) ---
		$name.on('input', function(){ clear($nameMsg); });
		$name.on('blur', function(){
			const v = $.trim($name.val());
			if (!nameReg.test(v)) show($nameMsg, '이름은 한글 2자 이상 입력해주세요.');
			else show($nameMsg, '사용 가능한 이름 형식입니다.');
		});

		// --- 전화: blur 간단 검증 (서버 검증은 반드시 유지) ---
		$phone.on('input', function(){ clear($phoneMsg); });
		$phone.on('blur', function(){
			const v = $.trim($phone.val());
			if (!phoneReg.test(v)) show($phoneMsg, '전화번호는 숫자 10~11자리로 입력해주세요.');
			else show($phoneMsg, '사용 가능한 전화번호 형식입니다.');
		});
	});
	</script>

</body>
</html>
