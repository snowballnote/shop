<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>상품 상세보기 | Shop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empGoodsOne.css" />
</head>
<body>
<div class="admin-layout">
  <!-- 왼쪽 사이드 메뉴 -->
  <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

  <!-- 오른쪽 콘텐츠 -->
  <main class="admin-content">
    <div class="page-center">
      <div class="form-wrap">
        <h2 class="form-title">상품 상세보기</h2>

        <div class="input-row">
          <div class="textarea" style="height:auto; min-height:120px;">
            <p><strong>상품코드:</strong> ${goods.goodsCode}</p>
            <p><strong>상품명:</strong> ${fn:escapeXml(goods.goodsName)}</p>
            <p><strong>가격:</strong> <fmt:formatNumber value="${goods.goodsPrice}" pattern="#,###" /> 원</p>
            <p><strong>재고:</strong> ${goods.stock} 개</p>
            <p><strong>등록일:</strong> ${goods.createdate}</p>
            <p><strong>수정일:</strong> ${goods.updatedate}</p>
            <hr/>
            <p><strong>상품 설명</strong></p>
            <div style="margin-top:8px;">${fn:escapeXml(goods.goodsContent)}</div>
          </div>
        </div>

        <!-- 버튼 -->
        <div class="btn-row" style="margin-top:15px;">
          <a class="btn" href="${pageContext.request.contextPath}/emp/modifyGoods?goodsCode=${goods.goodsCode}">수정</a>
          <a class="btn" style="background:#111; color:#fff; border:1.2px solid #111;" 
             href="${pageContext.request.contextPath}/emp/deleteGoods?goodsCode=${goods.goodsCode}">
             삭제
          </a>
        </div>

        <div class="link-row">
          <a href="${pageContext.request.contextPath}/emp/goodsList">← Back to List</a>
        </div>
      </div>
    </div>
  </main>
</div>
</body>
</html>
