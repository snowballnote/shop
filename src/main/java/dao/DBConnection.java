package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConn() throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver"); // 또는 oracle.jdbc.OracleDriver
		Connection conn = DriverManager.getConnection(
		    "jdbc:oracle:thin:@localhost:1521:xe", // 11g XE는 :xe, 21c XE면 /XEPDB1
		    "gdj95",                                // ★ 앱 사용자
		    "java1234"                              // ★ 그 비번
		);
		return conn;
	}
}
