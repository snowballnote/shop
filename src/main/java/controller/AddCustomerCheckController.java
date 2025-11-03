package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;

@WebServlet("/out/addCustomerCheck")
public class AddCustomerCheckController extends HttpServlet {
	// 아이디 중복 확인
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");

        // 빈값 검사
        if (id == null || id.isBlank()) {
        	request.setAttribute("idCheckMsg", "아이디를 입력해주세요.");
        	request.setAttribute("idCheckResult", false);
        	request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
            return;
        }
        
        // DAO 호출
        CustomerDao dao = new CustomerDao();
        boolean exists;
        try {
            exists = dao.existsCustomerId(id);
        } catch (Exception e) {
            throw new ServletException(e);
        }
        
        // 결과 설정
        if (exists) {
        	request.setAttribute("idCheckMsg", "이미 사용 중인 아이디입니다.");
        	request.setAttribute("idCheckResult", false);
        } else {
        	request.setAttribute("idCheckMsg", "사용 가능한 아이디입니다.");
        	request.setAttribute("idCheckResult", true);
        }
        
        // 다시 회원가입 폼으로 (forward)
        request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
	}

}
