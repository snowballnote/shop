package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import dao.CartDao;
import dto.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/customer/cartList")
public class CartListController extends HttpServlet {
	CartDao cartDao;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
		if (loginCustomer == null) {
		    response.sendRedirect(request.getContextPath() + "/customer/loginForm"); 
		    return;
		}
		// ★★★ 바로 여기에 추가하세요! ★★★
	    int currentCustomerCode = loginCustomer.getCustomerCode();
	    System.out.println("★현재 로그인 고객 코드: " + currentCustomerCode);
	    // ★★★ 여기까지 추가하세요! ★★★
	    
		cartDao = new CartDao();
		List<Map<String, Object>> list = cartDao.selectCartList(loginCustomer.getCustomerCode());
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("/WEB-INF/view/customer/cartList.jsp").forward(request, response);
	}

}