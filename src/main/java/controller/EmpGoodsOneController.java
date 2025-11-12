package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import dao.GoodsDao;

@WebServlet("/emp/empGoodsOne")
public class EmpGoodsOneController extends HttpServlet {
	private GoodsDao goodsDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goodsCode = request.getParameter("goodsCode");
		
		// 필드 객체 의존성을 직접 주입(DIL: Dependency Injection)
		goodsDao = new GoodsDao();
		Map<String, Object> goods = null;
		try {
			goods = goodsDao.selectGoodsOne(Integer.parseInt(goodsCode));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 상품이 없을 경우 404 처리
		if (goods == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 상품을 찾을 수 없습니다.");
			return;
		}
				
		request.setAttribute("goods", goods);
		
		request.getRequestDispatcher("/WEB-INF/view/emp/empGoodsOne.jsp").forward(request, response);
	}


}
