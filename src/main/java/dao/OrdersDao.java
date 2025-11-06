package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

public class OrdersDao {
	
	public List<Map<String, Object>> selectOrdersList(int startRow, int rowPerPage) throws Exception() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
					select o.order_code orderCode
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
					from orders o inner join goods g
					on o.goods_code = g.goods_code
					    inner join customer c
					    on o.customer_code = c.customer_code
					        inner join address a
					        on o.address_code = a.address_code
					order by o.order_code desc
					OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
				""";
		
		conn = DBConnection.getConn();
		conn.setAutoCommit(false);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt(executeQuery);
		while(rs.next()) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("orderCode", rs.getInt("orderCode"));
			m.put("goodsCode", rs.getInt("orderCode"));
			m.put("customerCode", rs.getInt("orderCode"));
			m.put("addressCode", rs.getInt("orderCode"));
			m.put("orderQuantity", rs.getInt("orderCode"));
			m.put("orderCode", rs.getInt("orderCode"));
			m.put("orderState", rs.getInt("orderCode"));
			m.put("orderCode", rs.getInt("orderCode"));
			m.put("orderCode", rs.getInt("orderCode"));
			m.put("orderCode", rs.getInt("orderCode"));
			m.put("createdate", rs.getInt("orderCode"));
			
			m.put("goodsName", rs.getInt("goodsName"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("customerCode", rs.getInt("orderCode"));
			m.put("addressCode", rs.getInt("orderCode"));
			m.put("customerName", rs.getInt("customerName"));
			m.put("customerPhone", rs.getInt("customerPhone"));
			m.put("address", rs.getInt("address"));
			list.add(m);
			
		}
		return m;
	}
	
}
