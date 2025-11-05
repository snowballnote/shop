package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 개발자가 commit / rollback 직접 구현이 필요
			ptmtCustomer = conn.prepareStatement(sqlCustomer); // customer 삭제
			
			// param 설정 // ?, ?, ?
			
			int row = ptmtCustomer.executeUpdate();
			if(row == 1) {
				ptmtOutId = conn.prepareStatement(sqlOutid);
				
				// param 설정 // ?, ?, ?
				
				ptmtOutId.executeUpdate(); // outid 입력
			} else {
				throw new SQLException();
			}
			conn.commit(); // 정상적으로 처리가 끝났을 떄만  commit
		} catch(SQLException e) {
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
	public List<Customer> selectCustomerList(int beginRow, int rowPerPage){
		return null;
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
