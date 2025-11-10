package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.GoodsDao;

@WebServlet("/customer/customerIndex")
public class CustomerIndexController extends HttpServlet {
	private GoodsDao goodsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 20;
		int beginRow = (1-currentPage) * rowPerPage;
		
		goodsDao = new GoodsDao();
		try {
			request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("currentPage", currentPage);
		
//		request.setAttribute("lastPage", lastPage);
//		request.setAttribute("startPage", startPage);
//		request.setAttribute("endPage", endPage);
		
		int totalTd = 20;
		// 만약에 페이지(첫번째 or 마지막)에 출력할 상품이 7개다 -> totalTd = 10
		request.setAttribute("totalTd", totalTd);
		
		request.setAttribute(LEGACY_DO_HEAD, response);
		request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp").forward(request, response);
	}

}
