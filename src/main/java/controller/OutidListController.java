package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.OutidDao;
import dto.Outid;

@WebServlet("/emp/outidList")
public class OutidListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int rowPerPage = 10;
        int beginRow = (currentPage - 1) * rowPerPage;
        int lastPage = 0;

        OutidDao outidDao = new OutidDao();
        List<Outid> outidList = null;

        try {
            outidList = outidDao.selectOutIdListByPage(beginRow, rowPerPage);
            int totalCount = outidDao.countOutId();
            lastPage = (totalCount + rowPerPage - 1) / rowPerPage;
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("lastPage", lastPage);
        request.setAttribute("outidList", outidList);

        request.getRequestDispatcher("/WEB-INF/view/emp/outidList.jsp").forward(request, response);
    }
	
}
