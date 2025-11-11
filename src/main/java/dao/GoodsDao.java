package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Goods;
import dto.GoodsImg;

public class GoodsDao {
	// /customer/goodsOne
	public Map<String, Object> selectGoodsOne(int goods_code) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Map<String, Object> m = new HashMap<String, Object>();

		String sql = """
				SELECT
					gi.filename filename
					, g.goods_code   goodsCode
					, g.goods_name   goodsName
					, g.goods_price  goodsPrice
					, nvl(g.soldout, '0') soldout
					, g.point_rate pointRate
				FROM goods g INNER JOIN goods_img gi
				ON g.goods_code = gi.goods_code
				WHERE g.goods_code = ?
			""";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);

			stmt.setInt(1, goods_code);

			rs = stmt.executeQuery();

			while (rs.next()) {
				m.put("filename", rs.getString("filename"));
				m.put("goodsCode", rs.getInt("goodsCode"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				m.put("soldout", rs.getString("soldout"));
				m.put("pointRate", rs.getDouble("pointRate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return m;
	}

	public List<Map<String, Object>> selectBestGoodsList() throws Exception{
		Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<Map<String, Object>> list = new ArrayList<>();
	    
	    String sql = """
	            SELECT 
	                    gi.filename filename
	                    , g.goods_code goodsCode
	                    , g.goods_name goodsName
	                    , g.goods_price goodsPrice
	            FROM
	            goods g 
	                LEFT JOIN goods_img gi
	                ON g.goods_code = gi.goods_code
	                INNER JOIN(
	                    SELECT goods_code, COUNT(*) 
	                    FROM orders
	                    WHERE order_state = '배달완료'
	                    GROUP BY goods_code
	                    ORDER BY count(*) DESC
	                    OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
	                ) t
	                ON g.goods_code = t.goods_code
	        """;
		
		try {
	        conn = DBConnection.getConn();
	        stmt = conn.prepareStatement(sql);
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> m = new HashMap<>();
	            m.put("filename",  rs.getString("filename"));
	            m.put("goodsCode", rs.getInt("goodsCode"));
	            m.put("goodsName", rs.getString("goodsName"));
	            m.put("goodsPrice", rs.getInt("goodsPrice"));
	            list.add(m);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs   != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e1) {
				e1.printStackTrace();
			}
	    }
	    return list;
		
	}
	
	// 전체 굿즈 리스트 확인
	public List<Map<String, Object>> selectGoodsList(int beginRow, int rowPerPage) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Map<String, Object>> list = new ArrayList<>();

		String sql = """
				SELECT
					gi.filename filename
					, g.goods_code   goodsCode
					, g.goods_name   goodsName
					, g.goods_price  goodsPrice
				FROM goods g LEFT JOIN goods_img gi
				ON g.goods_code = gi.goods_code
				WHERE g.soldout IS NULL
				ORDER BY g.goods_code DESC
				OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
			""";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);

			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);

			rs = stmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> m = new HashMap<>();
				m.put("filename", rs.getString("filename"));
				m.put("goodsCode", rs.getInt("goodsCode"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return list;
	}

	// 전체 굿즈 수 (페이지 계산용)
	public int countGoods() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int total = 0;

		String sql = "SELECT COUNT(*) cnt FROM goods WHERE soldout IS NULL";

		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return total;
	}

	// 상품등록 + 이미지 등록
	// 반환값은 실패시 false
	public boolean insertGoodsAndImg(Goods goods, GoodsImg img) throws Exception {
		boolean result = false;
		Connection conn = null;
		PreparedStatement stmtSeq = null; // select
		PreparedStatement stmtGoods = null; // insert
		PreparedStatement stmtImg = null; // insert
		ResultSet rs = null;
		
		String sqlSeq = """
			select seq_goods.nextval from dual
		""";
		
		String sqlGoods = """
			insert into goods(goods_code, goods_name, goods_price, emp_code, point_rate, soldout, createdate)
			values(?, ?, ?, ?, ?, null, sysdate)	
		""";
		
		String sqlImg = """
			insert into goods_img(goods_code, filename, origin_name, content_type, filesize, createdate)
			values(?, ?, ?, ?, ?, sysdate)
		""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 단일 트랜잭션안에서 시퀀스 생성 -> 상품입력 -> 이미지입력
			
			// 1) seq_goods.nextval값을 먼저 생성 후 사용
			stmtSeq = conn.prepareStatement(sqlSeq);
			rs = stmtSeq.executeQuery();
			rs.next();
			int goodsCode = rs.getInt(1);
			
			// 2) goods 입력
			stmtGoods = conn.prepareStatement(sqlGoods);
			stmtGoods.setInt(1, goods.getGoodsCode());
			stmtGoods.setString(2, goods.getGoodsName());
			stmtGoods.setInt(3, goods.getGoodsPrice());
			stmtGoods.setInt(4, goods.getEmpCode());
			stmtGoods.setDouble(5, goods.getPointRate());
			int row1 = stmtGoods.executeUpdate();
			// 상품입력에 실패하면
			if(row1 != 1) {
				conn.rollback(); 
				return result;
			}
			// 3) // 상품입력에 성공하면 img 입력
			stmtImg = conn.prepareStatement(sqlImg);
			stmtImg.setInt(1, goods.getGoodsCode());
			stmtImg.setString(2, img.getFilename());
			stmtImg.setString(3, img.getOriginName());
			stmtImg.setString(4, img.getContentType());
			stmtImg.setLong(5, img.getFilesize());
			int row2 = stmtImg.executeUpdate();
			if(row2 != 1) {
				conn.rollback(); 
				return result;
				// throw new SQLException();
			}
			result = true; // 상품 & 이미지 입력성공
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(stmtSeq != null) stmtSeq.close();
				if(stmtGoods != null) stmtGoods.close();
				if(stmtImg != null) stmtImg.close();
				if(conn != null) conn.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}