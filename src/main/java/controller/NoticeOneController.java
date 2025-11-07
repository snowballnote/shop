package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;

@WebServlet("/emp/noticeOne")
public class NoticeOneController extends HttpServlet {
	private NoticeDao noticeDao;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String noticeCodeParam = request.getParameter("noticeCode");
		if (noticeCodeParam == null || noticeCodeParam.isBlank()) {
			// noticeCode가 없을 경우 → 목록 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/emp/noticeList");
			return;
		}
		
		int noticeCode = 0;
		try {
			noticeCode = Integer.parseInt(noticeCodeParam);
		} catch (NumberFormatException e) {
			// noticeCode가 숫자가 아닐 경우 → 목록 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/emp/noticeList");
			return;
		}
		
		// DAO 객체 생성 및 상세 데이터 조회
		noticeDao = new NoticeDao();
		Notice notice = null;
		
		try {
			notice = noticeDao.selectNoticeOne(noticeCode);
		} catch (Exception e) {
			// DB 조회 중 예외 발생 시 로그 출력 후 목록으로 이동
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/emp/noticeList");
			return;
		}
		// 조회 결과 확인 및 뷰로 포워딩
		if (notice == null) {
			// 존재하지 않는 공지 → 메시지와 함께 목록 이동
			request.setAttribute("msg", "존재하지 않는 공지사항입니다.");
			request.getRequestDispatcher("/WEB-INF/view/emp/noticeList.jsp").forward(request, response);
			return;
		}
		
		// JSP로 전달
		request.setAttribute("notice", notice);
		request.getRequestDispatcher("/WEB-INF/view/emp/noticeOne.jsp").forward(request, response);
	}
}
