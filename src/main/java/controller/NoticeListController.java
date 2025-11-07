package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.NoticeDao;
import dto.Notice;


@WebServlet("/emp/noticeList")
public class NoticeListController extends HttpServlet {
	private NoticeDao noticeDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1; // 기본 페이지
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int rowPerPage = 10;
		int beginRow = (currentPage - 1) * rowPerPage;
		int totalCount = 0;
		int lastPage = 0;
		int startPage = 0;
		int endPage = 0;
		
		noticeDao = new NoticeDao(); // DI(객체 의존성 주입)
		try {
			List<Notice> list = noticeDao.selectNoticeList(beginRow, rowPerPage);
			totalCount = noticeDao.countNotice();

			// ▶ Math 없이 마지막 페이지 계산
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage = lastPage + 1;
			}
			if (lastPage == 0) {
				lastPage = 1;
			}
		
		// 페이징
		// int pagePerPage = 10
		/* cp	sp	ep
		 * 1	1	10
		 * 2	1	10
		 * 10	1	10
		 * 11	11	20
		 * 
		 * 1~10  1	10	sp=((cp-1)/10)*10+1 => 10번대 ep=sp+(ep-1)
		 * 11~20 11	20	((11-1)/10)*10+1 => 20번대
		 * 21~30 21 30	((25-1)/10)*10+1 => 30번대
		 * 120			((120-1)/10)*10+1 = 111  
		 * 
		 * 1~10	((cp-1)/pagePerPage)*pagePerPage+1 sp+(pagePerPage-1)
		 */
		// [이전] 1 2 3 4 5 6 7 8 9 10[다음] : 이전과 다음사이의 페이지 개수 - 10
			startPage = ((currentPage - 1) / 10) * 10 + 1;
			endPage = startPage + 9;
			if (endPage > lastPage) {
				endPage = lastPage;
			}
		
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("lastPage", lastPage);
			
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
		} catch (Exception e) {
			throw new ServletException(e);
		}
		
		request.getRequestDispatcher("/WEB-INF/view/emp/noticeList.jsp").forward(request, response);
	}
}
