package ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.IdDao;

@WebServlet("/IdCk")
public class IdCkRestController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		
		// 파라미터 수집 + 정규화
		String id = request.getParameter("id");
		id = (id == null) ? null : id.trim();
		
		// 기본 검증
		if (id == null || id.length() < 4) {
			response.getWriter().write("{\"ok\":false,\"msg\":\"아이디는 4자 이상\"}");
			return;
		}
		
		// DAO 호출
		IdDao idDao = new IdDao();
		try {
			boolean exists = idDao.existsGlobalId(id); // customer + emp + outid 통합 체크
			response.getWriter().write("{\"ok\":true,\"exists\":" + exists + "}");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
