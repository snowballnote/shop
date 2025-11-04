<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Add Employee | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/recess.css">
</head>
<body>

	<div class="page-center">
		<div class="login-wrap">
			<h1 class="login-title">Add Employee</h1>

			<!-- 서버 유효성 오류 메시지: 제목 바로 아래 노출 -->
			<c:if test="${not empty msg}">
				<div class="msg" style="margin-bottom:18px;">${msg}</div>
			</c:if>

			<form method="post" action="${pageContext.request.contextPath}/emp/addEmp" autocomplete="off" id="empForm">

				<!-- 아이디 -->
				<div class="input-row">
					<input type="text"
						   name="empId"
						   id="empId"
						   class="input"
						   placeholder="ID (4자 이상)"
						   value="${empty empId ? (empty param.empId ? '' : param.empId) : empId}"
						   required>
				</div>
				<!-- 아이디 중복확인 결과 메시지 (blur 시 자동 표기) -->
				<div id="empIdMsg" class="msg" style="display:none;"></div>

				<!-- 비밀번호 (보안상 value 바인딩 X) -->
				<div class="input-row">
					<input type="password"
						   name="empPw"
						   id="empPw"
						   class="input"
						   placeholder="Password (4자 이상)"
						   required>
				</div>

				<!-- 비밀번호 확인 (보안상 value 바인딩 X) -->
				<div class="input-row">
					<input type="password"
						   name="empPw2"
						   id="empPw2"
						   class="input"
						   placeholder="Confirm Password"
						   required>
				</div>

				<!-- 이름 -->
				<div class="input-row">
				  <input type="text" name="empName" id="empName" class="input"
				         placeholder="Name (한글 2자 이상)"
				         value="${empty empName ? (empty param.empName ? '' : param.empName) : empName}"
				         required>
				</div>
				<!-- 이름 유효성 결과 메시지 (blur 시 자동 표기) -->
				<div id="empNameMsg" class="msg" style="display:none;"></div> <!-- ← 이 줄 추가 -->

				<!-- 활성화 상태 -->
				<div class="input-row" style="margin-top:10px;">
					<label>
						<input type="radio" name="active" value="1"
							${param.active == '1' || empty param.active ? 'checked' : ''}> 활성화
					</label>
					<label style="margin-left:10px;">
						<input type="radio" name="active" value="0"
							${param.active == '0' ? 'checked' : ''}> 비활성화
					</label>
				</div>

				<!-- 등록 버튼 -->
				<div style="margin-top:18px;">
					<button type="submit" class="btn">Create</button>
				</div>
			</form>

			<div class="link-row">
				직원 목록으로 돌아가기<br>
				<a href="${pageContext.request.contextPath}/emp/empList"><em>Emp List</em></a>
			</div>
		</div>
	</div>
<script>
// 아이디 / 이름 입력 후 blur 시 자동 유효성 검사 (AJAX + 정규식)
(function(){
	const ctx       = '${pageContext.request.contextPath}';
	const empId     = document.querySelector('#empId');
	const idMsg     = document.querySelector('#empIdMsg');

	const empName   = document.querySelector('#empName');
	const nameMsg   = document.querySelector('#empNameMsg'); // ← 이름 메시지 영역(추가)

	let idTimer   = null,  idLastVal   = '';
	let nameTimer = null,  nameLastVal = '';

	// 공통 메시지 유틸
	function show(el, text){
		if(!el) return;
		el.style.display = 'block';
		el.textContent = text;
	}
	function clear(el){
		if(!el) return;
		el.style.display = 'none';
		el.textContent = '';
	}

	/* ===== ID 중복확인 ===== */
	empId.addEventListener('input', () => {
		clear(idMsg);
		if (idTimer) clearTimeout(idTimer);
	});

	empId.addEventListener('blur', () => {
		const v = empId.value.trim();
		if (v === idLastVal) return; // 같은 값 재요청 방지
		idLastVal = v;

		if (v.length < 4) {
			show(idMsg, '아이디는 4자 이상이어야 합니다.');
			return;
		}

		idTimer = setTimeout(async () => {
			try {
				const res = await fetch(ctx + '/emp/addEmp?action=checkId', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
						'X-Requested-With': 'XMLHttpRequest'
					},
					body: 'empId=' + encodeURIComponent(v)
				});
				const data = await res.json(); // { ok, exists, msg? }

				if (!data.ok) {
					show(idMsg, data.msg || '중복확인 실패');
					return;
				}
				if (data.exists) {
					show(idMsg, '이미 사용 중인 아이디입니다.');
					empId.focus();
				} else {
					show(idMsg, '사용 가능한 아이디입니다.');
				}
			} catch (err) {
				show(idMsg, '네트워크 오류가 발생했습니다.');
			}
		}, 200);
	});

	/* ===== 이름 유효성(한글 2자 이상) ===== */
	const nameReg = /^[가-힣]{2,}$/;

	empName.addEventListener('input', () => {
		clear(nameMsg);
		if (nameTimer) clearTimeout(nameTimer);
	});

	empName.addEventListener('blur', () => {
		const v = empName.value.trim();
		if (v === nameLastVal) return; // 같은 값 재검사 방지
		nameLastVal = v;

		nameTimer = setTimeout(() => {
			if (!nameReg.test(v)) {
				show(nameMsg, '이름은 한글 2자 이상 입력해주세요.');
				empName.focus();
			} else {
				show(nameMsg, '사용 가능한 이름 입니다.');
			}
		}, 150);
	});
})();
</script>

</body>
</html>