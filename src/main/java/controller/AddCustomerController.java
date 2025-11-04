package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.CustomerDao;
import dao.IdDao;
import dto.Customer;

@WebServlet("/out/addCustomer")
public class AddCustomerController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 회원가입 폼
		request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 파라미터 수집 + 정규화
		String id    = trim(request.getParameter("id"));
		String pw    = trim(request.getParameter("pw"));
		String pw2   = trim(request.getParameter("pw2"));
		String name  = trim(request.getParameter("name"));
		String phone = trim(request.getParameter("phone"));

		// 값 보존 (재표시)
		request.setAttribute("id", id);
		request.setAttribute("name", name);
		request.setAttribute("phone", phone);

		// 서버 유효성 검사 (클라 검증과 동일 규칙, 서버는 반드시 유지)
		if (isBlank(id) || isBlank(pw) || isBlank(name) || isBlank(phone)) {
			request.setAttribute("msg", "모든 항목을 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			return;
		}
		if (!pw.equals(pw2) || pw.length() < 4) {
			request.setAttribute("msg", "비밀번호를 확인해주세요. (4자 이상/일치)");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			return;
		}
		if (!name.matches("^[가-힣]{2,}$")) {
			request.setAttribute("msg", "이름은 한글로 2자 이상 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			return;
		}
		if (!phone.matches("^[0-9]{10,11}$")) {
			request.setAttribute("msg", "전화번호는 숫자 10~11자리로 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			return;
		}

		// DTO 구성
		Customer c = new Customer();
		c.setCustomerId(id);
		c.setCustomerPw(pw); // TODO: 해시 적용
		c.setCustomerName(name);
		c.setCustomerPhone(phone);

		// DAO 호출
		CustomerDao customerDao = new CustomerDao();
		IdDao idDao = new IdDao(); // 통합 ID 중복체크(customer+emp+outid)

		try {
			// 최종 중복체크
			if (idDao.existsGlobalId(id)) {
				request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
				request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
				return;
			}

			// insert
			int row = customerDao.insertCustomer(c);

			// 결과 처리
			if (row == 1) {
				response.sendRedirect(request.getContextPath() + "/out/login");
			} else {
				request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
				request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			}
		} catch (java.sql.SQLIntegrityConstraintViolationException dup) {
			// DB UNIQUE 제약 위반(동시성 등)
			request.setAttribute("msg", "이미 사용 중인 아이디입니다. (DB)");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
		} catch (Exception e) {
			// 서버 에러는 컨테이너로 위임
			throw new ServletException(e);
		}
	}
	
	// 폼 유효성 검사 실패 시, 에러 메시지를 담아 다시 JSP로 포워드한다.
	private void fail(HttpServletRequest req, HttpServletResponse resp, String msg)
			throws ServletException, IOException {
		req.setAttribute("msg", msg);
		req.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(req, resp);
	}
	
	// 문자열 앞뒤 공백을 제거한다.
	private String trim(String s) {
		return (s == null) ? null : s.trim();
	}
	
	// 문자열이 null이거나, 공백 문자만 포함되어 있는지 확인한다.
	private boolean isBlank(String s) {
		return (s == null || s.isBlank());
	}
}