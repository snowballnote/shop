package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.EmpDao;
import dto.Emp;

@WebServlet("/emp/empList")
public class EmpListController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int beginRow = (currentPage-1) * rowPerPage;
		
		int lastPage = 0;
		
		EmpDao empDao = new EmpDao();
		List<Emp> empList = null;
		try {
			empList = empDao.selectEmpListByPage(beginRow, rowPerPage);
		}catch (Exception e) {
			throw new ServletException(e);
		}
		
		// 모델 속성
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("empList", empList);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/empList.jsp").forward(request, response);
		
	}
}
