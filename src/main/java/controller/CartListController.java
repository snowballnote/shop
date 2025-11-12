package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.CartDao;
import dto.Customer;

@WebServlet("/customer/cartList")
public class CartListController extends HttpServlet {
	private CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
		
		List<Map<String, Object>> cartList = cartDao.selectCartList(customerCode);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/cartList.jsp").forward(request, response);
	}
}