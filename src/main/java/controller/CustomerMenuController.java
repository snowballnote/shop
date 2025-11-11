package controller; // 패키지 이름을 'controller'에서 'controller.customer'로 변경하는 것을 권장합니다.

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// 💡 URL 경로와 클래스 이름을 일치시키고, URL은 소문자로 지정합니다.
@WebServlet("/customer/customerMenu") 
public class CustomerMenuController extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        // ***************************************************************
        // 추후 회원 정보를 조회하는 DAO 로직과 세션 검사 로직이 여기에 추가됩니다.
        // ***************************************************************
        
        // 1. DAO를 사용하여 회원 정보를 조회
        // (현재는 생략)
        
        // 2. JSP 페이지로 포워딩
        // 이 경로는 /WEB-INF/view/customer/customerMenu.jsp 로 가정합니다.
		request.getRequestDispatcher("/WEB-INF/view/customer/customerMenu.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// POST 요청도 동일하게 GET으로 처리하거나, 회원 정보 수정 로직을 추가할 수 있습니다.
		doGet(request, response);
	}
}