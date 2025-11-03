<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Login | Shop</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/recess.css">
</head>
<body>

<div class="page-center">
	<div class="login-wrap">
		<h1 class="login-title">Login</h1>
		
		<div class="role-switch" style="justify-content:center; margin-bottom:18px;">
	        <input type="radio" name="customerOrEmpSel" id="selCustomer" value="customer"
               <c:if test="${empty param.customerOrEmpSel or param.customerOrEmpSel == 'customer'}">checked</c:if>>
	        <label for="selCustomer">Customer</label>

        	<input type="radio" name="customerOrEmpSel" id="selEmp" value="emp"
            	<c:if test="${param.customerOrEmpSel == 'emp'}">checked</c:if>>
        	<label for="selEmp">Employee</label>
		</div>
		
		<c:if test="${not empty loginMsg}">
        	<div class="msg">${loginMsg}</div>
      	</c:if>

      	<form method="post" action="${pageContext.request.contextPath}/out/login" autocomplete="off">
	        <input type="text" name="id" id="id" class="input" placeholder="Id">
	        <input type="password" name="pw" id="pw" class="input" placeholder="Password">
			
			<div style="margin-top:14px;">
          		<button type="submit" class="btn">Sign In</button>
        	</div>
      </form>
      
	  <div class="link-row">
	  	or <a href="${pageContext.request.contextPath}/out/addCustomer"><em>Register</em></a>
	  </div>
      
      <a href="" class="underline-link">Forgot your password?</a>
    </div>
  </div>
</body>
</html>
