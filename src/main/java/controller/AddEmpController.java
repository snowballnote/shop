package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import dao.EmpDao;
import dao.IdDao;
import dto.Emp;

@WebServlet("/emp/addEmp")
public class AddEmpController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 직원 등록 폼
		request.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 파라미터 수집 + 정규화
		String id		= request.getParameter("empId");
		String pw		= request.getParameter("empPw");
		String pw2		= request.getParameter("empPw2");
		String name		= request.getParameter("empName");
		String activeP	= request.getParameter("active"); // "1" or "0"
		int active		= "0".equals(activeP) ? 0 : 1;

		// 값 보존 (재표시용)
		request.setAttribute("empId", id);
		request.setAttribute("empName", name);
		request.setAttribute("active", active);

		// 서버 유효성 검사
		if (isBlank(id) || isBlank(pw) || isBlank(name)) {
			fail(request, response, "모든 항목을 입력해주세요.");
			return;
		}
		if (!pw.equals(pw2) || pw.length() < 4) {
			fail(request, response, "비밀번호를 확인해주세요. (4자 이상/일치)");
			return;
		}
		if (!name.matches("^[가-힣]{2,}$")) {
			fail(request, response, "이름은 한글로 2자 이상 입력해주세요.");
			return;
		}

		// DTO 구성
		Emp emp = new Emp();
		emp.setEmpId(id);
		emp.setEmpPw(pw); // TODO: 해시 적용 예정
		emp.setEmpName(name);
		emp.setActive(active);

		// DAO 호출
		EmpDao empDao = new EmpDao();
		IdDao idDao   = new IdDao(); // 통합 ID 중복체크 (customer+emp+outid)

		try {
			// 최종 중복체크 (글로벌)
			if (idDao.existsGlobalId(id)) {
				fail(request, response, "이미 사용 중인 아이디입니다.");
				return;
			}

			// insert 실행
			int row = empDao.insertEmp(emp);

			// 결과 처리
			if (row == 1) {
				response.sendRedirect(request.getContextPath() + "/emp/empList");
			} else {
				fail(request, response, "사원 등록에 실패했습니다. 다시 시도해주세요.");
			}

		} catch (java.sql.SQLIntegrityConstraintViolationException dup) {
			// DB UNIQUE 제약 위반 (동시성 문제 등)
			fail(request, response, "이미 사용 중인 아이디입니다. (DB)");
			
		} catch (Exception e) {
			// 서버 오류는 컨테이너에 위임 (500)
			throw new ServletException(e);
		}
	}
	
	// 폼 유효성 검사 실패 시, 에러 메시지를 담아 다시 JSP로 포워드한다.
	private void fail(HttpServletRequest req, HttpServletResponse resp, String msg)
			throws ServletException, IOException {
		req.setAttribute("msg", msg);
		req.getRequestDispatcher("/WEB-INF/view/emp/addEmp.jsp").forward(req, resp);
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
