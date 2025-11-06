<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>상품 등록 | Shop Admin</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empAddGoods.css">
</head>
<body>
	<div class="emp-layout">
		<!-- 왼쪽 메뉴 -->
		<jsp:include page="/WEB-INF/view/inc/empMenu.jsp" />

		<!-- 오른쪽 콘텐츠 -->
		<main class="emp-content">
			<header class="emp-header">
				<h1>상품 등록</h1>
				<a href="${pageContext.request.contextPath}/emp/goodsList" class="btn-back">← 상품 목록으로</a>
			</header>

			<section class="form-card">
				<form action="${pageContext.request.contextPath}/emp/addGoods" method="post" enctype="multipart/form-data" class="goods-form">
					<div class="form-group">
						<label for="goodsName">상품명</label>
						<input type="text" name="goodsName" id="goodsName" required>
					</div>

					<div class="form-group">
						<label for="goodsPrice">상품 가격</label>
						<input type="number" name="goodsPrice" id="goodsPrice" required>
					</div>

					<div class="form-group">
						<label for="pointRate">적립률 (%)</label>
						<input type="number" name="pointRate" id="pointRate" ㅡrequired>
					</div>

					<div class="form-group">
						<label for="goodsImg">상품 이미지</label>
						<input type="file" name="goodsImg" id="goodsImg" accept=".png, .jpg, .jpeg, .gif" required>
						<p class="file-note">png / jpg / gif 형식만 가능합니다.</p>
					</div>

					<div class="form-actions">
						<button type="submit" class="btn-submit">상품 등록</button>
					</div>
				</form>
			</section>
		</main>
	</div>
</body>
</html>
