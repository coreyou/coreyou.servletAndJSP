<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    <%!	
    	String tableName = "userTest";
    	// 印出user這個資料表的內容
		void printUserTable(Connection con) {
			try {
				Statement stat = con.createStatement();
				ResultSet rs = stat.executeQuery("select * from " + tableName);
				System.out.println("======================================================");
				while (rs.next()) {
					System.out.println(rs.getString("userId") + "\t\t" +
				        rs.getString("userName") + "\t\t" + rs.getString("email"));
				}
				System.out.println("======================================================");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Connection Interface</title>		
	</head>
	<body>
		<h2>Connection and Statement/PreparedStatement</h2>
		<%
			PreparedStatement pstmt = null;	// PreparedStatement和Statement的差別在於: 會事先編譯，在重複呼叫時可以更有效率
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement();
			// 4. 透過Statement物件執行SQL敘述
			// 5. 取得執行後的ResultSet物件，或是被異動的資料筆數
			String sql = "insert into " + tableName + " values ('3', 'Peter', 'peter@gmail.com')";
			int intNo = stmt.executeUpdate(sql);	// > 0 表示新增成功
			printUserTable(con);
			// 6. 進行資料的處理
			if (intNo > 0) {
				out.println("新增一筆紀錄: ('3', 'Peter', 'peter@gmail.com')<hr />");
				sql = "update " + tableName + " set email=? where userId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "peter@hotmail.com");
				pstmt.setString(2, "3");
				intNo = pstmt.executeUpdate();	// > 0 表示更新成功
				if (intNo > 0) {
					out.println("更新一筆紀錄: ('3', 'Peter', 'peter@hotmail.com')<hr />");
				}
			}
			printUserTable(con);
			
			sql = "delete from " + tableName + " where userId='3'";
			intNo = stmt.executeUpdate(sql);
			if (intNo > 0) {	// > 0 表示刪除成功
				out.println("刪除一筆紀錄: userId='3'");
			}
			printUserTable(con);
			
			// 7. 關閉Statement物件
			if (stmt != null) stmt.close();
			if (pstmt != null) pstmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>