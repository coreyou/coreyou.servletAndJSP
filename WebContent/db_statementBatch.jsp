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
		<title>addBatch(), executeBatch(), clearBatch()</title>		
	</head>
	<body>
		<h2>addBatch(), executeBatch(), clearBatch()</h2>
		<%
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement();
			
			System.out.println("新增三筆資料前:");
			printUserTable(con);
			
			out.println("<h2>加入三筆SQL敘述至批次清單</h2>");
			String sql = "insert into " + tableName + " values('4', 'John', 'john@gmail.com')";
			stmt.addBatch(sql);
			out.println("<p>" + sql + "</p>");
			sql = "insert into " + tableName + " values('5', 'Ken', 'ken@gmail.com')";
			stmt.addBatch(sql);
			out.println("<p>" + sql + "</p>");
			sql = "insert into " + tableName + " values('6', 'Sonic', 'sonic@gmail.com')";
			stmt.addBatch(sql);
			out.println("<p>" + sql + "</p><hr />");
			
			try {
				int intCount[] = stmt.executeBatch();
				if (intCount.length > 0) {
					for (int i = 0; i < intCount.length; i++) {
						switch (intCount[i]) {
							case Statement.SUCCESS_NO_INFO:
								out.println("第 " + (i+1) + " 筆執行成功，但無回傳值!<br />");
								break;
							case Statement.EXECUTE_FAILED:
								out.println("第 " + (i+1) + " 筆執行失敗!<br />");
							default:
								out.println("第 " + (i+1) + " 筆執行成功，更新 " + intCount[i] + " 筆紀錄!<br />");
						}
					}
					out.println("<hr />");
				}	
			} catch (SQLException se) {
				out.println("SQL Exception: <br /><font color='red'>" + se.toString() + "</font><hr />");
			}
			
			System.out.println("新增三筆資料後:");
			printUserTable(con);
			
			out.println("<h2>清除SQL批次清單與紀錄</h2>");
			stmt.clearBatch();
			sql = "delete from " + tableName + " where (userId >= 4 && userId <= 6)";
			int intNo = stmt.executeUpdate(sql);	// > 0 表示刪除成功
			if  (intNo > 0) {
				out.println("<p>刪除 " + intNo + " 筆記錄成功!</p><br />");
			}
			
			System.out.println("刪除三筆資料後:");
			printUserTable(con);
			
			// 7. 關閉Statement物件
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>