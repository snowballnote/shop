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
	
	// 상품별 주문금액 1~10위 - 막대
	public List<Map<String, Object>> selectTop10GoodsByOrderPrice(String fromYM, String toYM) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = """
			SELECT 
				g.goods_code goodsCode,
				g.goods_name goodsName,
				SUM(o.order_price) totalPrice
			FROM 
				orders o
			JOIN 
				goods g ON o.goods_code = g.goods_code
			WHERE 
				TO_CHAR(o.createdate, 'YYYY-MM') BETWEEN ? AND ?
			GROUP BY 
				g.goods_code, g.goods_name
			ORDER BY 
				totalPrice DESC
			FETCH FIRST 10 ROWS ONLY
		""";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", rs.getInt("goodsCode"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("totalPrice", rs.getInt("totalPrice"));
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return list;
	}
	
	// 상품별 주문 횟수 1~10위 - 막대
	public List<Map<String, Object>> selectTop10GoodsByOrderCnt(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT 
					    g.goods_code goodsCode,
					    g.goods_name goodsName,
					    COUNT(o.order_code) cnt
					FROM 
					    orders o
					JOIN 
					    goods g ON o.goods_code = g.goods_code
					WHERE 
					    TO_CHAR(o.createdate, 'YYYY-MM') BETWEEN ? AND ?
					GROUP BY 
					    g.goods_code, g.goods_name
					ORDER BY 
					    cnt DESC
					FETCH FIRST 10 ROWS ONLY
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", rs.getInt("goodsCode"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("cnt", rs.getInt("cnt"));
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
	
	// 고객별 주문금액 1~10위 - 막대
	public List<Map<String, Object>> selectTop10CustomersByOrderPrice(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT 
					    c.customer_code customerCode,
					    c.customer_name customerName,
					     SUM(o.order_price) totalPrice
					FROM 
					    orders o
					JOIN 
					    customer c ON o.customer_code = c.customer_code
					WHERE 
					    TO_CHAR(o.createdate, 'YYYY-MM') BETWEEN ? AND ?
					GROUP BY 
					    c.customer_code, c.customer_name
					ORDER BY 
					    totalPrice DESC
					FETCH FIRST 10 ROWS ONLY
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("customerCode", rs.getInt("customerCode"));
				map.put("customerName", rs.getString("customerName"));
				map.put("totalPrice", rs.getInt("totalPrice"));
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
	
	// 고객별 주문 횟수 1~10위 - 막대
	public List<Map<String, Object>> selectTop10CustomersByOrderCnt(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT 
					    c.customer_code customerCode,
					    c.customer_name customerName,
					    COUNT(o.order_code) cnt
					FROM 
					    orders o
					JOIN 
					    customer c ON o.customer_code = c.customer_code
					WHERE 
					    TO_CHAR(o.createdate, 'YYYY-MM') BETWEEN ? AND ?
					GROUP BY 
					    c.customer_code, c.customer_name
					ORDER BY 
					    cnt DESC
					FETCH FIRST 10 ROWS ONLY
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, fromYM);
			stmt.setString(2, toYM);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("customerCode", rs.getInt("customerCode"));
				map.put("customerName", rs.getString("customerName"));
				map.put("cnt", rs.getInt("cnt"));
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
	
	// 성별 총 주문금액 - 파이
	public List<Map<String, Object>> selectOrderPriceByGender(){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT t.g gender, SUM(t.op) totalPrice
					FROM
						(SELECT c.gender g, o.order_code oc, o.order_price op
						FROM customer c INNER JOIN orders o
						ON c.customer_code = o.customer_code) t
					GROUP BY t.g
					ORDER BY t.g
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("gender", rs.getString("gender"));
				map.put("totalPrice", rs.getInt("totalPrice"));
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
	
	//성별 총 주문수량 - 파이차트
	public List<Map<String, Object>> selectOrderCntByGender(){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT t.g gender, COUNT(*) cnt
					FROM
						(SELECT c.gender g, o.order_code oc
						FROM customer c INNER JOIN orders o
						ON c.customer_code = o.customer_code) t
					GROUP BY t.g
					ORDER BY t.g
				""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("gender", rs.getString("gender"));
				map.put("cnt", rs.getInt("cnt"));
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
	
	// 월 주문금액 - 막대차트
	public List<Map<String, Object>> selectOrderPriceByYM(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT TO_CHAR(createdate, 'YYYY-MM') ym, SUM(order_price) totalPrice
					FROM orders
					WHERE createdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') 
										AND TO_DATE(?, 'YYYY-MM-DD')
					GROUP BY TO_CHAR(createdate, 'YYYY-MM')
					ORDER BY TO_CHAR(createdate, 'YYYY-MM') ASC
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
				map.put("totalPrice", rs.getInt("totalPrice"));
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
	
	// 월 주문량 - 막대차트
	public List<Map<String, Object>> selectOrderCntByYM(String fromYM, String toYM){
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					SELECT TO_CHAR(createdate, 'YYYY-MM') ym, COUNT(*) cnt
					FROM orders
					WHERE createdate BETWEEN TO_DATE(?, 'YYYY-MM-DD') 
										AND TO_DATE(?, 'YYYY-MM-DD')
					GROUP BY TO_CHAR(createdate, 'YYYY-MM')
					ORDER BY TO_CHAR(createdate, 'YYYY-MM') ASC                      
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
				map.put("cnt", rs.getInt("cnt"));
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
	//월 주문량 - 선
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
	//월 주문금액 - 선
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
