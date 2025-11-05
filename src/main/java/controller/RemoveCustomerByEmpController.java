package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import dao.CustomerDao;
import dto.Outid;

@WebServlet("/emp/removeCustomerByEmp")
public class RemoveCustomerByEmpController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 기본 페이지 번호 설정
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException ignore) { /* 기본값 1 유지 */ }
		}

		// 파라미터 수집
		String customerId = request.getParameter("customerId");

		// 모델 속성
		request.setAttribute("customerId", customerId);
		request.setAttribute("currentPage", currentPage);

		// view로 포워드 (확인 화면)
		request.getRequestDispatcher("/WEB-INF/view/emp/removeCustomerByEmp.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 기본 페이지 번호 설정
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException ignore) { /* 기본값 1 유지 */ }
		}

		// 파라미터 수집
		String customerId = request.getParameter("customerId");
		String memo       = request.getParameter("memo");

		// DTO 구성 (createdate는 DAO에서 SYSDATE 처리)
		Outid outid = new Outid();
		outid.setId(customerId);
		outid.setMemo(memo);

		// DAO 호출 (customer 삭제 + outid 등록 트랜잭션)
		CustomerDao customerDao = new CustomerDao();
		try {
			customerDao.deleteCustomerByEmp(outid);
			response.sendRedirect(request.getContextPath()
				+ "/emp/customerList?currentPage=" + currentPage);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()
				+ "/emp/customerList?currentPage=" + currentPage);
		}
	}
}
