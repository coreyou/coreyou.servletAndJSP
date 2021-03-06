package bean;

import java.sql.*;
/**
 * 在MVC中屬於Model的角色，這裡所定的元件都可以重複使用。
 * 
 * ae_javaBeanDBConnection.jsp使用此BEAN
 * 
 * @author coreyou
 *
 */
public class DBConnection {
	
	private Connection con = null;
	
	public void setConnection(String dbName, String user, String password) {
		String JDBCDriver = null, url = null;
		dbName = dbName.toLowerCase();
		
		// 傳進來的參數若含有mysql字串，則使用MySQL，否則使用Access
		if (dbName.indexOf("mysql") != -1) {	// MySQL
			JDBCDriver = "com.mysql.jdbc.Driver";
			url = "jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5";
		} else {	// Access
			JDBCDriver = "sun.jdbc.odbc.JdbcOdbcDriver";
			url = "jdbc:odbc:JSPAll";
		}
		
		try {
			Class.forName(JDBCDriver);
			if (user != null) {
				con = DriverManager.getConnection(url, user, password);
			} else {
				con = DriverManager.getConnection(url);
			}
		} catch (SQLException se) {
			System.out.println("SQL Error: " + se.toString());
			se.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Error: " + e.toString());
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() {
		return con;
	}
}
