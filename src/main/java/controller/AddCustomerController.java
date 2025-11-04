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

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
	}

	@Override
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

		final String action  = request.getParameter("action");
		final boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		CustomerDao dao = new CustomerDao();

		/* ===== AJAX: ID 중복확인 ===== */
		if ("checkId".equals(action) && isAjax) {
			response.setContentType("application/json; charset=UTF-8");
			try {
				if (id == null || id.isBlank() || id.length() < 4) {
					response.getWriter().write("{\"ok\":false,\"msg\":\"아이디는 4자 이상\"}");
				} else {
					boolean exists = dao.existsCustomerId(id);
					response.getWriter().write("{\"ok\":true,\"exists\":" + exists + "}");
				}
			} catch (Exception e) {
				response.getWriter().write("{\"ok\":false,\"msg\":\"서버 오류\"}");
			}
			return; // 여기서 종료
		}

		/* ===== 일반 회원등록 처리 ===== */
		// 서버 유효성 (클라와 동일 규칙)
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

		Customer c = new Customer();
		c.setCustomerId(id);
		c.setCustomerPw(pw);    // TODO: 해시 적용
		c.setCustomerName(name);
		c.setCustomerPhone(phone);

		try {
			// 중복 체크 (서버 안전망)
			if (dao.existsCustomerId(id)) {
				request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
				request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
				return;
			}

			int row = dao.insertCustomer(c);
			if (row == 1) {
				response.sendRedirect(request.getContextPath() + "/out/login");
			} else {
				request.setAttribute("msg", "회원가입에 실패했습니다. 다시 시도해주세요.");
				request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
			}
		} catch (java.sql.SQLIntegrityConstraintViolationException dup) {
			request.setAttribute("msg", "이미 사용 중인 아이디입니다. (DB)");
			request.getRequestDispatcher("/WEB-INF/view/out/addCustomer.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private String trim(String s){ return s == null ? null : s.trim(); }
	private boolean isBlank(String s){ return s == null || s.isBlank(); }
}
