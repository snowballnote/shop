package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import dao.GoodsDao;

@WebServlet("/customer/goodsOne")
public class GoodsOneController extends HttpServlet {
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
		 
		request.setAttribute("goods", goods);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/goodsOne.jsp").forward(request, response);
	}

}
