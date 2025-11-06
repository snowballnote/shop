package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import dao.GoodsDao;
import dto.Goods;

@WebServlet("/emp/goodsList")
public class GoodsListController extends HttpServlet {
	private GoodsDao goodsDao;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 페이지
		int currentPage = 1; // 기본 페이지
		String cp = request.getParameter("currentPage");
		if (cp != null && !cp.isBlank()) {
			try {
				currentPage = Integer.parseInt(cp);
			} catch (NumberFormatException ignore) {
				currentPage = 1;
			}
		}
		if (currentPage < 1) currentPage = 1; // 1페이지 미만 방지

		// 페이징 계산
		int rowPerPage = 10; // 페이지당 행 수
		int beginRow = (currentPage - 1) * rowPerPage;

		// DAO 호출
		goodsDao = new GoodsDao();
		List<Goods> goodsList = null;
		int lastPage = 1;

		try {
			// 전체 상품 수 조회
			int totalCount = goodsDao.countGoods();
			lastPage = (int) Math.ceil(totalCount / (double) rowPerPage);
			if (lastPage < 1) lastPage = 1;

			// 현재 페이지가 마지막 페이지보다 크면 보정
			if (currentPage > lastPage) {
				currentPage = lastPage;
				beginRow = (currentPage - 1) * rowPerPage;
			}

			// 상품 목록 조회 (최신순)
			goodsList = goodsDao.selectGoodsList(beginRow, rowPerPage);

		} catch (Exception e) {
			throw new ServletException(e);
		}

		request.setAttribute("currentPage", currentPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("rowPerPage", rowPerPage);
		request.setAttribute("goodsList", goodsList);

		request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
	}
}
