package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.CustomerDao;
import dao.EmpDao;
import dto.Customer;
import dto.Emp;

@WebServlet("/out/login")
public class LoginController extends HttpServlet {
	// 로그인 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response); 
	}
	
	// 로그인 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 값 받아오기
		String role  = request.getParameter("customerOrEmpSel");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// 필수값 검증
		if(role  == null || id == null || pw == null
				|| role.isBlank() || id.isBlank() || pw.isBlank()) {
			request.setAttribute("loginMsg", "아이디와 비밀번호, 롤을 모두 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response); 
			return;
		}
		
		// 로그인 검증 DAO 호출
		CustomerDao customerDao = new CustomerDao();
		EmpDao empDao = new EmpDao();
		
		// 세션 준비
		HttpSession session = request.getSession();
				
		// 역할에 따라 분기(고객/직원)
		if("customer".equals(role)) {
			// 고객 로그인 시도
			Customer paramC = new Customer();
			paramC.setCustomerId(id);
			paramC.setCustomerPw(pw);
			
			Customer loginCustomer;
			try {
				loginCustomer = customerDao.selectCustomerByLogin(paramC);
			} catch (Exception e) {
				throw new ServletException(e);
			}
			
			// 로그인 실패 처리
			if (loginCustomer == null) {
				request.setAttribute("loginMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
				request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
				return;
			}
			
			// 로그인 성공 → 세션 저장 후 고객 메인으로		
			session.setAttribute("loginCustomer", loginCustomer);
			session.setAttribute("role", "customer");
			response.sendRedirect(request.getContextPath() + "/customer/customerIndex");
			return;
		}
		
		if("emp".equals(role)) {
			// 직원 로그인 시도
			Emp paramE = new Emp();
			paramE.setEmpId(id);
			paramE.setEmpPw(pw);
			
			Emp loginEmp = null;
			try {
				loginEmp = empDao.selectEmpByLogin(paramE);
			} catch (Exception e) {
				throw new ServletException(e);
			}
			
			// 로그인 처리 실패
			if (loginEmp == null) {
		        request.setAttribute("loginMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
		        request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
		        return;
			}
			
			// 로그인 성공 → 세션 저장 후 직원 메인으로
            session.setAttribute("loginEmp", loginEmp);
            session.setAttribute("role", "emp");
            response.sendRedirect(request.getContextPath() + "/emp/empIndex");
            return;
		}
		
		// role이  customer/emp 이외의 값일 때(정상 흐름은 아님)
		request.setAttribute("loginMsg", "올바르지 않은 접근입니다.");
        request.getRequestDispatcher("/WEB-INF/view/out/login.jsp").forward(request, response);
	}

}
