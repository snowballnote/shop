package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class IdDao {
	// 전체 아이디 존재 여부 확인 (customer + emp + outid)
	public boolean existsGlobalId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		boolean exists = false;
		
		String sql = """
				SELECT COUNT(*) cnt
				FROM (
					SELECT customer_id id FROM customer
					UNION ALL
					SELECT emp_id id FROM emp
					UNION ALL
					SELECT id FROM outid
				) t
				WHERE t.id = ?
			""";

		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			exists = rs.getInt("cnt") > 0; // 결과가 1 이상이면 존재
		}
		rs.close();
		stmt.close();
		conn.close();

		return exists;
	}
}
