<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>배송지 관리 | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerMenu.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerAddress.css">
</head>
<body>

	<!-- 비로그인 보호 -->
	<c:if test="${empty sessionScope.loginCustomer}">
		<script>
			alert('로그인이 필요합니다.');
			location.href='${pageContext.request.contextPath}/out/login';
		</script>
	</c:if>

	<c:if test="${not empty sessionScope.loginCustomer}">
		<div class="customer-layout">
			<!-- 좌측: 고객 메뉴 (직원용으로 쓰려면 아래 라인을 empMenu.jsp로 변경) -->
			<jsp:include page="/WEB-INF/view/inc/customerMenu.jsp" />
			<%-- 직원용으로 쓰려면:
			     <jsp:include page="/WEB-INF/view/inc/empMenu.jsp" />
			--%>

			<!-- 우측: 본문 -->
			<main class="addr-content">
				<header class="addr-header">
					<h1>배송지 관리</h1>

					<div class="addr-actions">
						<c:set var="addrCount" value="${empty addressList ? 0 : fn:length(addressList)}" />
						<c:choose>
							<c:when test="${addrCount >= 5}">
								<button class="btn btn--primary" type="button" disabled title="최대 5개까지 등록 가능합니다.">
									+ 배송지 추가 (최대 5개)
								</button>
							</c:when>
							<c:otherwise>
								<a class="btn btn--primary" href="${pageContext.request.contextPath}/customer/addAddress">
									+ 배송지 추가
								</a>
							</c:otherwise>
						</c:choose>
						<div class="addr-cap">* 배송지는 최대 <strong>5개</strong>까지 등록 가능합니다.</div>
					</div>
				</header>

				<section>
					<c:choose>
						<c:when test="${empty addressList}">
							<div class="addr-empty">등록된 배송지가 없습니다. “배송지 추가” 버튼으로 새 주소를 등록해 주세요.</div>
						</c:when>
						<c:otherwise>
							<div class="addr-table-wrap">
								<table class="addr-table">
									<thead>
										<tr>
											<th>수령인</th>
											<th>연락처</th>
											<th>주소</th>
											<th>상세주소</th>
											<th>우편번호</th>
											<th>기본</th>
											<th>관리</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="a" items="${addressList}">
											<tr>
												<td>${a.receiverName}</td>
												<td>${a.receiverPhone}</td>
												<td>${a.address1}</td>
												<td>${a.address2}</td>
												<td>${a.zipCode}</td>
												<td>
													<c:choose>
														<c:when test="${a.isDefault == 'Y'}">
															<span class="badge badge--default">기본</span>
														</c:when>
														<c:otherwise>
															<a class="link"
															   href="${pageContext.request.contextPath}/customer/setDefaultAddress?addressCode=${a.addressCode}">
																기본으로 설정
															</a>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="addr-actions-cell">
													<a class="link" href="${pageContext.request.contextPath}/customer/editAddress?addressCode=${a.addressCode}">
														수정
													</a>
													<a class="link link--danger"
													   href="${pageContext.request.contextPath}/customer/removeAddress?addressCode=${a.addressCode}"
													   onclick="return confirm('해당 배송지를 삭제하시겠습니까?');">
														삭제
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
				</section>
			</main>
		</div>
	</c:if>
</body>
</html>
