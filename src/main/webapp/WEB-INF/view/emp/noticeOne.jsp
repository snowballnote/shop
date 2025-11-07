<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>공지 상세보기 | Shop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empNoticeOne.css" />
</head>
<body>
<div class="admin-layout">
  <!-- 왼쪽 사이드 메뉴 -->
  <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

  <!-- 오른쪽 콘텐츠 -->
  <main class="admin-content">
    <div class="page-center">
      <div class="form-wrap">
        <h2 class="form-title">공지 상세보기</h2>

        <div class="input-row">
        	<div class="textarea" style="height:auto; min-height:120px;">
				<strong>제목: ${notice.noticeTitle}</strong>
				<strong>작성자: ${notice.empCode}</strong>
				${fn:escapeXml(notice.noticeContent)}
				등록일: ${notice.createdate}
			</div>
        </div>

        <!-- 버튼 -->
		<a class="btn" href="${pageContext.request.contextPath}/emp/modifyNotice?noticeCode=${notice.noticeCode}">수정</a>
		<a class="btn" style="background:#111; color:#fff; border:1.2px solid #111;" 
		   href="${pageContext.request.contextPath}/emp/deleteNotice?noticeCode=${notice.noticeCode}">
		   삭제
		</a>
		<div class="link-row">
		  <a href="${pageContext.request.contextPath}/emp/noticeList">← Back to List</a>
		</div>
    </div>
  </main>
</div>
</body>
</html>