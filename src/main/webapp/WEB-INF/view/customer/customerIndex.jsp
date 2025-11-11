<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/customerIndex.css?v=20251110">
</head>
<body>
	<c:import url="/WEB-INF/view/customer/customerHeader.jsp" />
	
		<div class="customer-layout">
			<main class="customer-content">
			
				<section class="cx-section">
					<h2 class="cx-subtitle">Best Sellers</h2>
					<c:choose>
						<c:when test="${empty bestGoodsList}">
							<p class="cx-empty">베스트 상품이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table class="cx-grid" border="0" cellspacing="0" cellpadding="0">
								<tr> 
								<c:forEach var="b" items="${bestGoodsList}" varStatus="st" end="4"> 
									<td class="cx-card">
										<a class="cx-thumb" href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${b.goodsCode}">
											<%-- 💡 이미지 NULL 처리 적용 --%>
											<c:choose>
												<c:when test="${not empty b.filename}">
													<img src="${pageContext.request.contextPath}/upload/${b.filename}" alt="${fn:escapeXml(b.goodsName)}">
												</c:when>
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/static/img/default.png" alt="${fn:escapeXml(b.goodsName)}">
												</c:otherwise>
											</c:choose>
										</a>
										<!-- 이름가격 -->
										<div class="cx-info">
											<a class="cx-name" href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${b.goodsCode}">
												<c:out value="${b.goodsName}"/>
											</a>
											<div class="cx-price">
												<fmt:formatNumber value="${b.goodsPrice}" type="number"/>원
											</div>
										</div>
									</td>
								</c:forEach>
								</tr>
							</table>
						</c:otherwise>
					</c:choose>
				</section>

				<hr class="cx-sep">

				<section class="cx-section">
					<h2 class="cx-subtitle">Product List</h2>
					<c:choose>
						<c:when test="${empty goodsList}">
							<p class="cx-empty">등록된 상품이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<table class="cx-grid" border="0" cellspacing="0" cellpadding="0">
								<c:forEach var="m" items="${goodsList}" varStatus="state">
									<c:if test="${state.index % 5 == 0}">
										<tr>
									</c:if>

									<td class="cx-card">
										<a class="cx-thumb" href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${m.goodsCode}">
											
											<c:choose>
												<c:when test="${not empty m.filename}">
													<img src="${pageContext.request.contextPath}/upload/${m.filename}" alt="${fn:escapeXml(m.goodsName)}">
												</c:when>
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/static/img/default.png" alt="${fn:escapeXml(m.goodsName)}">
												</c:otherwise>
											</c:choose>
										</a>
										<div class="cx-info">
											<a class="cx-name" href="${pageContext.request.contextPath}/customer/goodsOne?goodsCode=${m.goodsCode}">
												<c:out value="${m.goodsName}"/>
											</a>
											<div class="cx-price">
												<fmt:formatNumber value="${m.goodsPrice}" type="number"/>원
											</div>
										</div>
									</td>

									<c:if test="${state.index % 5 == 4 || state.last}">
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</c:otherwise>
					</c:choose>
					
				</section>

				<%-- customerIndex.jsp 파일 내 페이징 출력 영역 --%>

				<div class="cx-paging">
				
				    <nav aria-label="Page navigation example" style="display: flex; justify-content: center;"> 
				        
				        <ul class="pagination">
				            
				            <%-- 1. 가장 처음 페이지로 가는 버튼 (<<) --%>
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <a class="page-link" href="<%=request.getContextPath()%>/customer/goodsList?currentPage=1" aria-label="First">
				                        <span aria-hidden="true">&laquo;</span> 
				                    </a>
				                </li>
				            </c:if>
				            
				            <%-- 2. 이전 페이지 블록으로 가는 버튼 (<) --%>
				            <c:if test="${startPage > 1}">
				                <li class="page-item">
				                    <a class="page-link" href="<%=request.getContextPath()%>/customer/goodsList?currentPage=${startPage - 1}" aria-label="Previous">
				                        <span aria-hidden="true">&lt;</span>
				                    </a>
				                </li>
				            </c:if>
				    
				            <%-- 3. 페이지 번호 출력 (1, 2, 3, ...) --%>
				            <c:forEach begin="${startPage}" end="${endPage}" var="i">
				                <%-- 현재 페이지일 경우 active 클래스 추가 --%>
				                <li class="page-item <c:if test="${i == currentPage}">active</c:if>">
				                    <a class="page-link" href="<%=request.getContextPath()%>/customer/goodsList?currentPage=${i}">${i}</a>
				                </li>
				            </c:forEach>
				            
				            <%-- 4. 다음 페이지 블록으로 가는 버튼 (>) --%>
				            <c:if test="${endPage < lastPage}">
				                <li class="page-item">
				                    <a class="page-link" href="<%=request.getContextPath()%>/customer/goodsList?currentPage=${endPage + 1}" aria-label="Next">
				                        <span aria-hidden="true">&gt;</span>
				                    </a>
				                </li>
				            </c:if>
				
				            <%-- 5. 가장 끝 페이지로 가는 버튼 (>>) --%>
				            <c:if test="${currentPage < lastPage}">
				                <li class="page-item">
				                    <a class="page-link" href="<%=request.getContextPath()%>/customer/goodsList?currentPage=${lastPage}" aria-label="Last">
				                        <span aria-hidden="true">&raquo;</span>
				                    </a>
				                </li>
				            </c:if>
				        </ul>
				        
				    </nav>
				    
				</div>
				
				<footer class="cx-footer">
					<small>© <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> Shop</small>
				</footer>
			</main>
		</div>
</body>
</html>