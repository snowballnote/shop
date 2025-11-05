package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.CustomerDao;
import dto.Customer;

@WebServlet("/emp/customerList")
public class CustomerListController extends HttpServlet {
	private CustomerDao customerDao; // 이렇게 클래스 설계하기
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 기본 페이지 번호 설정
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 10;
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 마지막 페이지(총 행 수 기반 계산용)
		int lastPage = 0;
		
		// DAO 호출
		customerDao = new CustomerDao();
		List<Customer> customerList = null;
		
		try {
			// 사원 목록 조회
			customerList = customerDao.selectCustomerList(beginRow, rowPerPage);
			
			// 전체 사원 수 조회 -> 마지막 페이지 계산
			int totalCount = customerDao.countCustomer();
			lastPage = (totalCount + rowPerPage - 1) / rowPerPage;
		}catch(Exception e) {
			e.printStackTrace();
		}

		// 모델 속성
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("customerList", customerList);
				
		request.getRequestDispatcher("/WEB-INF/view/emp/customerList.jsp").forward(request, response);	
	}
}
