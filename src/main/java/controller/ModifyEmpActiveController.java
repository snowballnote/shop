package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.EmpDao;

@WebServlet("/emp/modifyEmpActive")
public class ModifyEmpActiveController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 수집
		String empCodeParam = request.getParameter("empCode");
		String nextActiveParam = request.getParameter("nextActive");
		String currentPageParam = request.getParameter("currentPage");
		
		// 기본값 설정
		int empCode = 0;
		int nextActive = 0;
		int currentPage = 1;
				
		// 파라미터가 null이 아닐 때만 변환 시도
		if (empCodeParam != null && nextActiveParam != null) {
			empCode = Integer.parseInt(empCodeParam);
			nextActive = Integer.parseInt(nextActiveParam);
		}
		if (currentPageParam != null) {
			currentPage = Integer.parseInt(currentPageParam);
		}
		
		// DB 업데이트 (활성화 ↔ 비활성화)
		try {
			EmpDao empDao = new EmpDao();
			empDao.updateActive(empCode, nextActive); // active 상태 변경 (1 ↔ 0)
		} catch (Exception e) {
			throw new ServletException(e); // 예외 발생 시 서블릿 예외로 전달
		}
		
		// 변경 후 리스트 페이지로 복귀
		response.sendRedirect(request.getContextPath() + "/emp/empList?currentPage=" + currentPage);
	}
}
