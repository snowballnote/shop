<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerMenu.css">

<aside class="customer-menu">
  <h2 class="cm-title">MY ACCOUNT</h2>

  <nav class="cm-links">
    <a href="${pageContext.request.contextPath}/customer/customerIndex"
       class="${fn:contains(pageContext.request.requestURI, '/customer/customerIndex') ? 'is-active' : ''}">
      Overview
    </a>

    <a href="${pageContext.request.contextPath}/customer/addressList"
       class="${fn:contains(pageContext.request.requestURI, '/customer/address') ? 'is-active' : ''}">
      Your Addresses
    </a>

    <a href=""
       class="${fn:contains(pageContext.request.requestURI, '/customer/wishlist') ? 'is-active' : ''}">
      Your Wishlist
    </a>

    <a href=""
       class="${fn:contains(pageContext.request.requestURI, '/order/list') ? 'is-active' : ''}">
      Order History
    </a>

    <a href="${pageContext.request.contextPath}/cart/list"
       class="${fn:contains(pageContext.request.requestURI, '/cart/list') ? 'is-active' : ''}">
      Cart
    </a>

    <a href="${pageContext.request.contextPath}/customer/profile"
       class="${fn:contains(pageContext.request.requestURI, '/customer/profile') ? 'is-active' : ''}">
      Edit Profile
    </a>

    <a href="${pageContext.request.contextPath}/customer/customerLogout">
      Log Out
    </a>
  </nav>
</aside>
