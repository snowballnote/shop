package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import dto.Emp;

public class EmpDao {
	// 사원 목록
	public List<Emp> selectEmpListByPage(int beginRow, int rowPerPage) throws Exception {
		Connection conn = null;
	    PreparedStatement ptmt = null;
	    ResultSet rs = null;

		String sql = """
				SELECT emp_code empCode, emp_id empId, emp_name empName, active, createdate
				FROM emp
				ORDER BY emp_code
				OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
			""";
			// OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY; // 10행다음부터 10개의 행을 가져옴
		
		conn = DBConnection.getConn();
		ptmt = conn.prepareStatement(sql);
		ptmt.setInt(1, beginRow);
		ptmt.setInt(2, rowPerPage);
        
        rs = ptmt.executeQuery();
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
		ptmt.close();
		conn.close();
		 
		return list;
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
		         WHERE emp_id = ? AND emp_pw = ?  AND active > 0
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
