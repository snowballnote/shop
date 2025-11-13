package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Address;
import dto.Customer;

public class AddressDao {
	// 주소 리스트(본인의)
	public List<Address> selectAddressList(int customerCode) throws Exception{
		Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<Address> list = new ArrayList<>();
	    
	    String sql = """
	    		SELECT
	    			  address_code  addressCode
	    			, customer_code customerCode
	    			, address
	    			, createdate
	    		FROM address
	    		WHERE customer_code = ?
	    		ORDER BY address_code
	    	""";
	    
	    try {
	    	conn = DBConnection.getConn();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerCode);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Address a = new Address();
				a.setAddressCode(rs.getInt("addressCode"));
				a.setCustomerCode(rs.getInt("customerCode"));
				a.setAddress(rs.getString("address"));
				a.setCreatedate(rs.getString("createdate"));
				
				list.add(a);
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
	
	// 주소 추가
	public int insertAddress(Address address) {
		Connection conn = null;
		PreparedStatement stmt1 = null; // 개수 조회
		PreparedStatement stmt2 = null; // 가장 오래된 주소 삭제
		PreparedStatement stmt3 = null; // insert
		ResultSet rs1 = null;
		int row = 0;
		
		// 해당 고객의 현재 주소 개수 조회
		String sql1 = """
					SELECT COUNT(*) FROM address WHERE customer_code=? 
				""";
		
		// 주소 개수가 5개 초과일 때 가장 오래된 주소(address_code가 가장 작은) 삭제
		// 특정 customer_code에 해당하는 주소만 삭제하도록 수정해야 함!
		String sql2 = """
					DELETE FROM address
					WHERE address_code = (SELECT MIN(address_code) FROM address WHERE customer_code = ?)
				""";
		
		// 새 주소 삽입
		String sql3 = """
					INSERT INTO address(address_code, customer_code, address, createdate)
					VALUES(seq_address.nextval, ?, ?, SYSDATE)
				""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false);
			
			// 주소 개수 조회 및 개수 초과 시 삭제 로직(이전과 동일)
			stmt1 = conn.prepareStatement(sql1);
			stmt1.setInt(1, address.getCustomerCode());
			rs1 = stmt1.executeQuery();
			rs1.next();
			int cnt = rs1.getInt(1);
			
			// 개수 초과시 가장 오래된 주소 삭제
			if(cnt >= 5) { // 5개면 가장 오래된 주소 삭제 후 입력 sql2 쿼리 호출
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, address.getCustomerCode()); // 삭제할 주소의 customerCode
                stmt2.executeUpdate();
			}
			
			// 새 주소 삽입
			stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, address.getCustomerCode());
			stmt3.setString(2, address.getAddress());
			row = stmt3.executeUpdate(); // 삽입된 행 수 저장
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
		}finally { // finally 자원해지(close()) null 유무 확인 후 해지
			try {
				if(rs1 != null) rs1.close();
				if(stmt1 != null) stmt1.close();
				if(stmt2 != null) stmt2.close();
				if(stmt3 != null) stmt3.close();
				if(conn != null) conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
}
