package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Notice;

public class NoticeDao {
	public List<Notice> selectNoticeList(int beginRow, int rowPerPage) throws Exception{
	    List<Notice> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    String sql = """
	            SELECT
	                  notice_code noticeCode
	                , notice_title noticeTitle
	                , notice_content noticeContent
	                , emp_code empCode
	                , createdate
	            FROM notice
	            ORDER BY notice_code DESC
	            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
	        """;
	    
	    try {
	    	conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeCode(rs.getInt("noticeCode"));
				n.setNoticeTitle(rs.getString("noticeTitle"));
				n.setCreatedate(rs.getString("createdate"));
				
				list.add(n);
			}
	    } catch(SQLException e1) {
	    	e1.printStackTrace();	
	    }finally {
	    	if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
	    }
	 	return list;
	}
	
	// /emp/noticeList
	public int countNotice() {
		int count = 0;
		Notice resultNotice = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = """
				SELECT COUNT(*) FROM notice
			""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e1) {
			e1.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			}catch(SQLException e2) {					
				e2.printStackTrace();
			}
		}
		
		return count;
	}

	// /emp/insetNotice
	public int insertNotice(Notice n) {
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = """
				INSERT INTO notice (
					notice_code, notice_title, notice_content, emp_code, createdate
				) VALUES (
					seq_notice.NEXTVAL, ?, ?, ?, SYSDATE
				)
			""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, n.getNoticeTitle());
			stmt.setString(2, n.getNoticeContent());
			stmt.setInt(3, n.getEmpCode());
			
			row = stmt.executeUpdate();
		} catch(Exception e1) {
			// conn.rollback();
			e1.printStackTrace();
		}finally {
			try {
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e2) {					
				e2.printStackTrace();
			}
		}
		
		return row;
	}
	
	// /emp/noticeOne
	public Notice selectNoticeOne(int noticeCode) {
		Notice resultNotice = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = """
				SELECT
					notice_code noticeCode
	                , notice_title noticeTitle
	                , notice_content noticeContent
	                , emp_code empCode
	                , createdate
	            FROM notice
	            WHERE notice_code=?
			""";
		
		try {
			conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeCode);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultNotice = new Notice();
				resultNotice.setNoticeCode(rs.getInt("noticeCode"));
				resultNotice.setNoticeTitle(rs.getString("noticeTitle"));
				resultNotice.setNoticeContent(rs.getString("noticeContent"));
				resultNotice.setEmpCode(rs.getInt("empCode"));
				resultNotice.setCreatedate(rs.getString("createdate"));
			}	
		} catch(Exception e1) {
			e1.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			}catch(SQLException e2) {					
				e2.printStackTrace();
			}
		}
		
		return resultNotice;
	}
	
	// /emp/deleteNotice
	public int deleteNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				
			
			""";
		
		try {
			
		} catch(Exception e1) {
			// conn.rollback();
			e1.printStackTrace();
		}finally {
			try {
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e2) {					
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// /emp/modifyNotice
	public int updateNotice(Notice n) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = """
				UPDATE notice
				SET notice_title=?
					, notice_content=?
					, updatedate=NOW()
				WHERE notice_code=?
			""";
		
		try {
			conn = DBConnection.getConn();
	        conn.setAutoCommit(false);

	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, n.getNoticeTitle());
	        stmt.setString(2, n.getNoticeContent());
	        stmt.setInt(3, n.getNoticeCode());
	        
	        row = stmt.executeUpdate(); // 1=성공, 0=권한 불일치 또는 없음
	        conn.commit();		
		} catch(Exception e1) {
			try {
	            if (conn != null) conn.rollback();   // 실패 시 롤백
	        } catch (SQLException ignore) {}
	        e1.printStackTrace();
		} finally {
			try {
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e2) {					
				e2.printStackTrace();
			}
		}
		return row;
	}

}
