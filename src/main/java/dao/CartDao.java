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
	// cartCode -> 주문완료 페이지에 출력 하나의 상품정보
		public Map<String, Object> selectCartListByKey(int cartCode) {
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = """
				select 
				    gi.filename filename
				    , g.goods_code goodsCode
				    , g.goods_name goodsName
				    , g.goods_price goodsPrice
				    , g.point_rate pointRate
				    , c.cart_quantity cartQuantity
				from cart c inner join goods g
				on c.goods_code = g.goods_code
				    inner join goods_img gi
				    on c.goods_code = gi.goods_code
				where c.cart_code = ?
			""";
			Map<String, Object> m = null;
			try {
				conn = DBConnection.getConn();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, cartCode);
				rs = stmt.executeQuery();
				while(rs.next()) {
					m = new HashMap<>();
					m.put("filename", rs.getString("filename"));
					m.put("goodsCode", rs.getInt("goodsCode"));
					m.put("goodsName", rs.getString("goodsName"));
					m.put("goodsPrice", rs.getInt("goodsPrice"));
					m.put("pointRate", rs.getDouble("pointRate"));
					m.put("cartQuantity", rs.getInt("cartQuantity"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) stmt.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e2) {
					e2.printStackTrace();
				}
			}
			return m;
		}
		
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
				WHERE c.customer_code = ?
			""";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			rs = stmt.executeQuery();
			int count = 0;
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
	    		INSERT INTO cart(cart_code, goods_code, customer_code, cart_quantity, createdate)
	    		VALUES(seq_cart.nextval, ?, ?, ?, sysdate)
	    		""";
	    try {
	    	conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.executeUpdate();
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
