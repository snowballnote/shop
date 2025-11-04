<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Register | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/recess.css">
</head>
<body>

	<div class="page-center">
		<div class="login-wrap">
			<h1 class="login-title">Register</h1>

			<!-- 서버 유효성 오류 메시지: 제목 바로 아래 -->
			<c:if test="${not empty msg}">
				<div class="msg" style="margin-bottom:18px;">${msg}</div>
			</c:if>

			<form method="post"
				  action="${pageContext.request.contextPath}/out/addCustomer"
				  autocomplete="off"
				  id="customerForm">

				<!-- 아이디 -->
				<div class="input-row">
					<input type="text"
						   name="id"
						   id="id"
						   class="input"
						   placeholder="ID (4자 이상)"
						   value="${empty id ? (empty param.id ? '' : param.id) : id}"
						   required>
				</div>
				<div id="idMsg" class="msg" style="display:none;"></div>

				<!-- 비밀번호 (보안상 value 바인딩 X) -->
				<div class="input-row">
					<input type="password"
						   name="pw"
						   id="pw"
						   class="input"
						   placeholder="Password (4자 이상)"
						   required>
				</div>

				<!-- 비밀번호 확인 (보안상 value 바인딩 X) -->
				<div class="input-row">
					<input type="password"
						   name="pw2"
						   id="pw2"
						   class="input"
						   placeholder="Confirm Password"
						   required>
				</div>

				<!-- 이름 -->
				<div class="input-row">
					<input type="text"
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
					<input type="text"
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
	// ID / 이름 / 전화 blur 검사 + ID 중복확인(AJAX)
	(function(){
		const ctx      = '${pageContext.request.contextPath}';

		const idEl     = document.querySelector('#id');
		const idMsg    = document.querySelector('#idMsg');

		const nameEl   = document.querySelector('#name');
		const nameMsg  = document.querySelector('#nameMsg');

		const phoneEl  = document.querySelector('#phone');
		const phoneMsg = document.querySelector('#phoneMsg');

		const form     = document.querySelector('#customerForm');

		let idTimer=null,   idLast='';
		let nmTimer=null,   nmLast='';
		let phTimer=null,   phLast='';

		function show(el, text){ el.style.display='block'; el.textContent=text; }
		function clear(el){ el.style.display='none'; el.textContent=''; }

		/* ===== ID 중복확인 (blur + AJAX) ===== */
		idEl.addEventListener('input', () => { clear(idMsg); if(idTimer) clearTimeout(idTimer); });
		idEl.addEventListener('blur', () => {
			const v = idEl.value.trim();
			if (v === idLast) return;
			idLast = v;

			if (v.length < 4) { show(idMsg, '아이디는 4자 이상이어야 합니다.'); return; }

			idTimer = setTimeout(async () => {
				try {
					const res = await fetch(ctx + '/out/addCustomer?action=checkId', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
							'X-Requested-With': 'XMLHttpRequest'
						},
						body: 'id=' + encodeURIComponent(v)
					});
					const data = await res.json(); // { ok, exists, msg? }
					if (!data.ok) { show(idMsg, data.msg || '중복확인 실패'); return; }
					if (data.exists) { show(idMsg, '이미 사용 중인 아이디입니다.'); idEl.focus(); }
					else { show(idMsg, '사용 가능한 아이디입니다.'); }
				} catch (e) {
					show(idMsg, '네트워크 오류가 발생했습니다.');
				}
			}, 200);
		});

		/* ===== 이름 유효성 (한글 2자 이상) ===== */
		const nameReg = /^[가-힣]{2,}$/;
		nameEl.addEventListener('input', () => { clear(nameMsg); if(nmTimer) clearTimeout(nmTimer); });
		nameEl.addEventListener('blur', () => {
			const v = nameEl.value.trim();
			if (v === nmLast) return;
			nmLast = v;

			nmTimer = setTimeout(() => {
				if (!nameReg.test(v)) { show(nameMsg, '이름은 한글 2자 이상 입력해주세요.'); nameEl.focus(); }
				else { show(nameMsg, '사용 가능한 이름 형식입니다.'); }
			}, 150);
		});

		/* ===== 전화 유효성 (숫자 10~11자리) ===== */
		const phoneReg = /^[0-9]{10,11}$/;
		phoneEl.addEventListener('input', () => { clear(phoneMsg); if(phTimer) clearTimeout(phTimer); });
		phoneEl.addEventListener('blur', () => {
			const v = phoneEl.value.trim();
			if (v === phLast) return;
			phLast = v;

			phTimer = setTimeout(() => {
				if (!phoneReg.test(v)) { show(phoneMsg, '전화번호는 숫자 10~11자리로 입력해주세요.'); phoneEl.focus(); }
				else { show(phoneMsg, '사용 가능한 전화번호 형식입니다.'); }
			}, 150);
		});

	})();
	</script>

</body>
</html>
