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
		PreparedStatement psDel = null; // delete
		PreparedStatement psIns = null; // insert

		String sqlCustomer = "UPDATE customer SET status = 'FORCE_OUT' WHERE customer_id = ?";
		// createdate는 DB에서 SYSDATE로 채움
		String sqlOutid   = "INSERT INTO outid (id, memo, createdate) VALUES (?, ?, SYSDATE)";

		try {
			conn = DBConnection.getConn();
			conn.setAutoCommit(false); // 트랜잭션 시작

			// 고객 삭제
			psDel = conn.prepareStatement(sqlCustomer);
			psDel.setString(1, outid.getId().trim());
			int row = psDel.executeUpdate();
			System.out.println("[DELETE customer] id=" + outid.getId() + ", row=" + row);
			if (row != 1) {
				// 대상이 없거나 조건 불일치 → 롤백 후 예외
				conn.rollback();
				throw new SQLException("고객 삭제 실패 또는 대상 없음: " + outid.getId());
			}

			// 탈퇴 기록 (outid)
			psIns = conn.prepareStatement(sqlOutid);
			psIns.setString(1, outid.getId().trim());
			psIns.setString(2, outid.getMemo() == null ? "" : outid.getMemo());
			int ins = psIns.executeUpdate();
			System.out.println("[INSERT outid] id=" + outid.getId() + ", row=" + ins);

			// 모두 성공하면 커밋
			conn.commit();

		} catch (SQLException e) { // 이부분에서 
			// 예외 시 트랜잭션 롤백 + 예외 전파(컨트롤러에서 처리)
			if (conn != null) try { conn.rollback(); } catch (SQLException ignore) {}
			throw e;
		} finally {
			// NPE 방지 null 체크 후 close
			if (psIns != null) try { psIns.close(); } catch (SQLException ignore) {}
			if (psDel != null) try { psDel.close(); } catch (SQLException ignore) {}
			if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
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
	                  customer_code customerCode
	                , customer_id customerId
	                , customer_name customerName
	                , customer_phone customerPhone
	                , point
	                , createdate 
	            FROM customer
	            WHERE status = 'ACTIVE'
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
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
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
		
		String sql = "SELECT COUNT(*) cnt FROM customer WHERE status = 'ACTIVE'";
		
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
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
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
					customer_code customerCode
	                , customer_id customerId
	                , customer_pw customerPw
	                , customer_name customerName
	                , customer_phone customerPhone
	                , point
	                , createdate 
	            FROM customer
	            WHERE customer_id = ? AND customer_pw = ?
	        """;
		
		try {
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

                return c; // 로그인 성공
            }
            return null; // 로그인 실패
        } finally {
        	try {
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
			}
        }
	}
	
	// 아이디 중복 체크
	public boolean existsCustomerId(String id) throws Exception {
		Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean result = false;
        
        String sql = "SELECT 1 FROM customer WHERE customer_id=?";

        try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            
            return rs.next();
        } finally {
        	try {
				 if (rs != null) rs.close();
				 if (stmt != null) stmt.close();
				 if (conn != null) conn.close();
			}catch(SQLException e) {					
				e.printStackTrace();
			}
        }
	}
	
	public int insertCustomer(Customer c) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = """
				INSERT INTO customer (
					customer_code, customer_id, customer_pw , customer_name, customer_phone, 
	                point,
	                createdate 
				) VALUES (
					seq_customer.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE
				)
			""";
		
		try {
            conn = DBConnection.getConn();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, c.getCustomerId());
            stmt.setString(2, c.getCustomerPw());   // 추후 해시 예정
            stmt.setString(3, c.getCustomerName());
            stmt.setString(4, c.getCustomerPhone());
            
            return stmt.executeUpdate();
        } finally {
        	if (stmt != null) stmt.close();
			if (conn != null) conn.close();
        }
	}	
}
