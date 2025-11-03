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
    <p style="color:#999; margin-top:-4px; margin-bottom:24px;">회원 정보를 입력해 주세요.</p>

    <!-- 메시지 출력 -->
    <c:if test="${not empty msg}">
      <div class="msg">${msg}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/out/addCustomer">
      <!-- 아이디 -->
      <input type="text" name="id" id="id" class="input" placeholder="ID (4자 이상)" value="${param.id}" required>

      <!-- 비밀번호 -->
      <input type="password" name="pw" id="pw" class="input" placeholder="Password (4자 이상)" required>

      <!-- 비밀번호 확인 -->
      <input type="password" name="pw2" id="pw2" class="input" placeholder="Confirm Password" required>

      <!-- 이름 -->
      <input type="text" name="name" id="name" class="input" placeholder="Name" value="${param.name}" required>

      <!-- 전화번호 -->
      <input type="text" name="phone" id="phone" class="input" placeholder="010-0000-0000" value="${param.phone}" required>

      <!-- 버튼 -->
      <div style="margin-top:18px;">
        <button type="submit" class="btn">Sign Up</button>
      </div>
    </form>

    <div class="link-row">
      Already have an account?
      <a href="${pageContext.request.contextPath}/out/login"><em>Login</em></a>
    </div>
  </div>
</div>
<script> // 클라이언트(JS)에서도 같이 해서 UX 업그레이드
document.querySelector('form').addEventListener('submit', function(e) {
  const name = document.querySelector('#name').value.trim();
  const phone = document.querySelector('#phone').value.trim();

  const nameReg = /^[가-힣]{3,}$/;
  const phoneReg = /^[0-9]{10,11}$/;

  if (!nameReg.test(name)) {
    alert('이름은 한글로 3자 이상 입력해주세요.');
    document.querySelector('#name').focus();
    e.preventDefault();
    return;
  }

  if (!phoneReg.test(phone)) {
    alert('전화번호는 숫자만 입력하며 10~11자리여야 합니다.');
    document.querySelector('#phone').focus();
    e.preventDefault();
    return;
  }
});
</script>
</body>
</html>
