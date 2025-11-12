<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>통계 자료 | Shop Admin</title>

  <!-- 공통 관리자 레이아웃 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />

  <!-- 왼쪽 관리자 메뉴 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />

  <!-- 기본 폼 스타일 (레이아웃 유사) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empNoticeOne.css" />

  <!-- 관리자 통계 페이지 전용 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empStats.css" />

  <!-- jQuery & Chart.js -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0"></script>
</head>

<body>
  <div class="admin-layout">
    <!-- 왼쪽 관리자 메뉴 -->
    <c:import url="/WEB-INF/view/inc/empMenu.jsp" />

    <!-- 오른쪽 콘텐츠 -->
    <main class="admin-content">
      <div class="page-center">
        <div class="form-wrap">

          <h2 class="form-title">통계 자료</h2>

          <div class="controls">
            <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
            <input type="text" id="fromYM" value="2025-01-01"> ~
            <input type="text" id="toYM" value="2025-12-31">
          </div>

          <div class="controls">
            <button id="totalOrderBtn">특정년도의 월별 주문횟수(누적) : 선 차트</button>
            <button id="totalPriceBtn">특정년도의 월별 주문금액(누적) : 선 차트</button>
            <button id="orderBtn">특정년도의 월별 주문수량 : 막대 차트</button>
            <button id="orderPriceBtn">특정년도의 월별 주문금액 : 막대 차트</button>
            <button id="topTotalOrder">고객별 주문횟수 1위 ~ 10위 : 막대 차트</button>
            <button id="topTotalOrderPrice">고객별 총금액 1위 ~ 10위 : 막대 차트</button>
            <button id="goodsTopOrder">상품별 주문횟수 1위 ~ 10위 : 막대 차트</button>
            <button id="goodsTopOrderPrice">상품별 주문금액 1위 ~ 10위 : 막대 차트</button>
            <button id="">상품별 평균 리뷰평점 1위 ~ 10위 : 막대 차트</button>
            <button id="genderOrder">성별 총주문 수량 : 파이 차트</button>
            <button id="genderOrderPrice">성별 총주문 금액 : 파이 차트</button>
          </div>

          <canvas id="myChart" style="width:100%; max-width:900px;"></canvas>

        </div>
      </div>
    </main>
  </div>

  <script>
    let myChart = null;

    // 🎨 회색 파스텔톤 색상 팔레트
    const pastelBarColors = ["#b0bec5", "#cfd8dc", "#90a4ae", "#78909c", "#eceff1",
                             "#bdbdbd", "#9e9e9e", "#607d8b", "#d7ccc8", "#c8e6c9"];
    const pastelPieColors = ["#9fa8a3", "#b0bec5", "#c5cae9", "#d7ccc8", "#e0e0e0"];
    const pastelLineColor = "#607d8b";

    // -------------------------------
    // 성별 총 주문 금액 (파이 차트)
    // -------------------------------
    $('#genderOrderPrice').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/genderOrderPrice',
        type: 'get',
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.gender);
            yValues.push(m.totalPrice);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "pie",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelPieColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: true },
                title: {
                  display: true,
                  text: "남/여 전체주문 금액",
                  font: { size: 16 },
                  color: "#333"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 성별 총 주문 수량 (파이 차트)
    // -------------------------------
    $('#genderOrder').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/genderOrder',
        type: 'get',
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.gender);
            yValues.push(m.cnt);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "pie",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelPieColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: true },
                title: {
                  display: true,
                  text: "남/여 전체주문량",
                  font: { size: 16 },
                  color: "#333"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 상품별 주문 금액 (막대)
    // -------------------------------
    $('#goodsTopOrderPrice').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/goodsTopOrderPrice',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.goodsName);
            yValues.push(m.totalPrice);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "상품별 주문금액 1위 ~ 10위",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 상품별 주문 횟수 (막대)
    // -------------------------------
    $('#goodsTopOrder').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/goodsTopOrder',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.goodsName);
            yValues.push(m.cnt);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "상품별 주문횟수 1위 ~ 10위",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 고객별 주문금액 (막대)
    // -------------------------------
    $('#topTotalOrderPrice').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/topOrderPrice',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.customerName);
            yValues.push(m.totalPrice);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "고객별 주문금액 1위 ~ 10위",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 고객별 주문 횟수 (막대)
    // -------------------------------
    $('#topTotalOrder').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/topOrder',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.customerName);
            yValues.push(m.cnt);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "고객별 주문횟수 1위 ~ 10위",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 월별 주문금액 (막대)
    // -------------------------------
    $('#orderPriceBtn').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/orderPrice',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.ym);
            yValues.push(m.totalPrice);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "월별 판매금액",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 월별 주문수량 (막대)
    // -------------------------------
    $('#orderBtn').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/order',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const xValues = [];
          const yValues = [];

          result.forEach(m => {
            xValues.push(m.ym);
            yValues.push(m.cnt);
          });

          const ctx = document.getElementById('myChart');
          myChart = new Chart(ctx, {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
                backgroundColor: pastelBarColors,
                data: yValues
              }]
            },
            options: {
              plugins: {
                legend: { display: false },
                title: {
                  display: true,
                  text: "월별 판매량(주문량)",
                  font: { size: 16 },
                  color: "#222"
                }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 월별 총 판매금액 (선 차트)
    // -------------------------------
    $('#totalPriceBtn').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/totalPrice',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const x = [];
          const y = [];

          result.forEach(m => {
            x.push(m.ym);
            y.push(m.totalPrice);
          });

          myChart = new Chart("myChart", {
            type: "line",
            data: {
              labels: x,
              datasets: [{
                label: $('#fromYM').val() + '~' + $('#toYM').val() + ' 총판매금액 추이(누적)',
                data: y,
                borderColor: pastelLineColor,
                backgroundColor: "#cfd8dc",
                tension: 0.3,
                fill: false
              }]
            },
            options: {
              plugins: {
                legend: { display: true }
              }
            }
          });
        }
      });
    });

    // -------------------------------
    // 월별 총 주문량 (선 차트)
    // -------------------------------
    $('#totalOrderBtn').click(function() {
      $.ajax({
        url: $('#contextPath').val() + '/emp/totalOrder',
        type: 'get',
        data: {
          fromYM: $('#fromYM').val(),
          toYM: $('#toYM').val()
        },
        success: function(result) {
          if (myChart) myChart.destroy();

          const x = [];
          const y = [];

          result.forEach(m => {
            x.push(m.ym);
            y.push(m.totalOrder);
          });

          myChart = new Chart("myChart", {
            type: "line",
            data: {
              labels: x,
              datasets: [{
                label: $('#fromYM').val() + '~' + $('#toYM').val() + ' 주문량 추이(누적)',
                data: y,
                borderColor: pastelLineColor,
                backgroundColor: "#eceff1",
                tension: 0.3,
                fill: false
              }]
            },
            options: {
              plugins: {
                legend: { display: true }
              }
            }
          });
        }
      });
    });
  </script>
</body>
</html>
