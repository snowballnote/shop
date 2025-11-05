package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;
import dto.Outid;

@WebServlet("/emp/removeCustomerByEmp")
public class RemoveCustomerByEmpController extends HttpServlet {
	// 강제탈퇴 화면
	// 직원이 고객 강제탈퇴 페이지를 요청했을 때
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 수집 (누구를 탈퇴시킬 건지)
		String customerId = request.getParameter("customerId");
		
		// 강제탈퇴 확인 화면으로
		request.setAttribute("customerId", customerId);
		request.getRequestDispatcher("/WEB-INF/view/emp/removeCustomerByEmp.jsp").forward(request, response);
	}
	
	// 강제탈퇴 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customerId = request.getParameter("customerId");
		String memo = request.getParameter("memo");
		String createdate = request.getParameter("createdate");
		
		// DTO
		Outid outid = new Outid();
		outid.setId(customerId);
		outid.setMemo(memo);
		outid.setCreatedate(createdate);
		
		// DAO (customer 삭제 + outid 등록)
		CustomerDao customerDao = new CustomerDao();
		try {
			customerDao.deleteCustomerByEmp(outid);
			
			// 성공 => 고객 목록 페이지
			response.sendRedirect(request.getContextPath() + "/emp/customerList");
		} catch (Exception e) {
			e.printStackTrace();
			// 실패 시: 다시 목록으로 이동
			response.sendRedirect(request.getContextPath() + "/emp/customerList");
		}
	}
}
