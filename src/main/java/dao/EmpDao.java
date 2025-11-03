package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import dto.Emp;

public class EmpDao {
	// 로그인
	public Emp selectEmpByLogin(Emp paramE) throws Exception {
		 Connection conn = null;
	     PreparedStatement stmt = null;
	     ResultSet rs = null;
	     Emp e = null;
	     
	     String sql = """
	         SELECT 
	             EMP_CODE empCode,
	             EMP_ID empId,
	             EMP_NAME empName,
	             ACTIVE active,
	             CREATEDATE createdate
	         FROM EMP
	         WHERE EMP_ID = ? AND EMP_PW = ?  AND ACTIVE > 0
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
             e.setActive(String.valueOf(rs.getInt("active"))); // 숫자를 문자열로 변환 저장

             Timestamp ts = rs.getTimestamp("createdate");
             if (ts != null) {
                 e.setCreatedate(new java.util.Date(ts.getTime()));
             }
         }

         rs.close();
 		 stmt.close();
 		 conn.close();
 		 
 		 return e;
	}
}
