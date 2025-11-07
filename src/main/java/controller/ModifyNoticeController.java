package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.NoticeDao;
import dto.Notice;

@WebServlet("/emp/modifyNotice")
public class ModifyNoticeController extends HttpServlet {
    private NoticeDao noticeDao; // lazy init

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (noticeDao == null) noticeDao = new NoticeDao(); // ✅ lazy init

        // 1) 파라미터 검증
        String noticeCodeParam = request.getParameter("noticeCode");
        if (noticeCodeParam == null || noticeCodeParam.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "noticeCode is required");
            return;
        }

        int noticeCode;
        try {
            noticeCode = Integer.parseInt(noticeCodeParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "noticeCode must be integer");
            return;
        }

        // 2) 단건 조회 → 폼 프리필
        Notice n = noticeDao.selectNoticeOne(noticeCode);
        if (n == null) {
            response.sendRedirect(request.getContextPath() + "/emp/noticeList?msg=not_found");
            return;
        }

        // 3) 바인딩 + forward
        request.setAttribute("notice", n);
        request.getRequestDispatcher("/WEB-INF/view/emp/modifyNotice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // ✅ 한글 깨짐 방지
        if (noticeDao == null) noticeDao = new NoticeDao(); // ✅ lazy init

        // 1) 파라미터 수집
        String noticeCodeParam = request.getParameter("noticeCode");
        String title           = request.getParameter("noticeTitle");
        String content         = request.getParameter("noticeContent");

        // 2) 기본 검증
        if (noticeCodeParam == null || noticeCodeParam.isBlank()
                || title == null || title.isBlank()
                || content == null || content.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "invalid parameters");
            return;
        }

        int noticeCode;
        try {
            noticeCode = Integer.parseInt(noticeCodeParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "noticeCode must be integer");
            return;
        }

        // 3) DTO 구성 (아무나 수정 정책 → empCode 세팅 불필요)
        Notice n = new Notice();
        n.setNoticeCode(noticeCode);
        n.setNoticeTitle(title.trim());
        n.setNoticeContent(content.trim());

        // 4) DAO 호출
        int row;
        try {
            row = noticeDao.updateNotice(n); // ✅ 지금 너가 보낸 메서드 그대로 사용
            // System.out.println("[modify] updated rows = " + row); // 디버깅용
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "db error");
            return;
        }

        // 5) 결과 PRG
        if (row == 1) {
            response.sendRedirect(request.getContextPath()
                    + "/emp/noticeOne?noticeCode=" + noticeCode + "&msg=updated");
        } else {
            response.sendRedirect(request.getContextPath()
                    + "/emp/noticeOne?noticeCode=" + noticeCode + "&msg=not_found");
        }
    }
}
