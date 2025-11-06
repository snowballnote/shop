package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Address;

public class AddressDao {
	public int insertAddress(Address address) {
		Connection conn = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		ResultSet rs1 = null;
		
		String sql1 = """
					SELECT COUNT(*) FROM address WHERE customer_code=? 
				""";
		
		String sql2 = """
					delete from address
					where address_code = (select min(address_code) from Address)
				""";
		
		String sql3 = """
					INSERT INTO address(address_code, customer_code, address, createdate)
					VALUES(?, ?, ?, sysdate)
				""";
		
		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false);
			stmt1 = conn.prepareStatement(sql1);
			rs1 = stmt1.executeQuery();
			rs1.next();
			int cnt = rs1.getInt(1);
			
			if(cnt > 4) { // 5개면 가장 오래된 주소 삭제 후 입력 sql2 쿼리 호출
				stmt2 = conn.prepareStatement(sql2);
				stmt1.executeUpdate(sql2);
			}
			
			stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, address.getAddressCode());
			stmt3.setString(2, address.getAddress());
			int row = stmt3.executeUpdate();
			
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
		
		return 0;
	}
}
