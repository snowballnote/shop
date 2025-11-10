<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 고객 메뉴 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerMenu.css">

<!--
  파일명: /WEB-INF/view/inc/customerMenu.jsp
  용도  : 고객용 사이드 메뉴 (include 전용)
  주의  : HTML/BODY 태그 없음. 레이아웃 컨테이너 내 좌측 영역에 포함해서 사용.
-->

<aside class="customer-menu">

  <!-- 상단 환영 영역 -->
  <div class="cm-welcome">
    <c:if test="${not empty loginCustomer}">
      <p class="cm-name">
        <strong>${loginCustomer.customerName}</strong>님 반갑습니다.
      </p>
      <p class="cm-point">
        보유 포인트 :
        <strong><fmt:formatNumber value="${loginCustomer.point}" type="number"/></strong> P
      </p>
      <a class="cm-logout"
         href="${pageContext.request.contextPath}/customer/customerLogout">로그아웃</a>
    </c:if>
  </div>

  <!-- 구분선 -->
  <hr class="cm-sep">

  <!-- 메뉴 타이틀 -->
  <h2 class="cm-title">MY ACCOUNT</h2>

  <!-- 네비게이션 링크 -->
  <nav class="cm-links">

    <!-- 메인(상품 목록) -->
    <a href="${pageContext.request.contextPath}/customer/customerIndex"
       class="${fn:contains(pageContext.request.requestURI, '/customer/customerIndex') ? 'is-active' : ''}">
      상품 목록
    </a>

    <!-- 개인 정보 열ㄹ람
    	/ 폰번호수정
    	/ 비밀번호수정() - 트랜잭션 : customer 비밀번호 숮정 + pw_history 에 비밀번호 입력  => 꼭 일어나야함
    	/ 회원탈퇴() - 트랜잭션 : outid 입력 + customer 입력
     -->
    <a href="${pageContext.request.contextPath}/customer/customerInfo"
       class="${fn:contains(pageContext.request.requestURI, '/customer/customerInfo') ? 'is-active' : ''}">
      개인 정보
    </a>

    <!-- 배송지 관리 -->
    <a href="${pageContext.request.contextPath}/customer/addressList"
       class="${fn:contains(pageContext.request.requestURI, '/customer/addressList') ? 'is-active' : ''}">
      배송지 관리
    </a>
    <a href="${pageContext.request.contextPath}/customer/addAddress"
       class="${fn:endsWith(pageContext.request.requestURI, '/customer/addAddress') ? 'is-active' : ''}">
      배송지 추가
    </a>

    <!-- 장바구니 -->
    <a href="${pageContext.request.contextPath}/customer/cartList"
       class="${fn:contains(pageContext.request.requestURI, '/customer/cart') ? 'is-active' : ''}">
      장바구니
    </a>

  </nav>
</aside>
