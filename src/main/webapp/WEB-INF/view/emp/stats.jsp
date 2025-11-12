<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
  <title>통계 자료 | Shop Admin</title>

  <!-- 공통 관리자 레이아웃 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminLayout.css" />

  <!-- 왼쪽 관리자 메뉴 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/empMenu.css" />

  <!-- 관리자 공지 상세용 기본 폼 스타일 (레이아웃 유사) -->
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

        <canvas id="myChart" style="width:100%;max-width:700px"></canvas>

      </div>
    </div>
  </main>
</div>
	<canvas id="myChart" style="width:100%;max-width:700px"></canvas>

	<script>
		let myChart = null;
		
		// 
		$('#genderOrderPrice').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/genderOrderPrice'
				, type: 'get'
				, success: function(result){
					if(myChart != null){
						myChart.destroy();
					}
					
					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.gender);
						yValues.push(m.totalPrice)
					});
					
					const barColors = [
					  "#b91d47",
					  "#00aba9",
					  "#2b5797",
					  "#e8c3b9",
					  "#1e7145"
					];

					const ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "pie",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display:true},
					      title: {
					        display: true,
					        text: "남/여 전체주문 금액",
					        font: {size:16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		// 
		$('#genderOrder').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/genderOrder'
				, type: 'get'
				, success: function(result){
					if(myChart != null){
						myChart.destroy();
					}
					
					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.gender);
						yValues.push(m.cnt)
					});
					
					const barColors = [
					  "#b91d47",
					  "#00aba9",
					  "#2b5797",
					  "#e8c3b9",
					  "#1e7145"
					];

					const ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "pie",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display:true},
					      title: {
					        display: true,
					        text: "남/여 전체주문량",
					        font: {size:16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		// 제품별 주문금액 1위 ~ 10위
		$('#goodsTopOrderPrice').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/goodsTopOrderPrice'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.goodsName);
						yValues.push(m.totalPrice);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "teal", "pink", "gray"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "상품별 주문금액 1위 ~ 10위",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		// 제품별 주문횟수 1위 ~ 10위
		$('#goodsTopOrder').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/goodsTopOrder'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.goodsName);
						yValues.push(m.cnt);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "teal", "pink", "gray"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "상품별 주문횟수 1위 ~ 10위",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		// 고객별 주문금액 1위 ~ 10위
		$('#topTotalOrderPrice').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/topOrderPrice'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.customerName);
						yValues.push(m.totalPrice);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "teal", "pink", "gray"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "고객별 주문금액 1위 ~ 10위",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		
		// 고객별 주문횟수 1위 ~ 10위
		$('#topTotalOrder').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/topOrder'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.customerName);
						yValues.push(m.cnt);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow", "purple", "teal", "pink", "gray"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "고객별 주문횟수 1위 ~ 10위",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		//
		$('#orderPriceBtn').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/orderPrice'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.ym);
						yValues.push(m.totalPrice);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "20250101 ~ 현재 월별 판매금액",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});
		
		//
		$('#orderBtn').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/order'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){
					console.log(result);
					// <canvas id="myChat"> 에 차트가 있다면 차트를 삭제하고
					if(myChart != null){
						myChart.destroy();
					}
					// 막대 차트 소스코드
					// xValues, yValues : 모델

					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m){
						xValues.push(m.ym);
						yValues.push(m.cnt);
					});
					
					let barColors = ["red", "green","blue","orange","brown", "yellow"];

					let ctx = document.getElementById('myChart');

					myChart = new Chart(ctx, {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      legend: {display: false},
					      title: {
					        display: true,
					        text: "20250101 ~ 현재 월별 판매량(주문량)",
					        font: {size: 16}
					      }
					    }
					  }
					});
				}
			});
		});

		$('#totalPriceBtn').click(function(){
			// alert('orderAndPrice 클릭');
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalPrice'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){ // result --> list
					console.log(result);
					
					let x = [];
					let y = [];
					
					console.log(result.priceList);
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalPrice);
					});
					
					if(myChart != null){
						myChart.destroy();
					}
					
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
						  label: $('#fromYM').val() + '~' + $('#toYM').val() + '총판매금액 추이(누적)', 
					      data: y,
					      borderColor: "blue",
					      fill: false
					    }]
					  },
					  options: {
					    legend: {display: true}
					  }
					});
				} 
			});
		});
	
		$('#totalOrderBtn').click(function(){
			// alert('orderAndPrice 클릭');
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalOrder'
				, type: 'get'
				, data: {
							fromYM: $('#fromYM').val()
							, toYM: $('#toYM').val()
						}
				, success: function(result){ // result --> list
					console.log(result);
					
					let x = [];
					let y = [];
					
					console.log(result.orderList);
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalOrder);
					});
					
					if(myChart != null){
						myChart.destroy();
					}
					
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
						  label: $('#fromYM').val() + '~' + $('#toYM').val() + '주문량 추이(누적)', 
					      data: y,
					      borderColor: "red",
					      fill: false
					    }]
					  },
					  options: {
					    legend: {display: true}
					  }
					});
				} 
			});
		});
	</script>
</body>
</html>











