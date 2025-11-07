package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;

@WebServlet("/emp/addNotice")
public class AddNoticeController extends HttpServlet {
	private NoticeDao noticeDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 직원 등록 폼
		request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		
		// 유효성 검사
		if (noticeTitle == null || noticeContent == null || noticeTitle.isBlank() || noticeContent.isBlank()) {
			request.setAttribute("msg", "제목과 내용을 모두 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
			return;
		}
		
		// DTO 구성
		Notice notice = new Notice();
		notice.setNoticeTitle(noticeTitle);
		notice.setNoticeContent(noticeContent);
		notice.setEmpCode(empCode);
		
		// DAO 호출
		noticeDao = new NoticeDao();
		
		try {
			// insert 실행
			int row = noticeDao.insertNotice(notice);
			
			if (row == 1) {
				// 성공 → 목록으로
				response.sendRedirect(request.getContextPath() + "/emp/noticeList");
				return;
			}
			// 실패 → 폼으로 메시지
			request.setAttribute("msg", "공지 등록에 실패했습니다. 다시 시도해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "시스템 오류가 발생했습니다. 관리자에게 문의해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/emp/addNotice.jsp").forward(request, response);
		}
	}
}
