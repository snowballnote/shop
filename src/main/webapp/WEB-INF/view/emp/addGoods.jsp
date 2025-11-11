<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 등록 | Shop Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/addGoods.css" /> 
</head>
<body>
    <div class="admin-layout">
        <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

        <main class="admin-content">
            <div class="page-center">
                <div class="form-wrap">

                    <h2 class="form-title">상품 등록</h2>

                    <form method="post" action="${pageContext.request.contextPath}/emp/addGoods" enctype="multipart/form-data" autocomplete="off">
                        
                        <div class="input-row">
                            <input type="text" name="goodsName" class="input" placeholder="상품명" required />
                        </div>
                        
                        <div class="input-row">
                            <input type="number" name="goodsPrice" class="input" placeholder="가격 (숫자만)" required />
                        </div>

                        <div class="input-row">
                            <input type="number" step="0.01" name="pointRate" class="input" placeholder="포인트 적립률 (예: 0.05)" required />
                        </div>
                        
                        <div class="input-row">
                            <textarea name="goodsContent" class="textarea" placeholder="상품 설명 (필수)" required></textarea>
                        </div>
                        
                        <div class="input-row">
                            <label for="goodsImg" class="file-label">대표 이미지 선택</label>
                            <input type="file" id="goodsImg" name="goodsImg" class="input-file" accept="image/*" required />
                        </div>

                        <button type="submit" class="submit-btn">등록</button>
                        
                        <div class="link-row">
                            <a href="${pageContext.request.contextPath}/emp/empGoodsList">← 목록으로</a>
                        </div>
                    </form>

                </div>
            </div>
        </main>
    </div>
</body>
</html>