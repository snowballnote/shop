<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerHeader.css">

<header class="chd">
  <!-- 좌측: 1차 내비 (SHOP, ABOUT) -->
  <nav class="chd-left" aria-label="Primary">
    <a href="${pageContext.request.contextPath}/customer/customerIndex"
       class="chd-link ${fn:contains(pageContext.request.requestURI, '/customer/customerIndex') ? 'is-active' : ''}">
      SHOP
    </a>
    <a href="${pageContext.request.contextPath}/about"
       class="chd-link ${fn:contains(pageContext.request.requestURI, '/about') ? 'is-active' : ''}">
      ABOUT
    </a>
  </nav>

  <!-- 중앙: 브랜드 -->
  <h1 class="chd-brand">
    <a href="${pageContext.request.contextPath}/customer/customerIndex" aria-label="Home">PHARMACY</a>
  </h1>

  <!-- 우측: 아이콘들 (검색, 계정, 장바구니) -->
  <nav class="chd-right" aria-label="Utilities">
    <!-- 검색 아이콘 (UI만) -->
    <button type="button" class="chd-iconbtn" aria-label="Search">
      <svg viewBox="0 0 24 24" class="chd-ico" aria-hidden="true">
        <circle cx="11" cy="11" r="7" fill="none" stroke="currentColor" stroke-width="2"/>
        <line x1="16.5" y1="16.5" x2="21" y2="21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
      </svg>
    </button>

    <!-- 계정: 로그인 여부에 따라 링크 분기 -->
    <c:choose>
      <c:when test="${empty sessionScope.loginCustomer}">
        <a class="chd-iconbtn" href="${pageContext.request.contextPath}/out/login" aria-label="Account">
          <svg viewBox="0 0 24 24" class="chd-ico" aria-hidden="true">
            <circle cx="12" cy="8" r="3" fill="none" stroke="currentColor" stroke-width="2"/>
            <path d="M4 20c0-4 4-6 8-6s8 2 8 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
          </svg>
        </a>
      </c:when>
      <c:otherwise>
        <a class="chd-iconbtn" href="${pageContext.request.contextPath}/customer/customerInfo" aria-label="Account">
          <svg viewBox="0 0 24 24" class="chd-ico" aria-hidden="true">
            <circle cx="12" cy="8" r="3" fill="none" stroke="currentColor" stroke-width="2"/>
            <path d="M4 20c0-4 4-6 8-6s8 2 8 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
          </svg>
        </a>
      </c:otherwise>
    </c:choose>

    <!-- 인사 텍스트 (로그인 시) -->
    <c:if test="${not empty sessionScope.loginCustomer}">
      <span class="chd-hi">Hi, <c:out value="${sessionScope.loginCustomer.customerName}"/></span>
    </c:if>

    <!-- 장바구니 -->
    <a class="chd-iconbtn" href="${pageContext.request.contextPath}/customer/cartList" aria-label="Cart">
      <svg viewBox="0 0 24 24" class="chd-ico" aria-hidden="true">
        <path d="M6 8h12l-1 12H7L6 8Z" fill="none" stroke="currentColor" stroke-width="2"/>
        <path d="M9 8V6a3 3 0 0 1 6 0v2" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
      </svg>
    </a>
  </nav>
</header>
