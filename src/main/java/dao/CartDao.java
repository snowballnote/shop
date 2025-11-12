package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Cart;

public class CartDao {
	public List<Map<String, Object>> selectCartList(int customerCode){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = """
				SELECT 
					c.cart_code cartCode
					, g.goods_name goodsName
					, nvl(g.soldout, ' ') soldout
					, g.goods_price goodsPrice
					, c.cart_quantity cartQuantity
					, g.goods_price * c.cart_quantity totalPrice
				FROM cart c INNER JOIN goods g
				ON c.goods_code = g.goods_code
				WHERE customer_code = 1;
			""";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("cartCode", rs.getInt("cartCode"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("soldout", rs.getString("soldout")); // soldout은 공백으로 받음
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("cartQuantity", rs.getInt("cartQuantity"));
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
	
	public int insertCart(Cart c) throws Exception{
		int row = 0;
		Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = """
	    		
	    		""";
	    try {
	    	conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
	    }catch(Exception e) {
	    	
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
}
