<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>EMP | Shop Admin</title>
    <!-- 순서 중요: 공통 → 메뉴 → 페이지전용 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empIndex.css">
  </head>
  <body>
    <div class="admin-layout">
      <!-- 왼쪽 메뉴 -->
      <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

      <!-- 오른쪽 콘텐츠 -->
      <main class="admin-content">
        <header class="emp-header">
          <h1 class="page-title">직원 메인 페이지</h1>
          <div class="emp-user">
            <span class="emp-name">${loginEmp.empName}님 반갑습니다 👋</span>
            <a href="${pageContext.request.contextPath}/emp/empLogout" class="logout-btn">로그아웃</a>
          </div>
        </header>
		
        <!-- 필요 시 대시보드 카드 -->
        <!-- 
        <section class="emp-dashboard">
          <div class="emp-card">
            <h2>오늘의 주문</h2>
            <p class="num">${todayOrders}</p>
          </div>
          <div class="emp-card">
            <h2>대기중인 문의</h2>
            <p class="num">${pendingQuestions}</p>
          </div>
          <div class="emp-card">
            <h2>신규 리뷰</h2>
            <p class="num">${newReviews}</p>
          </div>
        </section>
        -->
      </main>
    </div>
  </body>
</html>
