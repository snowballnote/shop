package controller;

import java.io.IOException;
import dao.GoodsDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/customerIndex")
public class CustomerIndexController extends HttpServlet {
    private GoodsDao goodsDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // -- 페이징 파라미터 파싱 --
        int currentPage = 1;
        String cp = request.getParameter("currentPage");
        if (cp != null && cp.matches("\\d+")) {
            currentPage = Integer.parseInt(cp);
            if (currentPage < 1) currentPage = 1;
        }
        int rowPerPage = 20;
        int beginRow   = (currentPage - 1) * rowPerPage; // ★ (1 - currentPage) 아님

        // -- 데이터 조회 --
        goodsDao = new GoodsDao();
        try {
            request.setAttribute("goodsList", goodsDao.selectGoodsList(beginRow, rowPerPage));
            request.setAttribute("bestGoodsList", goodsDao.selectBestGoodsList());
        } catch (Exception e) {
            e.printStackTrace(); // 실패 시 빈 리스트로 JSP가 "없습니다" 문구 출력
        }

        request.setAttribute("currentPage", currentPage);
        request.getRequestDispatcher("/WEB-INF/view/customer/customerIndex.jsp")
               .forward(request, response);
    }
}
