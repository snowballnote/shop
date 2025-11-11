package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatsDao {
	// 11 개 chart메서드
	public List<Map<String, Object>> selectOrderTotalCntByYM(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT t.ym ym
							, SUM(t.cnt) OVER(ORDER BY t.ym ASC) totalOrder
					FROM
					    (SELECT TO_CHAR(createdate, 'YYYY-MM') ym, COUNT(*) cnt
					    FROM orders
					    WHERE createdate BETWEEN TO_DATE(?, 'YYYY-MM-DD')
					    AND TO_DATE(?, 'YYYY-MM-DD')
					    GROUP BY TO_CHAR(createdate, 'YYYY-MM')) t
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("totalOrder", rs.getString("totalOrder"));
				list.add(map);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
			}
		}
		return list;
		
	}
	
	public List<Map<String, Object>> selectOrderTotalPriceByYM(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT t.ym ym
							, SUM(t.total) OVER(ORDER BY t.ym ASC) totalPrice
					FROM
					    (SELECT TO_CHAR(createdate, 'YYYY-MM') ym, SUM(order_price) total
					    FROM orders
					    WHERE createdate BETWEEN TO_DATE(?, 'YYYY-MM-DD')
					    AND TO_DATE(?, 'YYYY-MM-DD')
					    GROUP BY TO_CHAR(createdate, 'YYYY-MM')) t
				""";
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ym", rs.getString("ym"));
				map.put("totalPrice", rs.getString("totalPrice"));
				list.add(map);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
			}
		}
		return list;
	}
}
