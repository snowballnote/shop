package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.Customer;

public class CustomerDao {
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
