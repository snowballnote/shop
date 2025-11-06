package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.OrdersDao;

@WebServlet("/customer/orderList")
public class OrderListController extends HttpServlet {
		private OrdersDao ordersDao;                             
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int currentPage = 1;
		int rowPerPage = 10;
		int beginRow = (1-currentPage) * rowPerPage;
		
		ordersDao = new OrdersDao();
		List<Map<String, Object>> list = null;
		try {
			list = ordersDao.selectOrdersLsit(beginRow, rowPerPage);
		}catch(EXCeption e)
		
	}

}
