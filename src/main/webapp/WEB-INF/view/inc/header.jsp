<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="r-header">
  <div class="r-header__inner">
    
    <!-- 브랜드 로고 -->
    <div class="r-brand">
      <a href="${pageContext.request.contextPath}/" class="r-logo">SHOP</a>
    </div>
    
    <!-- 오른쪽 네비게이션 -->
    <nav class="r-nav-right">
      <a href="${pageContext.request.contextPath}/out/login" class="r-icon emoji" title="Login">🔑</a>
      <a href="${pageContext.request.contextPath}/customer/mypage" class="r-icon emoji" title="My Page">👤</a>
      <a href="${pageContext.request.contextPath}/cart/list" class="r-icon emoji" title="Cart">🛒</a>
    </nav>

  </div>
</header>
