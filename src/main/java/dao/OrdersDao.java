package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Orders;

public class OrdersDao {
	public int insertOrders(Orders o) {
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				INSERT INTO orders(
					order_code, goods_code, customer_code, address_code, order_quantity
					, order_price, order_state, createdate
				)VALUES(
					seq_order.nextval, ?, ?, ?, ?, ?, '주문완료', SYSDATE
				)	
			""";
		int row = 0;
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, o.getGoodsCode());
			stmt.setInt(2, o.getCustomerCode());
			stmt.setInt(3, o.getAddressCode());
			stmt.setInt(4, o.getOrderQuantity());
			stmt.setInt(5, o.getOrderPrice());
			row = stmt.executeUpdate();
			}catch (Exception e) { // DB 연결 및 SQL 오류를 catch
	             e.printStackTrace();
		}finally {
			try {
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	// 주문 리스트
	public List<Map<String, Object>> selectOrdersList(int beginRow, int rowPerPage) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		String sql = """
				SELECT o.order_code orderCode
					, o.goods_code goodsCode
					, o.customer_code customerCode
					, o.address_code addressCode
					, o.order_quantity orderQuantity
			        , o.order_state orderState
			        , o.createdate createdate
			        , g.goods_name goodsName
			        , g.goods_price goodsPrice
			        , c.customer_name customerName
			        , c.customer_phone customerPhone
			        , a.address address
				FROM orders o INNER JOIN goods g
				ON o.goods_code = g.goods_code
				    INNER JOIN customer c
				    ON o.customer_code = c.customer_code
				        INNER JOIN address a
				        ON o.address_code = a.address_code
				ORDER BY o.order_code DESC
				OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
			""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("orderCode", rs.getInt("orderCode"));
				m.put("goodsCode", rs.getInt("goodsCode"));
				m.put("customerCode", rs.getInt("customerCode"));
				m.put("addressCode", rs.getInt("addressCode"));
				m.put("orderQuantity", rs.getInt("orderQuantity"));
				m.put("orderPrice", rs.getInt("orderPrice"));
				m.put("orderState", rs.getString("orderState"));
				m.put("createdate", rs.getString("createdate"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				m.put("customerName", rs.getString("customerName"));
				m.put("customerPhone", rs.getString("customerPhone"));
				m.put("address", rs.getString("address"));
				list.add(m);
			}
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
	
	// 전체 주문 수 (페이지 계산용)
	public int countOrders() throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int total = 0;
			
		String sql = "SELECT COUNT(*) cnt FROM orders";
			
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
				
			if (rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch (SQLException e) {
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
		return total;
	}
}