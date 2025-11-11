<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Account | 개인 정보 관리</title>
    
    <%-- 🟢 최종 합의된 CSS 경로로 링크합니다. --%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/customerMenu.css">
</head>
<body>

    <c:import url="/WEB-INF/view/customer/customerHeader.jsp" />

    <div class="page-container">
        
        <h1 class="page-main-title">My Account</h1>
        
        <div class="content-wrap">
        
            <div class="menu-column">
                
                <div class="cp-box cp-col-left"> 
                    
                    <aside class="customer-menu">
                        
                        <div class="cm-welcome">
                            <c:if test="${not empty sessionScope.loginCustomer}">
                                <p class="cm-name"><strong>WELCOME</strong></p>
                                <p class="cm-line">${sessionScope.loginCustomer.customerName}</p>
                                <p class="cm-line cp-point">
                                    Points : <strong><fmt:formatNumber value="${sessionScope.loginCustomer.point}" /></strong>
                                </p>
                            </c:if>
                        </div>

                        <hr class="cm-sep">

                        <nav class="cm-links">
                        
                            <a href="${pageContext.request.contextPath}/customer/customerInfo"
                               class="${fn:contains(pageContext.request.requestURI, '/customer/customerInfo') ? 'is-active' : ''}">
                               	MY INFO
                            </a>

                            <a href="${pageContext.request.contextPath}/customer/addressList"
                               class="${fn:contains(pageContext.request.requestURI, '/customer/addressList') ? 'is-active' : ''}">
                                MANAGE ADDRESS
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/customer/addAddress"
                               class="${fn:endsWith(pageContext.request.requestURI, '/customer/addAddress') ? 'is-active' : ''}">
                                ADD ADDRESS
                            </a>

                            <a href="${pageContext.request.contextPath}/customer/cartList"
                               class="${fn:contains(pageContext.request.requestURI, '/customer/cartList') ? 'is-active' : ''}">
                                CART
                            </a>
                    	</nav>
                       	<a class="cm-logout"
                        	 href="${pageContext.request.contextPath}/customer/customerLogout">LOG OUT</a>
                    </aside>
                </div>
            </div>

            <div class="info-column">
                <div class="customer-main-content">
                    
                    <div class="account-title">회원 정보 수정/조회</div>
                    <p>현재 로그인된 사용자의 상세 정보를 표시하는 영역입니다.</p>
                    <p>이곳에 회원 정보 수정 폼이나 상세 정보를 표시하는 HTML 내용이 들어갑니다.</p>

                    <div class="account-title">Order History</div>
                    <p class="order-empty-message">You haven't placed any orders yet.</p>

                </div>
            </div>
            
        </div>
    </div>
    
</body>
</html>