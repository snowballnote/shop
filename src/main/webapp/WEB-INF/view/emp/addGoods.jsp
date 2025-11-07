<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>상품 등록 | Shop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/addGoods.css" />
</head>
<body>
  <div class="admin-layout">
    
    <!-- 왼쪽 메뉴 -->
    <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

    <!-- 오른쪽 콘텐츠 -->
    <main class="admin-content">
      <div class="page-center">
        <div class="form-wrap">
          <h2 class="form-title">상품 등록</h2>

          <!-- 서버 메시지 -->
          <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
          </c:if>

          <form method="post" action="${pageContext.request.contextPath}/emp/addGoods" autocomplete="off">
            <div class="input-row">
              <input type="text" name="goodsName" class="input" placeholder="상품명" required />
            </div>

            <div class="input-row">
              <input type="number" name="goodsPrice" class="input" placeholder="가격 (숫자만)" required />
            </div>

            <div class="input-row">
              <textarea name="goodsDesc" class="textarea" placeholder="상품 설명 (선택)"></textarea>
            </div>

            <button type="submit" class="btn">등록</button>

            <div class="link-row">
              <a href="${pageContext.request.contextPath}/emp/goodsList">← 목록으로</a>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</body>
</html>
