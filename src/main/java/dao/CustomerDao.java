package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Customer;
import dto.Outid;

public class CustomerDao {
	// 직원에 의해 강제탈퇴
	public void deleteCustomerByEmp(Outid outid) throws Exception {
		Connection conn = null;
		PreparedStatement ptmtCustomer = null;
		PreparedStatement ptmtOutId = null;
		ResultSet rs = null;
				
		String sqlCustomer = """
				DELETE FROM customer WHERE customer_id=?
			""";
		String sqlOutid = """
				INSERT INTO outid(id, memo, createdate)
				VALUES(?, ?, ?)
			""";

		
		// JDBC connection의 기본 Commit설정값 auto commit = true : false 변경 후 transaction 적용
		// 개발자가 commit / rollback을 직접 제어 (트랜잭션 적용)
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false);
			// customer 삭제
			ptmtCustomer = conn.prepareStatement(sqlCustomer);
			ptmtCustomer.setString(1, outid.getId()); // 삭제할 고객 ID
			int row = ptmtCustomer.executeUpdate();
			
			// outid 테이블에 기록 (강제 탈퇴 정보 저장)
			if(row == 1) {
				ptmtOutId = conn.prepareStatement(sqlOutid);
				ptmtCustomer.setString(1, outid.getId());
				ptmtCustomer.setString(2, outid.getMemo());
				ptmtOutId.setString(3, outid.getCreatedate());
				
				ptmtOutId.executeUpdate();
			} else {
				throw new SQLException("고객 삭제 실패: customer_id 없음");
			}
			
			// commit (모든 작업이 정상 완료된 경우만)
			conn.commit();
		} catch(SQLException e) {
			// 예외 발생 시 rollback
			try {
				conn.rollback();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();		
		} finally{
			try {
				// 순서
				ptmtCustomer.close();
				ptmtOutId.close();
				conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
	
	// 직원 로그인시 전체 고객 리스트 확인
	public List<Customer> selectCustomerList(int beginRow, int rowPerPage) throws Exception{
		Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<Customer> list = new ArrayList<>();
	    
	    String sql = """
	    		SELECT 
		    		customer_code customerCode, 
		    		customer_id customerId, 
		    		customer_name customerName, 
		    		customer_phone customerPhone, 
		    		point, createdate
				FROM customer
				ORDER BY customer_code
				OFFSET ? ROWS FETCH NEXT ? ROWS ONLY			
	    	""";
	    
	    // JDBC connection의 기본 Commit설정값 auto commit = true : false 변경 후 transaction 적용
	    try {
	    	conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Customer c = new Customer();
				c.setCustomerCode(rs.getInt("customerCode"));
				c.setCustomerId(rs.getString("customerId"));
				c.setCustomerName(rs.getString("customerName"));
				c.setCustomerPhone(rs.getString("customerPhone"));
				c.setPoint(rs.getInt("point"));
				c.setCreatedate(rs.getString("createdate"));
				
				list.add(c);
			}
	    } catch(SQLException e) {
	    	e.printStackTrace();	
	    }finally {
	    	try {
	    		rs.close();
		    	stmt.close();
		    	conn.close();
		    }catch(SQLException e1) {
	    	e1.printStackTrace();	
		    }
	    }
	 	return list;
	}
	
	// 전체 직원 수 (페이지 계산용)
	public int countCustomer() throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int total = 0;
		
		String sql = "SELECT COUNT(*) cnt FROM customer";
		
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
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return total;
	}
	
	// 로그인
	public Customer selectCustomerByLogin(Customer paramC) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Customer c = null;
		
		String sql = """
				SELECT 
					customer_code customerCode,
	                customer_id customerId,
	                customer_pw customerPw,
	                customer_name customerName,
	                customer_phone customerPhone,
	                point,
	                createdate
	            FROM customer
	            WHERE customer_id = ? AND customer_pw = ?
	        """;
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramC.getCustomerId());
		stmt.setString(2, paramC.getCustomerPw());
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			c = new Customer();
			c.setCustomerCode(rs.getInt("customerCode"));
            c.setCustomerId(rs.getString("customerId"));
            c.setCustomerName(rs.getString("customerName"));
            c.setCustomerPhone(rs.getString("customerPhone"));
            c.setPoint(rs.getInt("point"));
            c.setCreatedate(rs.getString("createdate"));
		}

		rs.close();
		stmt.close();
		conn.close();
        
        return c;
	}
	
	// 아이디 중복 체크
	public boolean existsCustomerId(String id) throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean result = false;
        
        String sql = "SELECT 1 FROM customer WHERE customer_id=?";
        
        conn = DBConnection.getConn();
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        
        rs = stmt.executeQuery();
        if(rs.next()) {
        	result = true; // 중복된 아이디 존재
        }
        
        rs.close();
        stmt.close();
        conn.close();

        return result;
	}
	
	public int insertCustomer(Customer c) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = """
				INSERT INTO customer (
					customer_code, customer_id, customer_pw , customer_name, customer_phone, 
	                point,
	                createdate 
				) VALUES (
					seq_customer.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE
				)
			""";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCustomerId());
		stmt.setString(2, c.getCustomerPw());
		stmt.setString(3, c.getCustomerName());
		stmt.setString(4, c.getCustomerPhone());
        
		row = stmt.executeUpdate(); // insert 실행
		
		stmt.close();
		conn.close();
		
		return row;
	}	
}
