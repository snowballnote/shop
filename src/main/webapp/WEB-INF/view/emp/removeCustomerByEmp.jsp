<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>강제 탈퇴 | Shop Admin</title>

    <!-- 기본 레이아웃 + 메뉴 + 통일 폼 스타일 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/removeCustomerByEmpForm.css" />
</head>
<body>
    <div class="admin-layout">
        
        <!-- 왼쪽 메뉴 -->
        <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

        <!-- 오른쪽 콘텐츠 -->
        <main class="admin-content">
            <div class="page-center">
                <div class="form-wrap">

                    <!-- 제목 -->
                    <h2 class="form-title">강제 탈퇴</h2>

                    <!-- 안내 문구 -->
                    <p class="confirm-text">
                        고객 ID <strong>${customerId}</strong> 계정을<br>
                        정말 <span class="warn">강제 탈퇴</span> 처리하시겠습니까?
                    </p>

                    <!-- 폼 -->
                    <form method="post" action="${pageContext.request.contextPath}/emp/removeCustomerByEmp" autocomplete="off">
                        <input type="hidden" name="customerId" value="${customerId}" />

                        <div class="input-row">
                            <textarea name="memo" class="textarea"
                                placeholder="탈퇴 사유 (선택)&#10;예: 부정 이용 의심, 본인 요청, 정책 위반 등"></textarea>
                        </div>

                        <button type="submit" class="btn">탈퇴 처리</button>

                        <div class="link-row">
                            <a href="${pageContext.request.contextPath}/emp/customerList">← Back to List</a>
                        </div>
                    </form>

                </div>
            </div>
        </main>

    </div>
</body>
</html>
