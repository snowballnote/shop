package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.EmpDao;
import dto.Emp;

@WebServlet("/emp/addEmp")
public class AddEmpController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String empId   = request.getParameter("empId");
		String empPw   = request.getParameter("empPw");
		String empPw2  = request.getParameter("empPw2");
		String empName = request.getParameter("empName");

		empId   = empId   == null ? null : empId.trim();
		empPw   = empPw   == null ? null : empPw.trim();
		empPw2  = empPw2  == null ? null : empPw2.trim();
		empName = empName == null ? null : empName.trim();

		final String action = request.getParameter("action");
		final boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		EmpDao empDao = new EmpDao();

		// AJAX 중복확인 (fetch)
		if ("checkId".equals(action) && isAjax) {
			response.setContentType("application/json; charset=UTF-8");
			try {
				if (empId == null || empId.isBlank() || empId.length() < 4) {
					response.getWriter().write("{\"ok\":false,\"msg\":\"아이디는 4자 이상\"}");
				} else {
					boolean exists = empDao.existsEmpId(empId);
					response.getWriter().write("{\"ok\":true,\"exists\":" + exists + "}");
				}
			} catch (Exception e) {
				response.getWriter().write("{\"ok\":false,\"msg\":\"서버 오류\"}");
			}
			return;
		}

		// 일반 회원등록 처리 (기존 로직 동일)
		request.setAttribute("empId", empId);
		request.setAttribute("empName", empName);

		if (empId == null || empPw == null || empName == null
				|| empId.isBlank() || empPw.isBlank() || empName.isBlank()) {
			request.setAttribute("msg", "모든 항목을 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
			return;
		}

		if (!empPw.equals(empPw2) || empPw.length() < 4) {
			request.setAttribute("msg", "비밀번호를 확인해주세요. (4자 이상/일치)");
			request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
			return;
		}

		if (!empName.matches("^[가-힣]{2,}$")) {
			request.setAttribute("msg", "이름은 한글로 2자 이상 입력해주세요.");
			request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
			return;
		}

		Emp emp = new Emp();
		emp.setEmpId(empId);
		emp.setEmpPw(empPw);
		emp.setEmpName(empName);

		try {
			if (empDao.existsEmpId(empId)) {
				request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
				request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
				return;
			}

			int row = empDao.insertEmp(emp);

			if (row == 1) {
				response.sendRedirect(request.getContextPath() + "/emp/empList");
			} else {
				request.setAttribute("msg", "사원 등록에 실패했습니다. 다시 시도해주세요.");
				request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
			}
		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}
}
