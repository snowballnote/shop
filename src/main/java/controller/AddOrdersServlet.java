package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dao.AddressDao;
import dao.CartDao;
import dao.GoodsDao;
import dao.OrdersDao;
import dto.Address;
import dto.Customer;
import dto.Orders;

@WebServlet("/customer/addOrders")
public class AddOrdersServlet extends HttpServlet {
	 private GoodsDao goodsDao;
	 private CartDao cartDao;
	 private AddressDao addressDao;
	 private OrdersDao ordersDao;
	 
	 // POST는 주문 확정 로직 (지금은 GET으로 위임)
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");
		String addressCode = request.getParameter("addressCode");
		String orderPrice = request.getParameter("orderPrice"); // 결제 모듈 추가 후 진행
		
		String[] goodsCodeList = request.getParameterValues("goodsCodeList");
		String[] orderQuantityList = request.getParameterValues("orderQuantityList");
		String[] goodsPriceList = request.getParameterValues("goodsPriceList");

		
		System.out.println("loginCustomer:" + loginCustomer.getCustomerCode());
		System.out.println("addressCode:" + addressCode);
		System.out.println("orderPrice:" + orderPrice);
		
		System.out.println("goodsCodeList:" + goodsCodeList.length);
		System.out.println("orderQuantityList:" + orderQuantityList.length);
		System.out.println("goodsPriceList:" + goodsPriceList.length);
		
		// 1) insert payment 테이블에 결제 행을 추가 - 테이블ㄹ 추가 필요
		
		// 2) insert orders  각 상품별로 주문행 추가
		ordersDao = new OrdersDao();
		for(int i=0; i<goodsCodeList.length; i++) { // goodsCodeList, orderQuantity, goodsPriceList
			Orders o = new Orders();
			o.setCustomerCode(loginCustomer.getCustomerCode());
			o.setAddressCode(Integer.parseInt(addressCode));
			o.setGoodsCode(Integer.parseInt(goodsCodeList[i]));
			o.setOrderQuantity(Integer.parseInt(orderQuantityList[i]));
			// goodsPrice => 상품가격 - orderPrice 할인된 가격: 두개 다를 수 있다.
			o.setOrderPrice(Integer.parseInt(goodsPriceList[i]) * Integer.parseInt(orderQuantityList[i]));
			ordersDao.insertOrders(o);
		}
		
		// 1)번 테이블 추가후 구현 가능
		// 3) orders_payment 테이블에 payment pk와 orders pk를 연결(insert)
		
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ------------------------------------------------------------------
        // ✅ 1. 로그인 유효성 검사 및 CustomerCode 추출 (최우선)
        // ------------------------------------------------------------------
		HttpSession session = request.getSession();
		Customer loginCustomer = (Customer) session.getAttribute("loginCustomer");
        
        if (loginCustomer == null) {
            // 로그인되어 있지 않다면 주문 불가, 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/customer/login"); 
            return; 
        }
        int customerCode = loginCustomer.getCustomerCode(); // 로그인 확인 후 Code 추출
        
        // ------------------------------------------------------------------
        // 2. 주문 상품 목록 (List) 및 주문 가격 구성
        // ------------------------------------------------------------------
		String goodsCode = request.getParameter("goodsCode");
		String cartQuantity = request.getParameter("cartQuantity");
		String[] cartCodeList = request.getParameterValues("cartCodeList");
		
		System.out.println("goodsCode: " + goodsCode);
		System.out.println("cartQuantity: " + cartQuantity);
		System.out.println("cartCodeList: " + (cartCodeList != null ? String.join(", ", cartCodeList) : "null"));
		
		List<Map<String, Object>> list = new ArrayList<>();
		int orderPrice = 0;
		
		if(goodsCode != null) { // goodsOne action (단일 상품 바로 주문)
			goodsDao = new GoodsDao();
			Map<String, Object> m = null;
			try {
				m = goodsDao.selectGoodsOne(Integer.parseInt(goodsCode));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (m != null) {
                m.put("cartQuantity", cartQuantity);
                list.add(m);
                // 주문 금액 계산: 상품 금액 * 수량
                orderPrice += (Integer) m.get("goodsPrice") * Integer.parseInt(cartQuantity);
            }
		} else if (cartCodeList != null){ // cartList action (장바구니 상품 주문)
			cartDao = new CartDao();
			for(String cc : cartCodeList) {
				int cartCode = Integer.parseInt(cc);
				Map<String, Object> m = cartDao.selectCartListByKey(cartCode);
				if (m != null) {
	                list.add(m);
	                // 주문 금액 계산: 상품 금액 * 장바구니 수량
	                orderPrice += (Integer) m.get("goodsPrice") * (Integer) m.get("cartQuantity");    
	            } else {
	                System.out.println("경고: 유효하지 않은 cartCode [" + cartCode + "]는 주문 목록에서 제외되었습니다.");
	            }
				// cartDao.deleteCart(cc); // 장바구니 삭제 로직은 주문 확정 후에 하는 것이 일반적입니다.
			}
		} else {
            // 주문 정보가 없는 경우
            System.out.println("주문 정보가 없어 카트 리스트로 리다이렉트합니다.");
            response.sendRedirect(request.getContextPath() + "/customer/cartList"); 
            return;
        }

        // ------------------------------------------------------------------
        // ✅ 3. 주소 리스트 조회 (반복문 밖에서 한 번만 실행)
        // ------------------------------------------------------------------
        addressDao = new AddressDao();
        try {
            List<Address> addressList = addressDao.selectAddressList(customerCode);
            request.setAttribute("addressList", addressList); // ✅ 주문 JSP로 주소 리스트 전달
        } catch (Exception e) {
            System.out.println("주소 리스트 조회 중 오류 발생 (Code: " + customerCode + ")");
            e.printStackTrace();
            request.setAttribute("addressList", new ArrayList<Address>()); // 비어있는 리스트라도 전달하여 JSP에서 오류 회피
        }
        
        // ------------------------------------------------------------------
        // ✅ 4. JSP로 정보 전달 및 포워딩 (반복문 밖에서 한 번만 실행)
        // ------------------------------------------------------------------
        request.setAttribute("list", list);
        request.setAttribute("orderPrice", orderPrice);
        
        request.getRequestDispatcher("/WEB-INF/view/customer/addOrders.jsp").forward(request, response);
	}
}