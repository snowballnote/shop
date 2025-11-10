<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보</title>
    
    <%-- 여기에 CSS 파일 링크를 추가하세요 --%>
    
    <style>
        /* CSS 파일에 정의될 레이아웃 스타일 (Flexbox를 사용한 2단 분할) */
        .page-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .content-wrap {
            display: flex; /* Flexbox로 메뉴와 컨텐츠를 나란히 배치 */
            padding-top: 20px;
        }
        .menu-column {
            flex-shrink: 0; 
            width: 200px; /* 메뉴 컬럼 너비 설정 */
            padding-right: 20px;
        }
        .info-column {
            flex-grow: 1; 
            padding-left: 20px; /* 컨텐츠 컬럼 왼쪽 패딩 */
        }
    </style>
</head>
<body>

    <c:import url="/WEB-INF/view/customer/customerHeader.jsp" />

    <div class="page-container">
        <div class="content-wrap">
        
            <div class="menu-column">
                <c:import url="/WEB-INF/view/inc/customerMenu.jsp" />
            </div>

            <div class="info-column">
            
                <div class="customer-main-content">
                    <h2>회원 정보 관리</h2>
                    <hr>
                    
                    <%-- 
                        여기에 기존 customerInfo.jsp의
                        회원 정보 조회/수정 관련 핵심 HTML 코드를 붙여넣으세요. 
                    --%>
                    
                    <h3>회원 정보 내용</h3>
                    <p>현재 로그인된 사용자의 상세 정보를 표시하는 영역입니다.</p>
                    
                </div>
            </div>
            
        </div>
    </div>
    
</body>
</html>