package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao {
	// 아이디 중복 체크
	public boolean existsEmpId(String empId) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		boolean exists = false;
		
		String sql = "SELECT COUNT(*) cnt FROM emp WHERE emp_id = ?";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			exists = rs.getInt("cnt") > 0;
		}
		rs.close();
        stmt.close();
		conn.close();
		 
		return exists;
		
	}
	
	// 사원 등록 (active=1)
	public int insertEmp(Emp e) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		String sql = """
				INSERT INTO emp (
					emp_code, emp_id, emp_pw, emp_name, active, createdate
				) VALUES (
					seq_emp.NEXTVAL, ?, ?, ?, ?, SYSDATE
				)
			""";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEmpId());
		stmt.setString(2, e.getEmpPw());
		stmt.setString(3, e.getEmpName());
		stmt.setInt(4, e.getActive());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 활성/비활성 업데이트
	public int updateActive(int empCode, int active) throws Exception {
		Connection conn = null;
	    PreparedStatement stmt = null;
	    int row = 0;
	    
		String sql = "UPDATE emp SET active=? WHERE emp_code=?";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, active == 1 ? 1 : 0); // 1이 아니면 0으로 강제
		stmt.setInt(2, empCode);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 사원 목록
	public List<Emp> selectEmpListByPage(int beginRow, int rowPerPage) throws Exception {
		Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

		String sql = """
				SELECT emp_code empCode, emp_id empId, emp_name empName, active, createdate
				FROM emp
				ORDER BY emp_code
				OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
			""";
			// OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY; // 10행다음부터 10개의 행을 가져옴
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
        
        rs = stmt.executeQuery();
        List<Emp> list = new ArrayList<>();
        while(rs.next()) {
        	Emp e = new Emp();
        	e.setEmpCode(rs.getInt("empCode"));
        	e.setEmpId(rs.getString("empId"));
        	e.setEmpName(rs.getString("empName"));
        	e.setActive(rs.getInt("active"));
            e.setCreatedate(rs.getString("createdate"));

            
            list.add(e);
        }
        rs.close();
        stmt.close();
		conn.close();
		 
		return list;
	}
	
	// 전체 사원 수 (페이지 계산용)
	public int countEmp() throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		
		String sql = "SELECT COUNT(*) cnt FROM emp";
		
		conn = DBConnection.getConn();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			totalCount = rs.getInt("cnt");
		}
		rs.close();
        stmt.close();
		conn.close();
		
		return totalCount;
	}
	
	// 로그인
	public Emp selectEmpByLogin(Emp paramE) throws Exception {
		 Connection conn = null;
	     PreparedStatement stmt = null;
	     ResultSet rs = null;
	     Emp e = null;
	     
	     String sql = """
		         SELECT 
		             emp_code empCode,
		             emp_id empId,
		             emp_name empName,
		             active,
		             createdate 
		         FROM EMP
		         WHERE emp_id = ? AND emp_pw = ?  AND active = 1
		     """;
		
	     conn = DBConnection.getConn();
         stmt = conn.prepareStatement(sql);
         stmt.setString(1, paramE.getEmpId());
         stmt.setString(2, paramE.getEmpPw());
         
         rs = stmt.executeQuery();
         
         if (rs.next()) {
             e = new Emp();
             e.setEmpCode(rs.getInt("empCode"));
             e.setEmpId(rs.getString("empId"));
             e.setEmpName(rs.getString("empName"));
             e.setActive(rs.getInt("active"));
             e.setCreatedate(rs.getString("createdate"));
         }
         rs.close();
 		 stmt.close();
 		 conn.close();
 		 
 		 return e;
	}

}
