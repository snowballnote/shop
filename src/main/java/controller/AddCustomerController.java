package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dto.Customer;

@WebServlet("/out/addCustomer")
public class AddCustomerController extends HttpServlet {
	// 회원가입 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// addCustomer.jsp
		 request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
	}
	
	// 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 수집
        String id    = request.getParameter("id");
        String pw    = request.getParameter("pw");
        String pw2   = request.getParameter("pw2");
        String name  = request.getParameter("name");
        String phone = request.getParameter("phone");
        
        // 필수값 검증
        if (id == null || pw == null || name == null || phone == null
                || id.isBlank() || pw.isBlank() || name.isBlank() || phone.isBlank()) {
            request.setAttribute("msg", "모든 항목을 입력해주세요.");
            request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
            return;
        }
        if (!pw.equals(pw2) || pw.length() < 4) {
        	request.setAttribute("msg", "비밀번호를 확인해주세요. (4자 이상/일치)");
        	request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
            return;
        }
        
        // DTO 구성
        Customer c = new Customer();
        c.setCustomerId(id);
        c.setCustomerPw(pw);      // (추후 해시 적용 예정)
        c.setCustomerName(name);
        c.setCustomerPhone(phone);
        
        // DAO 호출
        CustomerDao dao = new CustomerDao();
        
        // 아이디 중복 체크
        try {
            if (dao.existsCustomerId(id)) {
                request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
                request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
                return;
            }
            
            // insert
            int row = dao.insertCustomer(c);
            
            // 결과 처리
            if (row == 1) {
                // 가입 성공 → 로그인 페이지로
                response.sendRedirect(request.getContextPath() + "/out/login");
            } else {
                request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
                request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }

	}
}