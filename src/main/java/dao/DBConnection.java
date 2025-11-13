package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConn() throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver"); // 또는 oracle.jdbc.OracleDriver
		Connection conn = DriverManager.getConnection(
		    "jdbc:oracle:thin:@localhost:1521:xe",
		    "GDJ95",
		    "java1234"
		);
		return conn;
	}
}
