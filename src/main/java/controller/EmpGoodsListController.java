package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.GoodsDao;

@WebServlet("/emp/empGoodsList")
public class EmpGoodsListController extends HttpServlet {
	private GoodsDao goodsDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		goodsDao = new GoodsDao();

		// -----------------------------------------------------------
		// 1. 페이지네이션 변수 설정
		// -----------------------------------------------------------
		int currentPage = 1; // 현재 페이지 (기본값 1)
		if (request.getParameter("currentPage") != null) {
			try {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			} catch (NumberFormatException e) {
				// 예외 발생 시 기본값 유지 (1)
			}
		}

		int rowPerPage = 10; // 페이지당 상품 수
		int pagePerPage = 10; // 페이지 블록당 페이지 수 (예: 1~10)

		int totalCount = 0;
		int lastPage = 0;
		int beginRow = 0;
		int endRow = 0;
		int startPage = 0;
		int endPage = 0;

		List<Map<String, Object>> goodsList = null;

		try {
			// -----------------------------------------------------------
			// 2. 전체 상품 개수 조회 및 lastPage 계산
			// -----------------------------------------------------------
			
			// ⭐⭐ DB 연결 성공 확인용 로그 (필요없다면 삭제) ⭐⭐
			System.out.println("--- GoodsListController 실행 시작 ---");
			
			totalCount = goodsDao.countGoods();
			
			System.out.println("DEBUG: totalCount=" + totalCount); // 디버그 로그

			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage++;
			}

			// -----------------------------------------------------------
			// 3. 현재 페이지의 시작/끝 Row 계산
			// -----------------------------------------------------------
			beginRow = (currentPage - 1) * rowPerPage;

			// -----------------------------------------------------------
			// 4. 페이지 블록 시작/끝 페이지 계산
			// -----------------------------------------------------------
			startPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
			endPage = startPage + pagePerPage - 1;
			if (endPage > lastPage) {
				endPage = lastPage;
			}

			// -----------------------------------------------------------
			// 5. 상품 목록 조회 (페이지네이션 적용)
			// -----------------------------------------------------------
			if (totalCount > 0) {
				goodsList = goodsDao.selectGoodsListForEmp(beginRow, rowPerPage);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// 오류 발생 시 사용자에게 500 오류를 명확히 알림
			throw new ServletException(e); 
		}

		// -----------------------------------------------------------
		// 6. JSP로 데이터 전달
		// -----------------------------------------------------------
		
		// 페이지네이션 관련 변수
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("lastPage", lastPage);

		// 상품 목록 데이터
		request.setAttribute("goodsList", goodsList);

		// JSP 페이지로 포워딩
		request.getRequestDispatcher("/WEB-INF/view/emp/goodsList.jsp").forward(request, response);
	}
}
