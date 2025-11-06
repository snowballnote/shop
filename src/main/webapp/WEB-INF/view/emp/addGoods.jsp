<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>상품 등록 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/addGoods.css">
</head>
<body>
	<div class="emp-layout">
		<!-- 사이드 메뉴 -->
		<c:import url="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 메인 콘텐츠 -->
		<main class="emp-content">
			<h1>상품 등록</h1>

			<form method="post"
				  action="${pageContext.request.contextPath}/emp/addGoods"
				  enctype="multipart/form-data"
				  class="emp-form">

				<label>상품명</label>
				<input type="text" name="goodsName" required maxlength="100">

				<label>상품 가격</label>
				<input type="number" name="goodsPrice" required min="0" step="1">

				<label>적립률 (%)</label>
				<input type="number" name="pointRate" required min="0" step="0.1">

				<label>상품 이미지</label>
				<input type="file" name="goodsImg" accept=".png,.jpg,.jpeg,.gif" required>

				<p class="hint">png / jpg / gif 형식만 가능합니다.</p>

				<button type="submit" class="btn-primary">상품 등록</button>
			</form>

			<c:if test="${not empty msg}">
				<div class="form-msg">${msg}</div>
			</c:if>
		</main>
	</div>
</body>
</html>
